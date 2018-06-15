#!/bin/bash
. scripts/functions.custom
. scripts/functions.dialog
. scripts/functions.install
. scripts/functions.net
. scripts/functions.uid

# This is a test script for Travis CI, to check critical files for syntax errors.

HOST=`hostname`
echo "hostname: $HOST"
echo "external domain: `external_domain`"
echo "google.com resolves to: `resolve_host google.com`"
echo "first unused UID after 1000: `get_free_uid 1000 65000`"
