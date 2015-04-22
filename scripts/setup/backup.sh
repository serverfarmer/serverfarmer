#!/bin/sh
# Konfiguracja tworzenia kopii zapasowych

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping system backup configuration"
else

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

	echo "preparing ssh key"
	DOMAIN=`hostname |cut -d . -f 2`

	if [ "$DOMAIN" = "dc1" ]; then
		SSHKEY="AAAAB3NzaC1yc2EAAAADAQABAAABAQCqyY086f5HgRIlElfxEXcH2fl3Srq0W7zFeYoiCVvV3MePu7kQfP4Lbnz7HQtE+QSXq82ucEx3a9w4v4YwnkY8KQS6ntWNUbiKSy3ABJxlIUVc8iU18bo9Xiu4+cVeHZIWCv2iZgrWtqOvEnmPuWhaS1vTyr4KwR+f2V+bSmPJs3joyStUE9gt2Dca2y3gxpXcCLC4XMmslL1DSX8U8CvpZ+yM/CNmHCh1hSlrOB8VRHMQ+ZZ7Hktvif7UkroNpDHa4/A9PLLHhFlnQ1H/ra+Zzlmc0ItHZoi5GgLTq3FpurAQO4clVfhmxn5BLOV4UqY6ohSHORdsMk0VqhYNxsON"
	elif [ "$DOMAIN" = "biuro" ]; then
		SSHKEY="AAAAB3NzaC1yc2EAAAADAQABAAABAQCf9JW1hoE7oeRNj2oPDDtz58+MaWt20G2sUTpOKDTcfyCt0Tpsd6nIqjM8luiP0ReNyYAxG+Z96bT5MUHlzJy8+98E80BRSfPmK4zH1BT42ymAvUdBsqs1ZKMuTwpdusYdsuOul+R8PF+6JmthYIqax1q6kTwSgpFGEZaW/OvpHjxDQ6qB5fctKR5lX9XKmHhsHVhUBqdQYP8AKRFG3tI+t1PX6pDIFp/WSCsW/ykG57bUFwk8SpLKj1P12GGR/izoqbvnbACcJM1mZCQIEeKv9YW/jDLNoupLSmOFnZ95glEi8Aygg3z+AO6pEYmxbMwM7auLdmfsLr/+xlysO72t"
	else
		SSHKEY="AAAAB3NzaC1yc2EAAAADAQABAAABAQDe2h6OxUljNEf/wqPhrXLYBW6+jfANMCXJu2oWZPk0OwcMjSVd8QRzULW7Ytlstprnx0NqRvvewi+SV3bMJxqE35yhiG+zd2evT6lZx01b0uM/tp/NyfLZ/Kt24OpH12DUSa1a5uP8ic8zHDzUc+dGfa99FpN3TIvux2H7bnaXTFY9HPmkkb4p9j3FcuHtQdtTVVU/a5JUvZT842XawQKDHen+BDg4wR45r7yKTnY4x8VXwg2DAprbjVzFmtILOyLBu5QjlEwSpOWFvuQmEOfY9zQ6KQ7IFgePzGl6BRxdi0I4nqhqj+3oMNEH1T5q7hdRY4yjkh0RXeJzA+eydq6r"
	fi

	FULLKEY="ssh-rsa $SSHKEY root@sauron.dom"
	AUTHKEYS="/root/.ssh/authorized_keys"

	if [ ! -f $AUTHKEYS ] || [ "`cat $AUTHKEYS |grep \"$SSHKEY\"`" = "" ]; then
		echo "setting up root ssh key"
		echo "$FULLKEY" >$AUTHKEYS
	fi

	if [ "$OSTYPE" = "debian" ] && [ ! -f /var/backups/.ssh/authorized_keys ]; then
		echo "setting up backup ssh key"
		mkdir -p /var/backups/.ssh
		echo "$FULLKEY" >/var/backups/.ssh/authorized_keys
	fi
fi
