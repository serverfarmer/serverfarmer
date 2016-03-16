#!/bin/bash
. /opt/farm/scripts/init


if [ -d /usr/local/cpanel ]; then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"
elif [ -f /etc/elastix.conf ]; then
	echo "skipping mta configuration, system is controlled by Elastix"
elif [ "$SMTP" != "true" ]; then
	bash /opt/farm/scripts/setup/role.sh sf-mta-forwarder
else
	bash /opt/farm/scripts/setup/role.sh sf-mta-relay
fi
