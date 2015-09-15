#!/bin/sh
. /opt/farm/scripts/functions.custom

if [ "$1" = "" ]; then
	echo "no file given"
	exit 1
fi

scp -B -q -i /root/.ssh/id_cacti -o StrictHostKeyChecking=no $1 cacti-external@`cacti_ssh_target`/data
