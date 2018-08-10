#!/bin/sh
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.dialog


initial_git_clone() {
	extension=$1
	if [ ! -d /opt/farm/ext/$extension ]; then
		git clone "`extension_repositories`/sf-$extension" /opt/farm/ext/$extension
	fi
}


if [ ! -f /etc/farmconfig ] && [ ! -f /etc/config/farmconfig ]; then

	if [ ! -x /bin/git ] && [ ! -x /opt/bin/git ] && [ ! -x /usr/bin/git ] && [ ! -x /usr/local/bin/git ] && [ -x /opt/bin/ipkg ]; then
		echo "attempting to install Git"
		/opt/bin/ipkg install git
		ln -s /usr/bin/git /bin/git
	fi

	initial_git_clone system
	initial_git_clone repos
	initial_git_clone packages
	initial_git_clone farm-roles
	initial_git_clone passwd-utils

	OSDET=`/opt/farm/ext/system/detect-system-version.sh`
	OSTYPE=`/opt/farm/ext/system/detect-system-version.sh -type`
	HWTYPE=`/opt/farm/ext/system/detect-hardware-type.sh |head -n 1`
	OSVER="`input \"enter operating system version\" $OSDET`"
	INTERNAL=`internal_domain`

	if [ -d /opt/farm/ext/farm-roles/lists/$OSVER ] || [ -h /opt/farm/ext/farm-roles/lists/$OSVER ]; then

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

		if [ "$OSTYPE" = "qnap" ]; then
			touch /etc/config/farmconfig
			ln -s /etc/config/farmconfig /etc/farmconfig
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

		/opt/farm/ext/packages/special/bash.sh
		/opt/farm/ext/system/set-hostname.sh $HOST
		/opt/farm/ext/passwd-utils/create-group.sh newrelic 130  # common group for monitoring extensions

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
