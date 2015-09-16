#!/bin/bash
# Konfiguracja usług związanych z monitoringiem serwera w Cacti

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping cacti integration"
else
	mkdir -p /var/cache/cacti

	if [ ! -f /root/.ssh/id_cacti ]; then
		echo "generating ssh key for cacti-external user"
		ssh-keygen -t rsa -f /root/.ssh/id_cacti -P ""

		echo "key generated, now paste the following public key into `cacti_ssh_target`/.ssh/authorized_keys file:"
		cat /root/.ssh/id_cacti.pub
	fi

	if ! grep -q /opt/farm/scripts/ /etc/crontab; then
		echo "setting up crontab entries template"
		cat <<- _EOF_ >>/etc/crontab

			#
			# The below template has been inserted by Cacti setup.
			# Please adjust it according to server type and role.
			#
			# MAILTO=cron@`external_domain`
			#
			# */5  * * * * root /opt/farm/scripts/cacti/mta-helper.sh
			# */5  * * * * root /opt/farm/scripts/cacti/smart-helper.sh
			# */5  * * * * root /opt/farm/scripts/cacti/thermal-helper.sh
			# 1    * * * * root /opt/farm/scripts/cacti/disklabel-helper.sh
			# 22   1 * * * root /opt/farm/scripts/check/security.sh
			# */30 * * * * root /opt/farm/scripts/check/standby.sh
			# 3    6 * * * root /opt/farm/scripts/check/clock.sh
		_EOF_
	fi

	if [ "$OSTYPE" = "debian" ] && [ ! -d /usr/local/cpanel ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
		echo "############################################################################"
		echo "# add the following line to /etc/rc.local file:                            #"
		echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
		echo "############################################################################"
	fi
fi

