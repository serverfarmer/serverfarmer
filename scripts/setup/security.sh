#!/bin/bash
# Konfiguracja różnych rzeczy związanych z bezpieczeństwem

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ -f $base/sshd_config ]; then
	echo "setting up secure sshd configuration"
	install_link $base/sshd_config /etc/ssh/sshd_config
fi


echo "enforcing secure directory permissions"
/opt/farm/scripts/check/security.sh
