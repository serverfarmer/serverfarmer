#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" != "container" ]; then

	if ! grep -q /opt/farm/scripts/ /etc/crontab; then
		echo "setting up crontab entries template"
		cat <<- _EOF_ >>/etc/crontab

			#
			# The below template has been inserted by Server Farmer.
			#
			# MAILTO=cron@`external_domain`
			#
			3  6 * * * root /opt/farm/scripts/check/clock.sh
		_EOF_
	fi

	if [ "$OSTYPE" = "debian" ] && [ ! -d /usr/local/cpanel ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
		echo "############################################################################"
		echo "# add the following line to /etc/rc.local file:                            #"
		echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
		echo "############################################################################"
	fi
fi

