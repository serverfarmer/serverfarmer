#!/bin/bash
# Konfiguracja różnych rzeczy związanych z bezpieczeństwem

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



set_sshd_option() {
	file=$1
	key=$2
	value=$3

	if ! grep -q ^$key $file; then
		echo >>$file
		echo "$key =" >>$file
	else
		sed -i -e "s/^\($key\)[ ].*/\\1 $value/" $file
	fi
}


echo "setting up secure sshd configuration"
file="/etc/ssh/sshd_config"

if [ ! -f $file.farmer-orig ]; then
	cp $file $file.farmer-orig
fi

set_sshd_option $file Protocol 2
set_sshd_option $file UsePrivilegeSeparation yes
set_sshd_option $file HostbasedAuthentication no
set_sshd_option $file PubkeyAuthentication yes
set_sshd_option $file PasswordAuthentication yes
set_sshd_option $file PermitEmptyPasswords no
set_sshd_option $file PermitRootLogin without-password
set_sshd_option $file StrictModes yes
set_sshd_option $file X11Forwarding no
set_sshd_option $file TCPKeepAlive yes

if [ "$OSTYPE" = "debian" ]; then
	service ssh reload
else
	service sshd reload
fi
