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
		bash /opt/farm/scripts/setup/role.sh syslog-utils

		echo "setting up custom ignoring rules for logcheck"
		install_copy $common/logcheck.tpl /etc/logcheck/ignore.d.server/local-farmer

		if [ -f $base/logcheck.tpl ]; then
			f=/etc/logcheck/logcheck.conf

			echo -n "detecting report level: "
			if [ -d /etc/NetworkManager ]; then
				LEVEL="workstation"
			else
				LEVEL="server"
			fi
			echo $LEVEL

			echo "setting up logcheck configuration"
			cat $base/logcheck.tpl |sed -e s/%%domain%%/`external_domain`/g -e s/%%level%%/$LEVEL/g >$f
			chown root:logcheck $f
			chmod 0640 $f
		fi
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

