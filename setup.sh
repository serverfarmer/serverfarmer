#!/bin/sh

if [ "$1" != "--skip-update" ]; then
	/opt/farm/update.sh
fi

if [ -f /etc/farmconfig ]; then
	/opt/farm/scripts/setup/setup.sh
else
	/opt/farm/scripts/setup/init.sh
fi
