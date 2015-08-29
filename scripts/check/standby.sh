#!/bin/sh
. /opt/farm/scripts/functions.custom

# skrypt sprawdza co pół godziny, które dyski w obudowach zewnętrznych, z tendencją
# do przegrzewania się, nie są aktualnie w trybie standby - jeśli taki wykryje,
# cron wysyła maila z ostrzeżeniem
# Tomasz Klim, kwiecień 2014, marzec 2015


# crontab -e (jako root):
#   */30 * * * * root /opt/farm/scripts/check/standby.sh


devices=`cat /opt/farm/common/standby.conf |grep -v ^# |grep -v ^$`

for diskid in $devices; do
	device="/dev/disk/by-id/$diskid"
	if [ -h $device ] && [ "`hdparm -C $device 2>&1 |grep standby`" = "" ]; then
		smartctl -d sat -T permissive -a $device |mail -s "$device is not in standby mode" smart-alerts@`owner_domain`
	fi
done


# wymuszenie trybu standby:
# hdparm -y /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# sprawdzenie bieżącego trybu, w jakim jest dysk:
# hdparm -C /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# wyłączenie timera usypiającego dysk po czasie nieaktywności:
# sdparm --clear STANDBY -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# włączenie tego timera i przywrócenie pozostałych ustawień domyślnych
# (bez ustawień domyślnych na dyskach Xtreme timer się nie włączał po wcześniejszym wywołaniu --clear):
# sdparm --defaults     --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME
# sdparm --set SCT=3000 --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# sprawdzenie, czy timer jest aktywny i na ile ustawiony (3000 = 5 minut):
# sdparm --get SCT --page=po -6 /dev/disk/by-id/ata-ST4000DM000-1F2168_W300H7ME

# uwaga: jeśli dysk po przełączeniu w tryb standby po chwili się budzi, powodem może być proces
# ext4lazyinit, działający przez jakiś czas po oddaniu nowego systemu plików ext4 do użytku
