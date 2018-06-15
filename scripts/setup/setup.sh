#!/bin/sh
. /opt/farm/scripts/init


if [ "$OSTYPE" = "qnap" ]; then
	rm -f /etc/crontab
	cp /etc/config/crontab /etc/crontab
fi

/opt/farm/scripts/setup/extension.sh sf-keys
/opt/farm/scripts/setup/extension.sh sf-system
/opt/farm/scripts/setup/extension.sh sf-repos
/opt/farm/scripts/setup/extension.sh sf-mta-manager

/opt/farm/ext/repos/install.sh base

if [ "$HWTYPE" = "physical" ]; then
	/opt/farm/ext/repos/install.sh hardware
	/opt/farm/scripts/setup/extension.sh sf-ntp
fi

/opt/farm/scripts/setup/extension.sh sf-log-manager

for E in `cat /opt/farm/.default.extensions`; do
	/opt/farm/scripts/setup/extension.sh $E
done

for E in `cat /opt/farm/.private.extensions`; do
	if [ -x /opt/farm/ext/$E/setup.sh ]; then
		/opt/farm/ext/$E/setup.sh
	fi
done

if [ "$OSTYPE" = "qnap" ]; then
	/opt/farm/scripts/setup/extension.sh sf-qnap
fi

echo -n "finished at "
date
