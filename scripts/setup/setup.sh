#!/bin/sh
. /opt/farm/scripts/init

# Note: the order of installing various components below is NOT random.
# It is deliberately adapted to nuances related to dependencies between
# system packages, eg. on Debian/Ubuntu, MTA (Postfix/ssmtp) should be
# installed before packages that rely on any installed MTA, because if
# not, then Exim (as the default MTA) will be installed during the setup
# process. Or if rsyslog will be reconfigured (by sf-log-manager) too
# early, then in some rare circumstances it may properly receive local
# messages, but fail to receive messages forwarded from other hosts.


if [ "$OSTYPE" = "qnap" ]; then
	rm -f /etc/crontab
	cp /etc/config/crontab /etc/crontab
fi

/opt/farm/scripts/setup/extension.sh sf-keys
/opt/farm/scripts/setup/extension.sh sf-system
/opt/farm/scripts/setup/extension.sh sf-repos
/opt/farm/scripts/setup/extension.sh sf-packages
/opt/farm/scripts/setup/extension.sh sf-farm-roles
/opt/farm/scripts/setup/extension.sh sf-mta-manager

/opt/farm/ext/farm-roles/install.sh base
/opt/farm/scripts/setup/extension.sh sf-monitoring-heartbeat

if [ ! -s /etc/local/.config/upgrade.disable ]; then
	/opt/farm/ext/farm-roles/install.sh up2date
fi

if [ "$HWTYPE" = "physical" ]; then
	/opt/farm/ext/farm-roles/install.sh hardware
	/opt/farm/scripts/setup/extension.sh sf-ntp
fi

/opt/farm/scripts/setup/extension.sh sf-log-manager
/opt/farm/scripts/setup/extension.sh sf-backup
/opt/farm/scripts/setup/extension.sh sf-security

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
