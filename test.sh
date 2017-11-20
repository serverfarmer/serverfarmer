#!/bin/bash
. scripts/functions.custom
. scripts/functions.dialog
. scripts/functions.install
. scripts/functions.keys
. scripts/functions.mount
. scripts/functions.net
. scripts/functions.sync
. scripts/functions.uid

# This is a test script for Travis CI, to check critical files for syntax errors.

HOST=`hostname`
echo "hostname: $HOST"
echo "external domain: `external_domain`"
echo "management ssh key for this host: `ssh_management_key_string $HOST`"
echo "located on farm manager host at: `ssh_management_key_storage_filename $HOST`"
echo "google.com resolves to: `resolve_host google.com`"
echo "first unused UID after 1000: `get_free_uid 1000 65000`"
