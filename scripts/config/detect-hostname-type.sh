#!/bin/bash

if ! [[ $1 =~ ^[a-z0-9.-]+[.][a-z0-9]+$ ]]; then
	echo "format"
elif [[ $1 =~ ^[0-9]+[.][0-9]+[.][0-9]+[.][0-9]+$ ]]; then
	echo "ip"
elif [ "`getent hosts $1`" != "" ]; then
	echo "hostname"
else
	echo "unknown"
fi
