#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <role>"
	exit
fi

role=$1
echo "DEPRECATED SCRIPT role.sh - USE EITHER /opt/farm/scripts/setup/extension.sh OR /opt/farm/ext/repos/install.sh INSTEAD (role: $role)"

/opt/farm/ext/repos/install.sh $role
/opt/farm/scripts/setup/extension.sh $role
