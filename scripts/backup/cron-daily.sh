#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.backup

TMP="/backup"
DEST="/backup/daily"

backup_encrypt_directory $TMP $DEST /etc etc.tar
backup_encrypt_directory $TMP $DEST /var/log var_log.tar
backup_encrypt_directory $TMP $DEST /var/www var_www.tar
backup_encrypt_directory $TMP $DEST /srv/apps/logs srv_apps_logs.tar
backup_encrypt_directory $TMP $DEST /srv/apps/mfs srv_apps_mfs.tar
backup_encrypt_directory $TMP $DEST /srv/apps/samba srv_apps_samba.tar
backup_encrypt_directory $TMP $DEST /var/lib/mfs var_lib_mfs.tar
backup_encrypt_directory $TMP $DEST /var/lib/samba var_lib_samba.tar

for D in `ls /srv/sites`; do
	if [ ! -f /srv/sites/$D/.nobackup ] && [ ! -f /srv/sites/$D/.weekly ]; then
		backup_encrypt_directory $TMP $DEST /srv/sites/$D srv_sites_$D.tar
	fi
done
