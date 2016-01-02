#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$OSTYPE" = "debian" ] && [ "$HWTYPE" != "container" ] && [ ! -d /usr/local/cpanel ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
	echo "############################################################################"
	echo "# add the following line to /etc/rc.local file:                            #"
	echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
	echo "############################################################################"
fi

