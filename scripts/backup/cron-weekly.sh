#!/bin/sh
. /opt/farm/scripts/functions.backup
. /opt/farm/scripts/functions.mysql

TMP="/backup"
DEST="/backup/weekly"

backup_encrypt_directory $TMP $DEST /boot boot.tar
backup_encrypt_directory $TMP $DEST /srv/apps/motion srv_apps_motion.tar
backup_encrypt_directory $TMP $DEST /srv/sites/beta srv_sites_beta.tar
backup_encrypt_directory $TMP $DEST /srv/sites/tomekwiki srv_sites_tomekwiki.tar
backup_encrypt_directory $TMP $DEST /home/tomek home_tomek.tar


if [ -f /etc/mysql/debian.cnf ] && [ -f /var/run/mysqld/mysqld.pid ]; then
	pass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
	backup_mysql 127.0.0.1 3306 debian-sys-maint $pass mysql $TMP $DEST
fi

