#!/bin/sh

# crontab -e (jako root):
#   */5 * * * * /opt/farm/scripts/cacti/smart-helper.sh

path="/var/cache/cacti"


if [ "$1" != "--force" ] && [ -f /opt/sf-standby-monitor/config/devices.conf ]; then
	disks=`ls /dev/disk/by-id/ata-* |grep -v -- -part |grep -v VBOX_HARDDISK |grep -v CF_CARD |grep -vxFf /opt/sf-standby-monitor/config/devices.conf`
else
	disks=`ls /dev/disk/by-id/ata-* |grep -v -- -part |grep -v VBOX_HARDDISK |grep -v CF_CARD`
fi

for disk in $disks; do
	device="`basename $disk`"
	file="$path/$device.txt"

	/usr/sbin/smartctl -d sat -T permissive -a $disk >$file.new
	mv -f $file.new $file 2>/dev/null

	/opt/farm/scripts/cacti/send.sh $file
done
