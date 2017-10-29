#!/bin/sh
. /opt/farm/scripts/functions.custom

/opt/farm/update.sh

if [ -f /etc/farmconfig ]; then
	. /etc/farmconfig
else
	/opt/farm/scripts/setup/init.sh
	exit
fi


/opt/farm/scripts/setup/keys.sh
/opt/farm/scripts/setup/extension.sh sf-repos

if [ -d /usr/local/cpanel ]; then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"
elif [ -d /usr/local/directadmin ]; then
	echo "skipping mta configuration, system is controlled by DirectAdmin, with Exim as MTA"
elif [ -f /etc/elastix.conf ]; then
	echo "skipping mta configuration, system is controlled by Elastix"
elif [ ! -d /opt/farm/ext/repos/lists/$OSVER ]; then
	echo "skipping mta configuration, unsupported system version"
elif [ "$SMTP" != "true" ]; then
	/opt/farm/scripts/setup/extension.sh sf-mta-forwarder
else
	/opt/farm/scripts/setup/extension.sh sf-mta-relay
fi

/opt/farm/ext/repos/install.sh base

if [ "$HWTYPE" = "physical" ]; then
	/opt/farm/ext/repos/install.sh hardware
	/opt/farm/scripts/setup/extension.sh sf-ntp
fi

if [ ! -d /opt/farm/ext/repos/lists/$OSVER ] || [ "$OSTYPE" = "suse" ]; then
	echo "skipping syslog configuration, unsupported system version"
elif [ "$SYSLOG" != "true" ]; then
	/opt/farm/scripts/setup/extension.sh sf-log-forwarder
else
	/opt/farm/scripts/setup/extension.sh sf-log-receiver
	/opt/farm/scripts/setup/extension.sh sf-log-monitor
fi

/opt/farm/scripts/setup/extension.sh sf-log-rotate

for E in `cat /opt/farm/.default.extensions`; do
	/opt/farm/scripts/setup/extension.sh $E
done

for E in `cat /opt/farm/.private.extensions`; do
	if [ -x /opt/farm/ext/$E/setup.sh ]; then
		/opt/farm/ext/$E/setup.sh
	fi
done

if [ "$OSTYPE" = "debian" ] && [ "$HWTYPE" != "container" ] && [ "$HWTYPE" != "lxc" ] && [ ! -d /usr/local/cpanel ] && [ -f /etc/rc.local ] && [ "`grep /proc /etc/rc.local |grep remount`" = "" ]; then
	gid="`getent group newrelic |cut -d: -f3`"
	echo "############################################################################"
	echo "# add the following line to /etc/rc.local file:                            #"
	echo "# mount -o remount,rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=$gid /proc #"
	echo "############################################################################"
fi

echo -n "finished at "
date
