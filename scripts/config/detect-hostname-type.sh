#!/bin/bash

if [ "$1" = "localhost" ]; then
	echo "hostname"
	exit 0
elif ! [[ $1 =~ ^[a-z0-9.-]+([:][0-9]+)?$ ]]; then
	echo "format"
	exit 0
fi

label=$1
if [ -z "${label##*:*}" ]; then
	host="${label%:*}"
else
	host=$label
fi

if [[ $host =~ ^[0-9]+[.][0-9]+[.][0-9]+[.][0-9]+$ ]]; then
	echo "ip"
elif [ "`getent hosts $host`" != "" ]; then
	echo "hostname"
else
	echo "unknown"
fi
