#!/bin/bash
. /opt/farm/scripts/functions.custom

src=$1

if [ "$src" != "" ] && [ -f $src ]; then
	cat $src |`stream_handler` >`add_backup_extension $src`
	if [ "$2" = "-delete" ]; then
		rm -f $src
	fi
fi

