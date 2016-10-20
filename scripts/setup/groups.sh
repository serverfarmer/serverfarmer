#!/bin/sh
. /opt/farm/scripts/init

# TODO: Ubuntu 14.04 LTS and newer has Samba installed and group sambashare
# created right after fresh install. Detect similar cases, change GID of this
# group and chgrp directories previously group-owned by sambashare group.

if [ "`getent group imapusers`" = "" ]; then
	if [ "$OSTYPE" = "freebsd" ]; then
		pw groupadd newrelic -g 130
		pw groupadd mfs -g 140
		pw groupadd sambashare -g 150
		pw groupadd imapusers -g 160
	else
		groupadd -g 130 newrelic
		groupadd -g 140 mfs
		groupadd -g 150 sambashare
		groupadd -g 160 imapusers
		# RHEL registered GIDs: 170 avahi-autoipd, 190 systemd-journal
	fi
fi
