#!/bin/sh
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.dialog


initial_git_clone() {
	extension=$1
	if [ ! -d /opt/farm/ext/$extension ]; then
		git clone "`extension_repositories`/sf-$extension" /opt/farm/ext/$extension
	fi
}


/opt/farm/scripts/git/bootstrap.sh

initial_git_clone system
initial_git_clone repos
initial_git_clone packages
initial_git_clone farm-roles
initial_git_clone passwd-utils

mkdir -p   /etc/local/.config /etc/local/.ssh
chmod 0700 /etc/local/.config /etc/local/.ssh
chmod 0711 /etc/local


if [ ! -f /etc/farmconfig ] && [ ! -f /etc/config/farmconfig ]; then

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

		/opt/farm/ext/packages/special/bash.sh
		/opt/farm/ext/system/set-hostname.sh $HOST
		/opt/farm/ext/passwd-utils/create-group.sh newrelic 130  # common group for monitoring extensions
		/opt/farm/ext/packages/special/regenerate-ssh-host-keys.sh

		echo "initial configuration done, now run /opt/farm/setup.sh once again"
	else
		echo "error: invalid operating system version, exiting"
	fi
fi
