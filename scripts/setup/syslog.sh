#!/bin/bash
# Konfiguracja logowania komunikatów

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



if [ "$SYSLOG" != "true" ]; then
	bash /opt/farm/scripts/setup/role.sh sf-log-forwarder
else
	bash /opt/farm/scripts/setup/role.sh sf-log-receiver
	bash /opt/farm/scripts/setup/role.sh sf-log-monitor
fi


if [ -d /etc/logrotate.d ] && [ -d $base/logrotate ]; then
	echo "setting up logrotate configuration"
	for f in `ls $base/logrotate`; do
		install_link $base/logrotate/$f /etc/logrotate.d/$f
	done
fi

