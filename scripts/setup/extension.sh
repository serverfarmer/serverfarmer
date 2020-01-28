#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <name>"
	exit 1
fi

name=$1

if [ ${name:0:3} = "sf-" ]; then
	ext=${name:3}

	if [ "$ext" = "keys" ]; then
		repo="`keys_repository`"
	else
		repo="`extension_repositories`/$name"
	fi

	/opt/farm/scripts/git/clone.sh $name $repo /opt/farm/ext/$ext "extension $name" $2
fi

if [ ${name:0:10} = "heartbeat-" ]; then
	ext=${name:10}
	repo="`extension_repositories`/$name"
	/opt/farm/scripts/git/clone.sh $name $repo /opt/heartbeat $name $2
fi
