#!/bin/sh

# crontab -e (jako root):
#   1 * * * * /opt/farm/scripts/cacti/disklabel-helper.sh

host="`hostname`"
file="/var/cache/cacti/labels-$host.txt"

ls -l /dev/disk/by-id/ata-* |grep -v -- -part |grep -v VBOX_HARDDISK |grep -v CF_CARD |awk "{ print \$9 \$11 }" |sed -e s/\\.\\.\\//\ /g -e s/\\/dev\\/disk\\/by-id\\///g >$file.new

echo -n "date " >>$file.new
date +%s >>$file.new
mv -f $file.new $file 2>/dev/null

/opt/farm/scripts/cacti/send.sh $file

