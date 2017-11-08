#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.keys



echo "preparing ssh key"
FULLKEY=`ssh_management_key_string $HOST`

if [ ! -f /root/.ssh/authorized_keys ] || [ "`grep \"$FULLKEY\" /root/.ssh/authorized_keys`" = "" ]; then
	echo "setting up root ssh key"
	mkdir -p /root/.ssh
	echo "$FULLKEY" >>/root/.ssh/authorized_keys
fi
