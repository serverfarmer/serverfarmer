#!/bin/sh
# Tomasz Klim, luty 2015


# crontab -e (jako root):
#   12 6 * * * root /opt/farm/scripts/check/clock.sh


/usr/sbin/ntpdate ntp.task.gda.pl ntp.icm.edu.pl tempus2.gum.gov.pl tempus1.gum.gov.pl >>/var/log/ntpdate
