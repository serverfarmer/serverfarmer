#!/bin/bash
. /opt/farm/scripts/functions.custom

src=$1

if [ "$src" != "" ] && [ -f $src ]; then
	gpg --encrypt --no-armor --recipient `gpg_backup_key` --output $src.gpg --batch $src
	if [ "$2" = "-delete" ]; then
		rm -f $src
	fi
fi

