#!/bin/bash
# Konfiguracja Midnight Commandera

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ -f $base/mc.ini ]; then
	echo "setting up midnight commander profiles"

	if [ "$OSVER" = "debian-wheezy" ] || [ "$OSVER" = "debian-jessie" ] || [ "$OSVER" = "redhat-centos71" ]; then
		f=/root/.config/mc/ini
	else
		f=/root/.mc/ini
	fi
	cp -f $base/mc.ini $f
	chown root:root $f
	chmod 0644 $f

	if [ "`cat /etc/passwd |grep ^tomek:`" != "" ]; then
		if [ "$OSVER" = "debian-wheezy" ] || [ "$OSVER" = "debian-jessie" ] || [ "$OSVER" = "redhat-centos71" ]; then
			f=/home/tomek/.config/mc/ini
		else
			f=/home/tomek/.mc/ini
		fi
		cp -f $base/mc.ini $f
		chown tomek:tomek $f
		chmod 0644 $f
	fi
fi


loc="/usr/share/locale/pl/LC_MESSAGES"

if [ -f $loc/mc.mo ]; then
	echo "disabling midnight commander polish translation"
	mv $loc/mc.mo $loc/midc.mo
fi

