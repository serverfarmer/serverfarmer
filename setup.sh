#!/bin/sh
. /opt/farm/scripts/functions.custom

/opt/farm/update.sh

if [ -f /etc/farmconfig ]; then
	. /etc/farmconfig
else
	/opt/farm/scripts/setup/init.sh
	exit
fi


/opt/farm/scripts/setup/repos.sh
/opt/farm/scripts/setup/keys.sh

if [ -d /usr/local/cpanel ]; then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"
elif [ -f /etc/elastix.conf ]; then
	echo "skipping mta configuration, system is controlled by Elastix"
elif [ ! -d $base/packages ]; then
	echo "skipping mta configuration, unknown system version"
elif [ "$SMTP" != "true" ]; then
	/opt/farm/scripts/setup/role.sh sf-mta-forwarder
else
	/opt/farm/scripts/setup/role.sh sf-mta-relay
fi

/opt/farm/scripts/setup/role.sh base

if [ "$HWTYPE" = "physical" ]; then
	/opt/farm/scripts/setup/role.sh hardware
	/opt/farm/scripts/setup/role.sh sf-ntp
fi

if [ ! -d $base/packages ]; then
	echo "skipping syslog configuration, unknown system version"
elif [ "$SYSLOG" != "true" ]; then
	/opt/farm/scripts/setup/role.sh sf-log-forwarder
else
	/opt/farm/scripts/setup/role.sh sf-log-receiver
	/opt/farm/scripts/setup/role.sh sf-log-monitor
fi

/opt/farm/scripts/setup/role.sh sf-log-rotate

for E in `default_extensions`; do
	/opt/farm/scripts/setup/role.sh $E
done

if [ "$OSTYPE" = "debian" ] && [ "$HWTYPE" != "container" ] && [ "$HWTYPE" != "lxc" ] && [ ! -d /usr/local/cpanel ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
	gid="`getent group newrelic |cut -d: -f3`"
	echo "############################################################################"
	echo "# add the following line to /etc/rc.local file:                            #"
	echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=$gid /proc #"
	echo "############################################################################"
fi

echo -n "finished at "
date
