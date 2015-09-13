#!/bin/bash
# Konfiguracja tworzenia kopii zapasowych

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping system backup configuration"
	exit 0
fi


echo "setting up backup directories"
mkdir -p   /backup/daily /backup/weekly /backup/custom
chmod 0700 /backup/daily /backup/weekly /backup/custom

if [ "$OSTYPE" = "debian" ]; then
	chown root:root /backup
	chown backup:backup /backup/daily /backup/weekly /backup/custom
else
	chown root:root /backup /backup/daily /backup/weekly /backup/custom
fi

echo "setting up backup scripts"
install_link /opt/farm/scripts/backup/cron-daily.sh /etc/cron.daily/backup
install_link /opt/farm/scripts/backup/cron-weekly.sh /etc/cron.weekly/backup
