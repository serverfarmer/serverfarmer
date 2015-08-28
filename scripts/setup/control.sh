#!/bin/bash
# Konfiguracja kluczy ssh do zdalnego zarzadzania serwerem

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom



echo "preparing ssh key"
FULLKEY=`ssh_management_key_string $HOST`

if [ ! -f /root/.ssh/authorized_keys ] || [ "`cat /root/.ssh/authorized_keys |grep \"$FULLKEY\"`" = "" ]; then
	echo "setting up root ssh key"
	mkdir -p /root/.ssh
	echo "$FULLKEY" >>/root/.ssh/authorized_keys
fi

if [ "$OSTYPE" = "debian" ] && [ "$HWTYPE" != "container" ] && [ ! -f /var/backups/.ssh/authorized_keys ]; then
	echo "setting up backup ssh key"
	mkdir -p /var/backups/.ssh
	echo "$FULLKEY" >/var/backups/.ssh/authorized_keys
fi
