#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.backup
. /opt/farm/scripts/functions.mysql
. /opt/farm/scripts/functions.postgres

TMP="`local_backup_directory`"
DEST="$TMP/weekly"

for D in `/opt/farm/scripts/backup/directories.sh`; do
	if [ ! -f $D/.nobackup ] && [ -f $D/.weekly ]; then
		backup_directory $TMP $DEST $D
	fi
done

for D in `ls /home`; do
	if [ "`ls /home/$D`" != "" ]; then
		backup_directory $TMP $DEST /home/$D
	fi
done

if [ -f /etc/mysql/debian.cnf ] && [ -f /var/run/mysqld/mysqld.pid ]; then
	pass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
	backup_mysql 127.0.0.1 3306 debian-sys-maint $pass mysql $TMP $DEST
fi

if [ -x /usr/bin/psql ] && [ -x /usr/bin/pg_dump ]; then
	dbs=`pg_list_local_databases`
	for db in $dbs; do
		fname="postgres-$db.sql.gpg"
		sudo -u postgres pg_dump -c -i $db |gpg --encrypt --no-armor --recipient `gpg_backup_key` --output $TMP/$fname --batch
		mv -f $TMP/$fname $DEST/$fname 2>/dev/null
	done
fi
