#!/bin/sh

for D in /etc /root /boot /var/lib/mfs /var/lib/samba /var/log /var/www; do
	echo $D
done

for D in `ls /data 2>/dev/null`; do
	echo /data/$D
done

for D in `ls /opt 2>/dev/null |egrep -v "^(farm|firewall|misc|newrelic|warfare)$"`; do
	echo /opt/$D
done

for D in `ls /srv 2>/dev/null |egrep -v "^(apps|chunks|cifs|imap|isync|mounts|rsync|sites)$"`; do
	echo /srv/$D
done

for D in `ls /srv/apps 2>/dev/null`; do
	echo /srv/apps/$D
done

for D in `ls /srv/sites 2>/dev/null`; do
	echo /srv/sites/$D
done
