#!/bin/bash

echo "updating /opt/farm"
DIR="`pwd`"
cd /opt/farm
git pull
cd "$DIR"


if [ -f /etc/farmconfig ]; then
	. /etc/farmconfig
else
	bash /opt/farm/scripts/setup/init.sh
	exit
fi


bash /opt/farm/scripts/setup/sources.sh
bash /opt/farm/scripts/setup/mta.sh
bash /opt/farm/scripts/setup/role.sh base
if [ "$HWTYPE" = "physical" ]; then
	bash /opt/farm/scripts/setup/role.sh hardware
fi
bash /opt/farm/scripts/setup/php.sh
bash /opt/farm/scripts/setup/syslog.sh
bash /opt/farm/scripts/setup/midnight.sh
bash /opt/farm/scripts/setup/monitoring.sh
bash /opt/farm/scripts/setup/backup.sh
bash /opt/farm/scripts/setup/security.sh

echo -n "finished at "
date

