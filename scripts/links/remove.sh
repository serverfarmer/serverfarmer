#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <path>"
	exit 1
elif [ ! -d $1 ]; then
	echo "path $1 not found"
	exit 1
fi

if [ -f $1/aliases ]; then
	for dst in `cat $1/aliases |cut -d: -f2`; do
		if [ -h /usr/local/bin/$dst ]; then
			rm -f /usr/local/bin/$dst
		fi
	done
fi
