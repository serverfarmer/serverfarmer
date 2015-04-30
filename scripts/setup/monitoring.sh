#!/bin/bash
# Konfiguracja usług związanych z monitoringiem serwera w Cacti

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ "$HWTYPE" = "container" ]; then
	echo "skipping system monitoring configuration"
else

	pass="/var/lib/snmp.community"
	if [ ! -f $pass ]; then
		echo -n "enter snmp v2 community or hit enter to disable snmpd monitoring: "
		stty -echo
		read community
		stty echo
		echo ""  # force a carriage return to be output
		echo -n "$community" >$pass
		chmod 0600 $pass
	fi

	if [ ! -s $pass ]; then
		echo "skipping snmpd configuration (no community configured)"
	elif [ ! -f $base/snmpd.tpl ]; then
		echo "skipping snmpd configuration (no template available for $OSVER)"
	else
		bash /opt/farm/scripts/setup/role.sh snmpd

		echo "setting up snmpd configuration"
		community="`cat $pass`"
		cat $base/snmpd.tpl |sed s/%%community%%/$community/g >/etc/snmp/snmpd.conf

		if [ -f $base/snmpd.default ]; then
			install_link $base/snmpd.default /etc/default/snmpd
		fi
		service snmpd restart

		if [ "$SYSLOG" = "true" ]; then
			echo "setting up snmpd debug message ignoring rules for logcheck"
			install_copy $common/logcheck/snmpd.tpl /etc/logcheck/ignore.d.server/local-snmpd
		fi
	fi

	mkdir -p /var/cache/cacti

	if [ ! -f /root/.ssh/id_cacti ]; then
		echo "generating ssh key for cacti-external user"
		ssh-keygen -t rsa -f /root/.ssh/id_cacti -I cacti@$HOST -O no-agent-forwarding -O no-port-forwarding -O no-pty -O no-x11-forwarding -P ""

		echo "key generated, now paste the following public key into cacti.biuro:/srv/sites/cacti/external/.ssh/authorized_keys file:"
		cat /root/.ssh/id_cacti.pub
	fi
fi

