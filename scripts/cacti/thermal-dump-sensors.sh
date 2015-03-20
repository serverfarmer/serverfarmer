#!/bin/sh

t="/var/cache/cacti/sensors.tmp"
rm -f $t
sensors >$t

acpi="`cat $t |grep \"temp1:\" |sed s/[+C°]//g |awk \"{ print \\\$2 }\"`"

core0="`cat $t |grep \"Core 0:\" |sed s/[+C°]//g |awk \"{ print \\\$3 }\"`"
core1="`cat $t |grep \"Core 1:\" |sed s/[+C°]//g |awk \"{ print \\\$3 }\"`"
core2="`cat $t |grep \"Core 2:\" |sed s/[+C°]//g |awk \"{ print \\\$3 }\"`"
core3="`cat $t |grep \"Core 3:\" |sed s/[+C°]//g |awk \"{ print \\\$3 }\"`"

if [ "$acpi" = "" ]; then acpi=0; fi

if [ "$core0" = "" ]; then core0=0; fi
if [ "$core1" = "" ]; then core1=0; fi
if [ "$core2" = "" ]; then core2=0; fi
if [ "$core3" = "" ]; then core3=0; fi

echo "acpitz:$acpi core0:$core0 core1:$core1 core2:$core2 core3:$core3"

