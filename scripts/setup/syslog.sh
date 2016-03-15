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

bash /opt/farm/scripts/setup/role.sh sf-log-rotate
