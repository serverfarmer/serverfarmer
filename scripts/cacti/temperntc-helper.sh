#!/bin/sh

# crontab -e (jako root):
#   * * * * * /opt/farm/scripts/cacti/temperntc-helper.sh

host="`hostname`"
file="/var/cache/cacti/temperntc-$host.txt"

echo "`/opt/farm/scripts/cacti/temperntc-monitor.pl`" >$file.new

echo -n "date " >>$file.new
date +%s >>$file.new
mv -f $file.new $file 2>/dev/null

/opt/farm/scripts/cacti/send.sh $file

