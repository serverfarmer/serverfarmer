#!/bin/bash
. /opt/farm/scripts/functions.custom

update="/opt/farm /opt/misc `ls -d /opt/sf-* 2>/dev/null`"

DIR="`pwd`"
for PD in $update; do
	if [ -d $PD/.git ]; then
		echo "updating $PD"
		cd $PD
		git pull
	fi
done
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
bash /opt/farm/scripts/setup/misc.sh
bash /opt/farm/scripts/setup/keys.sh

for E in `default_extensions`; do
	bash /opt/farm/scripts/setup/role.sh $E
done

echo -n "finished at "
date
