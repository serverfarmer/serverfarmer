#!/bin/bash
# Konfiguracja tworzenia kopii zapasowych

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping system backup configuration"
	exit 0
fi


if [ "$OSTYPE" = "debian" ]; then
	owner="backup:backup"
else
	owner="root:root"
fi

path=`local_backup_directory`

echo "setting up backup directories"
mkdir -p     $path/daily $path/weekly $path/custom
chmod 0700   $path/daily $path/weekly $path/custom
chown $owner $path/daily $path/weekly $path/custom

echo "setting up backup scripts"
install_link /opt/farm/scripts/backup/cron-daily.sh /etc/cron.daily/backup
install_link /opt/farm/scripts/backup/cron-weekly.sh /etc/cron.weekly/backup

if [ -d /boot ] && [ ! -h /boot ] && [ "`ls -A /boot |grep -v lost+found`" != "" ]; then
	echo "setting up /boot directory backup policy"
	touch /boot/.weekly
fi
