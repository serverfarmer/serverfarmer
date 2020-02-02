#!/bin/sh

# External domain is the name of the domain associated with Server Farmer deployment.
#
# You should:
# - have full control over it (including option to set reconrds in DNS)
# - be able to receive emails sent to any username within it (catch-all)
#
# Server Farmer extensions use dynamic email addressing scheme to notify you
# about certain events, eg. cron-yourserver@yourdomain, logcheck@yourdomain etc.
#
# Also, default server naming scheme is based on this domain, particularly on
# its "gw" subdomain, eg. yourserver.gw.yourdomain, someclient.gw.yourdomain etc.
# (however this behavior can be tuned by modyfing scripts in your forked version
# of sf-keys repository).

echo "tomaszklim.pl"
