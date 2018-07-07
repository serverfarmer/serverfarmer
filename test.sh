#!/bin/bash
. scripts/functions.custom
. scripts/functions.dialog
. scripts/functions.install

# This is a test script for Travis CI, to check critical files for syntax errors.

HOST=`hostname`
echo "hostname: $HOST"
echo "external domain: `external_domain`"
