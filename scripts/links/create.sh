#!/bin/bash

if [ "$1" = "" ]; then
	echo "usage: $0 <path>"
	exit 1
elif [ ! -d $1 ]; then
	echo "path $1 not found"
	exit 1
fi

if [ -f $1/aliases ]; then
	for entry in `cat $1/aliases`; do
		src="${entry%:*}"
		dst="${entry##*:}"

		if [ -f $1/$src ] && [ ! -f /usr/local/bin/$dst ]; then
			ln -s $1/$src /usr/local/bin/$dst
		fi
	done
fi
