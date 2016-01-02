#!/bin/sh

for D in /etc /root /boot /var/log; do
	echo $D
done

if [ ! -f /var/www/.subdirectories ]; then
	echo /var/www
else
	for D in `ls /var/www 2>/dev/null`; do
		echo /var/www/$D
	done
fi

for D in `ls /data 2>/dev/null`; do
	echo /data/$D
done

for D in `ls /opt 2>/dev/null |egrep -v "^(farm|firewall|misc|warfare)$" |grep -v ^sf-`; do
	echo /opt/$D
done

for D in `ls /srv 2>/dev/null |egrep -v "^(apps|chunks|cifs|imap|isync|mounts|rsync|sites)$" |grep -v private`; do
	echo /srv/$D
done

for D in `ls /srv/apps 2>/dev/null`; do
	echo /srv/apps/$D
done

for D in `ls /srv/sites 2>/dev/null`; do
	echo /srv/sites/$D
done

for D in cassandra docker ldap lxc mfs mongodb openswan rabbitmq redis samba spamassassin tomcat6 tomcat7 vz; do
	echo /var/lib/$D
done

for D in `ls / |egrep -v "^(bin|boot|cgroup|data|dev|etc|home|initrd.img|lib|lib32|lib64|libdata|libexec|livecd|lost\+found|media|mnt|opt|proc|rescue|root|run|sbin|selinux|srv|sys|tmp|usr|var|vmlinuz)$"`; do
	echo /$D
done

for D in `ls /usr |egrep -v "^(X11|X11R6|X11R7|bin|doc|drivers|games|include|info|kerberos|lib|lib32|lib64|libdata|libexec|local|man|ports|sbin|share|spool|src|tmp|x86_64-slackware-linux|x86_64-suse-linux)$"`; do
	echo /usr/$D
done

for D in `ls /usr/local 2>/dev/null |egrep -v "^(bin|games|include|lib|man|sbin|share)$"`; do
	echo /usr/local/$D
done

for D in `ls /usr/src 2>/dev/null |egrep -v "^(kernels|linux)$" |egrep -v "^(kernel-devel-|linux-)"`; do
	echo /usr/src/$D
done
