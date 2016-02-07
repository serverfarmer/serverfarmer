#!/bin/bash
# Konfiguracja logowania komunikatów

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ -d /usr/local/cpanel ]; then
	echo "skipping rsyslog setup, system is controlled by cPanel"
elif [ ! -f /etc/rsyslog.conf ]; then
	echo "skipping rsyslog setup, system is using different version of syslog daemon"
else

	if [ "$SYSLOG" != "true" ]; then
		MODE="forwarder"
	else
		MODE="receiver"
		bash /opt/farm/scripts/setup/role.sh sf-log-monitor
	fi

	if [ -f $base/rsyslog.$MODE ]; then
		echo "configuring rsyslog as log $MODE"
		save_original_config /etc/rsyslog.conf
		cat $base/rsyslog.$MODE |sed s/%%syslog%%/$SYSLOG/g >/etc/rsyslog.conf
		service rsyslog restart
	fi
fi


if [ "$HWTYPE" = "container" ]; then
	echo "skipping logrotate configuration"
else
	echo "setting up logrotate configuration"
	for f in `ls $base/logrotate`; do
		install_link $base/logrotate/$f /etc/logrotate.d/$f
	done
fi

