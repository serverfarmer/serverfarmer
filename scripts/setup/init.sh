#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.dialog


if [ ! -f /etc/farmconfig ]; then
	OSDET=`/opt/farm/scripts/config/detect-system-version.sh`
	OSTYPE=`/opt/farm/scripts/config/detect-system-version.sh -type`
	HWTYPE=`/opt/farm/scripts/config/detect-hardware-type.sh`
	OSVER="`input \"enter operating system version\" $OSDET`"
	INTERNAL=`internal_domain`

	if [ -d /opt/farm/dist/$OSVER ]; then

		echo -n "enter server hostname: "
		read HOST

		SMTP="`question \"install central mta role on this server\"`"
		SYSLOG="`question \"install central syslog role on this server\"`"

		if [ "$SMTP" != "true" ]; then
			SMTP="`input \"enter central mta hostname\" smtp.$INTERNAL`"
		fi

		if [ "$SYSLOG" != "true" ]; then
			SYSLOG="`input \"enter central syslog hostname\" syslog.$INTERNAL`"
		fi

		echo "HOST=$HOST" >/etc/farmconfig
		echo "OSVER=$OSVER" >>/etc/farmconfig
		echo "OSTYPE=$OSTYPE" >>/etc/farmconfig
		echo "HWTYPE=$HWTYPE" >>/etc/farmconfig
		echo "SMTP=$SMTP" >>/etc/farmconfig
		echo "SYSLOG=$SYSLOG" >>/etc/farmconfig

		mkdir -p   /etc/local/.config /etc/local/.ssh
		chmod 0700 /etc/local/.config /etc/local/.ssh
		chmod 0711 /etc/local

		/opt/farm/scripts/setup/hostname.sh $HOST
		/opt/farm/scripts/setup/groups.sh

		if [ "$REGENERATE_HOST_KEYS" != "" ]; then
			if [ "$OSTYPE" = "debian" ]; then
				rm -f /etc/ssh/ssh_host_*
				dpkg-reconfigure openssh-server
			elif [ -x /usr/sbin/sshd-keygen ]; then
				rm -f /etc/ssh/ssh_host_*
				/usr/sbin/sshd-keygen   # RHEL 7.x
			else
				echo "unable to regenerate host ssh keys, skipping this step"
			fi
		fi

		echo "initial configuration done, now run /opt/farm/setup.sh once again"
	else
		echo "error: invalid operating system version, exiting"
	fi
fi
