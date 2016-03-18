#!/bin/bash
. /opt/farm/scripts/functions.custom

update="/opt/farm `ls -d /opt/farm/ext/* 2>/dev/null`"

DIR="`pwd`"
for PD in $update; do
	if [ -d $PD/.git ]; then
		echo "updating $PD"
		cd $PD
		git pull
	elif [ -d $PD/.svn ]; then
		svn up $PD
	fi
done
cd "$DIR"


if [ -f /etc/farmconfig ]; then
	. /etc/farmconfig
else
	/opt/farm/scripts/setup/init.sh
	exit
fi


/opt/farm/scripts/setup/sources.sh

if [ -d /usr/local/cpanel ]; then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"
elif [ -f /etc/elastix.conf ]; then
	echo "skipping mta configuration, system is controlled by Elastix"
elif [ "$SMTP" != "true" ]; then
	/opt/farm/scripts/setup/role.sh sf-mta-forwarder
else
	/opt/farm/scripts/setup/role.sh sf-mta-relay
fi

/opt/farm/scripts/setup/role.sh base

if [ "$HWTYPE" = "physical" ]; then
	/opt/farm/scripts/setup/role.sh hardware
fi

if [ "$SYSLOG" != "true" ]; then
	/opt/farm/scripts/setup/role.sh sf-log-forwarder
else
	/opt/farm/scripts/setup/role.sh sf-log-receiver
	/opt/farm/scripts/setup/role.sh sf-log-monitor
fi

/opt/farm/scripts/setup/role.sh sf-log-rotate
/opt/farm/scripts/setup/keys.sh

for E in `default_extensions`; do
	/opt/farm/scripts/setup/role.sh $E
done

if [ "$OSTYPE" = "debian" ] && [ "$HWTYPE" != "container" ] && [ ! -d /usr/local/cpanel ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
	echo "############################################################################"
	echo "# add the following line to /etc/rc.local file:                            #"
	echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=130 /proc #"
	echo "############################################################################"
fi

echo -n "finished at "
date
