#!/bin/bash
# Inicjalizacja skryptów konfiguracyjnych

. /opt/farm/scripts/functions.dialog


if [ ! -f /etc/farmconfig ]; then
	OSDET=`/opt/farm/scripts/config/detect-system-version.sh`
	OSTYPE=`/opt/farm/scripts/config/detect-system-version.sh -type`
	HWTYPE=`/opt/farm/scripts/config/detect-hardware-type.sh`
	OSVER="`input \"enter operating system version\" $OSDET`"

	if [ -d /opt/farm/dist/$OSVER ]; then

		echo -n "enter server hostname: "
		read HOST

		SMTP="`question \"install central mta role on this server\"`"
		SYSLOG="`question \"install central syslog role on this server\"`"
		WWW="`question \"install httpd role on this server\"`"

		if [ "$SMTP" != "true" ]; then
			SMTP="`input \"enter central mta hostname\" smtp.internal`"
		fi

		if [ "$SYSLOG" != "true" ]; then
			SYSLOG="`input \"enter central syslog hostname\" syslog.internal`"
		fi

		hostname $HOST
		sed -i -e '/$HOST/d' /etc/hosts

		if [ -f /etc/sysconfig/network ]; then
			sed -i -e '/HOSTNAME=/d' /etc/sysconfig/network
			echo "HOSTNAME=$HOST" >> /etc/sysconfig/network
		fi

		if [ -x /usr/bin/hostnamectl ]; then
			/usr/bin/hostnamectl set-hostname $HOST
		fi

		if [ -f /etc/HOSTNAME ]; then echo $HOST >/etc/HOSTNAME; fi
		if [ -f /etc/hostname ]; then echo $HOST >/etc/hostname; fi
		if [ -f /etc/mailname ]; then echo $HOST >/etc/mailname; fi

		echo "HOST=$HOST" >/etc/farmconfig
		echo "OSVER=$OSVER" >>/etc/farmconfig
		echo "OSTYPE=$OSTYPE" >>/etc/farmconfig
		echo "HWTYPE=$HWTYPE" >>/etc/farmconfig
		echo "SMTP=$SMTP" >>/etc/farmconfig
		echo "SYSLOG=$SYSLOG" >>/etc/farmconfig
		echo "WWW=$WWW" >>/etc/farmconfig

		if [ "`getent group imapusers`" = "" ]; then
			groupadd -g 130 newrelic
			groupadd -g 140 mfs
			groupadd -g 150 sambashare
			groupadd -g 160 imapusers
			# RHEL registered GIDs: 170 avahi-autoipd, 190 systemd-journal
			groupadd -g 1001 motion

			if [ "$OSTYPE" = "debian" ]; then
				rm -f /etc/ssh/ssh_host_*
				dpkg-reconfigure openssh-server
			elif [ -x /usr/sbin/sshd-keygen ]; then
				rm -f /etc/ssh/ssh_host_*
				/usr/sbin/sshd-keygen   # RHEL 7.x
			fi
		fi

		echo "initial configuration done, now run /opt/farm/setup.sh once again"
	else
		echo "error: invalid operating system version, exiting"
	fi
fi
