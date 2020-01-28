#!/bin/sh
# This script is responsible for installing Git client on various strange systems.
# On standard systems, Git should be already available before Server Farmer core
# is installed, since it is installed by cloning Git repository. However in some
# cases, SF core can be installed from package.


# Optware/ipkg (QNAP, DD-WRT etc. embedded distributions)
if [ ! -x /bin/git ] && [ ! -x /opt/bin/git ] && [ ! -x /usr/bin/git ] && [ ! -x /usr/local/bin/git ] && [ -x /opt/bin/ipkg ]; then
	echo "attempting to install Git"
	/opt/bin/ipkg install git
	ln -s /usr/bin/git /bin/git
fi
