#!/bin/sh

# crontab -e (jako root):
#   * * * * * /opt/farm/scripts/cacti/vz-helper.sh

host="`hostname`"
file="/var/cache/cacti/vzstat-$host.txt"

echo -n "date " >$file.new
date +%s >>$file.new

for ID in `/usr/sbin/vzlist -Ho ctid`
do
	eval `cat /proc/bc/$ID/resources |grep privvmpages | awk '{printf "MEMCUR=%s\nMEMMAX=%s\nMEMLIMIT=%s\n", $2, $3, $4}'`

	# TODO: support for VETH
	eval `/usr/sbin/vzctl exec $ID 'grep venet0 /proc/net/dev' | cut -f2 -d: | awk '{printf "VEIN=%s\nVEOUT=%s\n", $1, $9}'`

	eval `/usr/sbin/vzquota stat $ID |grep 1k-blocks | awk '{printf "BLKUSED=%s\nBLKLIMIT=%s\n", $2, $3}'`
	eval `/usr/sbin/vzquota stat $ID |grep inodes | awk '{printf "INOUSED=%s\nINOLIMIT=%s\n", $2, $3}'`

	echo "id:$ID netin:$VEIN netout:$VEOUT memcur:$((MEMCUR*4096)) memmax:$((MEMMAX*4096)) memlimit:$((MEMLIMIT*4096)) blkused:$((BLKUSED*1024)) blklimit:$((BLKLIMIT*1024)) inoused:$INOUSED inolimit:$INOLIMIT" >>$file.new
done

mv -f $file.new $file 2>/dev/null

/opt/farm/scripts/cacti/send.sh $file

