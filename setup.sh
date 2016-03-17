#!/bin/bash
. /opt/farm/scripts/functions.custom

update="/opt/farm /opt/firewall `ls -d /opt/sf-* 2>/dev/null` `ls -d /opt/farm/ext/* 2>/dev/null`"
move="/opt/firewall `ls -d /opt/sf-* 2>/dev/null`"

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

cd /opt
for PD in $move; do
	base=`basename $PD`
	if [ ${base:0:3} = "sf-" ]; then
		ext=${base:3}
	else
		ext=$base
	fi
	if [ -d $PD ] && [ ! -d /opt/farm/ext/$ext ]; then
		if [ -d $PD/.git ] || [ -d $PD/.svn ]; then
			echo "moving $base extension to new directory /opt/farm/ext/$ext"
			mv $PD /opt/farm/ext/$ext
		fi
	fi
done
cd "$DIR"
sed -i -e "s/\/opt\/sf-/\/opt\/farm\/ext\//" /etc/crontab


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
