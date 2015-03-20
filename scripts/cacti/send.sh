#!/bin/sh

if [ "$1" = "" ]; then
	echo "no file given"
	exit 1
fi

scp -B -q -i /root/.ssh/id_cacti $1 cacti-external@cacti.biuro:/srv/sites/cacti/external/data
