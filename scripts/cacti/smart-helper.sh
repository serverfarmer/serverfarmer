#!/bin/sh

# crontab -e (jako root):
#   */5 * * * * /opt/farm/scripts/cacti/smart-helper.sh

/opt/farm/scripts/cacti/smart-dumper.php

