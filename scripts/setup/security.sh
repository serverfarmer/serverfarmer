#!/bin/bash
# Konfiguracja różnych rzeczy związanych z bezpieczeństwem

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ -f $base/sshd_config ]; then
	echo "setting up secure sshd configuration"
	install_link $base/sshd_config /etc/ssh/sshd_config
fi

if [ "$OSTYPE" = "debian" ]; then
	echo "enforcing secure directory permissions"
	/opt/farm/scripts/check/security.sh

	if [ "$HWTYPE" != "container" ] && [ "`cat /etc/rc.local |grep /proc |grep remount`" = "" ]; then
		echo "############################################################################"
		echo "# add the following line to /etc/rc.local file:                            #"
		echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
		echo "############################################################################"
	fi
fi
