#!/bin/bash
# Konfiguracja tworzenia kopii zapasowych

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom



if [ "$HWTYPE" = "container" ]; then
	echo "skipping gpg backup encryption key configuration"
	exit 0
fi


if [ -d /.gnupg ] && [ ! -h /.gnupg ] && [ ! -d /root/.gnupg ]; then
	echo "applying fix for Proxmox VE 3.x key setup bug"
	mv -f /.gnupg /root
	ln -sf /root/.gnupg /.gnupg
fi

keyname=`gpg_backup_key`

if [ "`gpg --list-keys |grep $keyname`" = "" ]; then
	echo "setting up gpg backup encryption key"
	gpg --import $common/gpg/$keyname.pub

	echo "##########################################################"
	echo "# Backup public key imported. Now enter 'trust' command  #"
	echo "# at the below command prompt, and set trust level to 5. #"
	echo "##########################################################"

	gpg --edit-key $keyname

	if [ "$OSTYPE" = "redhat" ]; then
		echo "applying fix for RHEL 6.x crontab bug"
		if [ -d /.gnupg ] && [ ! -h /.gnupg ]; then
			mv -f /.gnupg /.gnupg-orig
		fi
		ln -sf /root/.gnupg /.gnupg
	fi
fi
