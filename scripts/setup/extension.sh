#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <name>"
	exit 1
fi

name=$1

if [ ${name:0:3} = "sf-" ]; then
	ext=${name:3}

	if [ "$ext" = "keys" ]; then
		repo="`/opt/farm/config/get-url-keys-repository.sh`"
	else
		repo="`/opt/farm/config/get-url-extension-repositories.sh`/$name"
	fi

	/opt/farm/scripts/git/clone.sh $name $repo /opt/farm/ext/$ext "extension $name" $2
fi

if [ ${name:0:3} = "sm-" ]; then
	ext=${name:3}
	repo="`/opt/farm/config/get-url-extension-repositories.sh`/$name"
	/opt/farm/scripts/git/clone.sh $name $repo /opt/farm/mgr/$ext "extension $name" $2
fi

if [ ${name:0:10} = "heartbeat-" ]; then
	ext=${name:10}
	repo="`/opt/farm/config/get-url-extension-repositories.sh`/$name"
	/opt/farm/scripts/git/clone.sh $name $repo /opt/heartbeat $name $2
fi
