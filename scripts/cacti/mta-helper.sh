#!/bin/sh

# crontab -e (jako root):
#   * * * * * /opt/farm/scripts/cacti/mta-helper.sh

host="`hostname`"
file="/var/cache/cacti/mta-$host.txt"

data="`mailq |grep Kbytes |grep Requests |awk \"{ print \\\"kilobytes:\\\" \\\$2 \\\" requests:\\\" \\\$5 }\"`"

if [ "$data" = "" ]; then
	data="kilobytes:0 requests:0"
fi

echo "$data" >$file.new

echo -n "date " >>$file.new
date +%s >>$file.new
mv -f $file.new $file 2>/dev/null

/opt/farm/scripts/cacti/send.sh $file

