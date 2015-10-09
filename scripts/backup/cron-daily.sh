#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.backup

TMP="`local_backup_directory`"
DEST="$TMP/daily"

backup_encrypt_directory $TMP $DEST /etc etc.tar
backup_encrypt_directory $TMP $DEST /var/lib/mfs var_lib_mfs.tar
backup_encrypt_directory $TMP $DEST /var/lib/samba var_lib_samba.tar
backup_encrypt_directory $TMP $DEST /var/log var_log.tar
backup_encrypt_directory $TMP $DEST /var/www var_www.tar

for D in `ls /srv/apps 2>/dev/null`; do
	backup_encrypt_directory_daily $TMP $DEST /srv/apps/$D srv_apps_$D.tar
done

for D in `ls /srv/sites 2>/dev/null`; do
	backup_encrypt_directory_daily $TMP $DEST /srv/sites/$D srv_sites_$D.tar
done
