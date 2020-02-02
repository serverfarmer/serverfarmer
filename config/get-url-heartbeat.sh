#!/bin/sh

# URL of the Heartbeat server to use by sf-monitoring-heartbeat extension.
# This setting can be overwritten using /etc/heartbeat/server.url file
# (separately for each server), and it is read in the following order:
#
# 1. /etc/heartbeat/server.url file (if exists and is not empty)
# 2. this script (if Server Farmer is installed)
# 3. hardcoded default value: https://serverfarmer.home.pl/heartbeat/
#
# NOTE: you can create your own Heartbeat instance, see docs here:
#       https://github.com/serverfarmer/heartbeat-server


echo "https://serverfarmer.home.pl/heartbeat/"
