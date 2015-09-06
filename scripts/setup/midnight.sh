#!/bin/bash
# Konfiguracja Midnight Commandera

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install



setup_midnight_commander_for_user() {
	file=$1
	path=$2
	user=$3
	group=`id -gn $user`
	home=`getent passwd $user |cut -d: -f 6`

	rc=$home/.bashrc
	wrapper=/usr/share/mc/bin/mc-wrapper.sh

	if [ -d $home ]; then
		cp -f $file $home/$path
		chown $user:$group $home/$path

		if [ -f $rc ]; then

			if [ "`grep 'alias mc' $rc`" = "" ] && [ -f $wrapper ]; then
				echo >>$rc
				echo "alias mc='. $wrapper'" >>$rc
			fi

			if [ "`grep mcedit $rc`" = "" ]; then
				echo >>$rc
				echo "export EDITOR=mcedit" >>$rc
			fi
		fi
	fi
}


if [ -f $base/mc.ini ]; then
	echo "setting up midnight commander profiles"

	if [ -f $base/mc.skin ]; then
		cp -f $base/mc.skin /usr/share/mc/skins/wheezy.ini
	fi

	if [ "`grep -Fx $OSVER $common/mc.newpaths.conf`" != "" ]; then
		SUB=".config/mc/ini"
	else
		SUB=".mc/ini"
	fi

	# root's group is mostly root:root, but sometimes root:wheel, root:adm or other
	# (this also applies to home directory, eg. /usr/root, /var/root, /var/users/root
	# etc. instead of just /root), so execute the full setup also for root user
	setup_midnight_commander_for_user $base/mc.ini $SUB root

	ADMIN=`primary_admin_account`
	if [ "`getent passwd $ADMIN`" != "" ]; then
		setup_midnight_commander_for_user $base/mc.ini $SUB $ADMIN
	fi
fi


loc="/usr/share/locale/pl/LC_MESSAGES"

if [ -f $loc/mc.mo ]; then
	echo "disabling midnight commander polish translation"
	mv $loc/mc.mo $loc/midc.mo
fi

