#!/bin/bash
. scripts/functions.dialog
. scripts/functions.install

# This is a test script for Travis CI, to check critical files for syntax errors.

HOST=`hostname`
echo "hostname: $HOST"
echo "external domain: `/opt/farm/config/get-external-domain.sh`"
