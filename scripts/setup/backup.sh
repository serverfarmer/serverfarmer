#!/bin/sh
# Konfiguracja tworzenia kopii zapasowych

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping system backup configuration"
else

	if [ -d /.gnupg ] && [ ! -d /root/.gnupg ]; then
		echo "applying fix for Proxmox VE 3.x key setup bug"
		mv -f /.gnupg /root
		ln -sf /root/.gnupg /.gnupg
	fi

	if [ "`gpg --list-keys |grep backup@tomaszklim.pl`" = "" ]; then
		echo "setting up gpg backup encryption key"
		gpg --import $common/backup.pub

		echo "##########################################################"
		echo "# Backup public key imported. Now enter 'trust' command  #"
		echo "# at the below command prompt, and set trust level to 5. #"
		echo "##########################################################"

		gpg --edit-key backup@tomaszklim.pl

		if [ "$OSTYPE" = "redhat" ]; then
			echo "applying fix for RHEL 6.x crontab bug"
			if [ -d /.gnupg ]; then mv -f /.gnupg /.gnupg-orig; fi
			ln -sf /root/.gnupg /.gnupg
		fi
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
fi
