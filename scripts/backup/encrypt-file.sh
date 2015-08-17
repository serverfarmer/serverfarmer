#!/bin/bash

src=$1

if [ "$src" != "" ] && [ -f $src ]; then
	gpg --encrypt --no-armor --recipient backup@tomaszklim.pl --output $src.gpg --batch $src
	if [ "$2" = "-delete" ]; then
		rm -f $src
	fi
fi

