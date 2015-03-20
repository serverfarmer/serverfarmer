#!/bin/bash
# Instalacja pakietów z oprogramowaniem wymaganych do
# realizacji przez serwer podanej w parametrze roli

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <role>"
	exit
fi

role=$1


if [ -f $base/packages/$role ]; then
	for p in `cat $base/packages/$role`; do
		if [ "$OSTYPE" = "debian" ]; then
			install_deb $p
		else
			install_rpm $p
		fi
	done
fi

if [ -f $base/packages/$role.purge ]; then
	for p in `cat $base/packages/$role.purge`; do
		if [ "$OSTYPE" = "debian" ]; then
			uninstall_deb $p
		else
			uninstall_rpm $p
		fi
	done
fi

if [ -f $base/packages/$role.cpan ]; then
	for p in `cat $base/packages/$role.cpan`; do
		install_cpan $p
	done
fi

