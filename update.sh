#!/bin/sh

update="/opt/heartbeat /opt/farm `ls -d /opt/farm/ext/* 2>/dev/null`"

for PD in $update; do
	/opt/farm/scripts/git/pull.sh $PD
done
