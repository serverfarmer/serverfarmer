#!/bin/bash

DIR="`pwd`"
if [ -d /opt/farm/.git ]; then echo "updating /opt/farm"; cd /opt/farm; git pull; fi
if [ -d /opt/misc/.git ]; then echo "updating /opt/misc"; cd /opt/misc; git pull; fi
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
bash /opt/farm/scripts/setup/syslog.sh
bash /opt/farm/scripts/setup/gpg.sh
bash /opt/farm/scripts/setup/backup.sh
bash /opt/farm/scripts/setup/midnight.sh
bash /opt/farm/scripts/setup/snmpd.sh
bash /opt/farm/scripts/setup/cacti.sh
bash /opt/farm/scripts/setup/keys.sh
bash /opt/farm/scripts/setup/sshd.sh
bash /opt/farm/scripts/check/security.sh

echo -n "finished at "
date

