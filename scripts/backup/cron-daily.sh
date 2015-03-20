#!/bin/sh
. /opt/farm/scripts/functions.backup

TMP="/backup"
DEST="/backup/daily"

backup_encrypt_directory $TMP $DEST /etc etc.tar
backup_encrypt_directory $TMP $DEST /var/log var_log.tar
backup_encrypt_directory $TMP $DEST /var/www var_www.tar
backup_encrypt_directory $TMP $DEST /srv/apps/logs srv_apps_logs.tar
backup_encrypt_directory $TMP $DEST /srv/apps/mfs srv_apps_mfs.tar
backup_encrypt_directory $TMP $DEST /srv/apps/samba srv_apps_samba.tar
backup_encrypt_directory $TMP $DEST /srv/sites/akomail srv_sites_akomail.tar
backup_encrypt_directory $TMP $DEST /srv/sites/cacti srv_sites_cacti.tar
backup_encrypt_directory $TMP $DEST /srv/sites/crm srv_sites_crm.tar
backup_encrypt_directory $TMP $DEST /srv/sites/kamery srv_sites_kamery.tar
backup_encrypt_directory $TMP $DEST /srv/sites/seopanel srv_sites_seopanel.tar
backup_encrypt_directory $TMP $DEST /srv/sites/ssl srv_sites_ssl.tar
backup_encrypt_directory $TMP $DEST /srv/sites/sslredu srv_sites_sslredu.tar
backup_encrypt_directory $TMP $DEST /srv/sites/storage srv_sites_storage.tar
backup_encrypt_directory $TMP $DEST /srv/sites/zabawki srv_sites_zabawki.tar
backup_encrypt_directory $TMP $DEST /var/lib/mfs var_lib_mfs.tar
backup_encrypt_directory $TMP $DEST /var/lib/samba var_lib_samba.tar

