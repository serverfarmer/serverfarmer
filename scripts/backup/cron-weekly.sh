#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.backup
. /opt/farm/scripts/functions.mysql

TMP="`local_backup_directory`"
DEST="$TMP/weekly"

backup_encrypt_directory $TMP $DEST /boot boot.tar

for D in `ls /srv/apps 2>/dev/null`; do
	backup_encrypt_directory_weekly $TMP $DEST /srv/apps/$D srv_apps_$D.tar
done

for D in `ls /srv/sites 2>/dev/null`; do
	backup_encrypt_directory_weekly $TMP $DEST /srv/sites/$D srv_sites_$D.tar
done

for D in `ls /home`; do
	if [ "`ls /home/$D/`" != "" ]; then
		backup_encrypt_directory $TMP $DEST /home/$D home_$D.tar
	fi
done

if [ -f /etc/mysql/debian.cnf ] && [ -f /var/run/mysqld/mysqld.pid ]; then
	pass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
	backup_mysql 127.0.0.1 3306 debian-sys-maint $pass mysql $TMP $DEST
fi
