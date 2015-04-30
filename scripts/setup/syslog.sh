#!/bin/bash
# Konfiguracja logowania komunikatów

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ -d /usr/local/cpanel ]; then
	echo "skipping rsyslog setup, system is controlled by cPanel"
else

	if [ "$SYSLOG" != "true" ]; then
		MODE="forwarder"
	else
		MODE="receiver"
		bash /opt/farm/scripts/setup/role.sh syslog-utils

		echo "setting up cron bogus warning ignoring rules for logcheck"
		install_copy $common/logcheck/cron.tpl /etc/logcheck/ignore.d.server/local-cron

		if [ -f $base/logcheck.conf ]; then
			f=/etc/logcheck/logcheck.conf
			echo "setting up logcheck configuration"
			cp -f $base/logcheck.conf $f
			chown root:logcheck $f
			chmod 0640 $f
		fi
	fi

	if [ -f $base/rsyslog.$MODE ]; then
		echo "configuring rsyslog as log $MODE"
		cat $base/rsyslog.$MODE |sed s/%%syslog%%/$SYSLOG/g >/etc/rsyslog.conf
		service rsyslog restart |grep -v "ing enhanced syslogd: rsyslogd."
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

