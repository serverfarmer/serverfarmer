#!/bin/sh

# The purpose of this confituration script is to suggest proper hostnames
# for SMTP and syslog services during initial Server Farmer configuration.
# First, it tries to guess the internal domain based on local configuration
# pulled by dhclient from DHCP options, then provides the hardcoded default
# (from below line).

internal_domain="internal"


# Avoid changing the below code, unless you really need to implement
# some more sophisticated behavior.

detected=""
if [ -x /opt/farm/ext/system/detect-internal-domain.sh ]; then
	detected=`/opt/farm/ext/system/detect-internal-domain.sh`
fi

if [ "$detected" != "" ] && [ "$detected" != "." ]; then
	echo $detected
else
	echo $internal_domain
fi
