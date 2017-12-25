#!/bin/sh
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.dialog


if [ ! -f /etc/farmconfig ]; then

	if [ ! -d /opt/farm/ext/system ]; then
		git clone "`extension_repositories`/sf-system" /opt/farm/ext/system
	fi
	if [ ! -d /opt/farm/ext/repos ]; then
		git clone "`extension_repositories`/sf-repos" /opt/farm/ext/repos
	fi

	OSDET=`/opt/farm/ext/system/detect-system-version.sh`
	OSTYPE=`/opt/farm/ext/system/detect-system-version.sh -type`
	HWTYPE=`/opt/farm/ext/system/detect-hardware-type.sh |head -n 1`
	OSVER="`input \"enter operating system version\" $OSDET`"
	INTERNAL=`internal_domain`

	if [ -d /opt/farm/ext/repos/lists/$OSVER ] || [ -h /opt/farm/ext/repos/lists/$OSVER ]; then

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

		if [ ! -x /bin/bash ]; then
			echo "attempting to install /bin/bash"
			if [ -x /usr/pkg/bin/pkgin ]; then
				pkgin update
				pkgin -y install bash
				ln -s /usr/pkg/bin/bash /bin/bash
			elif [ -x /usr/sbin/pkg ]; then
				pkg update
				pkg install -y bash
				ln -s /usr/local/bin/bash /bin/bash
			fi
		fi

		/opt/farm/ext/system/set-hostname.sh $HOST
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
