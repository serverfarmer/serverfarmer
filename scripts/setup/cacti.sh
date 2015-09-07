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
		if [ "$OSVER" = "redhat-centos5" ] || [ "$OSVER" = "redhat-centos5-elastix" ] || [ "$OSVER" = "redhat-centos64-elastix" ]; then
			ssh-keygen -t rsa -f /root/.ssh/id_cacti -P ""
		else
			ssh-keygen -t rsa -f /root/.ssh/id_cacti -P "" -I cacti@$HOST -O no-agent-forwarding -O no-port-forwarding -O no-pty -O no-x11-forwarding
		fi

		echo "key generated, now paste the following public key into `cacti_ssh_target`/.ssh/authorized_keys file:"
		cat /root/.ssh/id_cacti.pub
	fi

	if [ "$OSTYPE" = "debian" ] && [ ! -d /usr/local/cpanel ] && [ "`cat /etc/rc.local |grep /proc |grep remount`" = "" ]; then
		echo "############################################################################"
		echo "# add the following line to /etc/rc.local file:                            #"
		echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
		echo "############################################################################"
	fi
fi

