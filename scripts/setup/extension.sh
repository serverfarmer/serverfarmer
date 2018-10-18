#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <name>"
	exit
fi

name=$1

if [ ${name:0:3} = "sf-" ]; then
	ext=${name:3}

	if [ "$ext" = "keys" ]; then
		repo="`keys_repository`"
	else
		repo="`extension_repositories`/$name"
	fi

	if [ ! -d /opt/farm/ext/$ext ]; then
		git clone $repo /opt/farm/ext/$ext
	elif [ ! -d /opt/farm/ext/$ext/.git ] && [ ! -d /opt/farm/ext/$ext/.svn ]; then
		echo "directory /opt/farm/ext/$ext busy, skipping extension $name installation"
	elif [ "$2" = "--update" ]; then
		/opt/farm/scripts/git/pull.sh /opt/farm/ext/$ext
	fi

	if [ -x /opt/farm/ext/$ext/setup.sh ]; then
		/opt/farm/ext/$ext/setup.sh
	fi
fi

if [ ${name:0:10} = "heartbeat-" ]; then
	ext=${name:10}
	repo="`extension_repositories`/$name"

	if [ ! -d /opt/heartbeat ]; then
		git clone $repo /opt/heartbeat
	elif [ ! -d /opt/heartbeat/.git ] && [ ! -d /opt/heartbeat/.svn ]; then
		echo "directory /opt/heartbeat busy, skipping $name installation"
	elif [ "$2" = "--update" ]; then
		/opt/farm/scripts/git/pull.sh /opt/heartbeat
	fi

	if [ -x /opt/heartbeat/setup.sh ]; then
		/opt/heartbeat/setup.sh
	fi
fi
