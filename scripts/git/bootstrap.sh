#!/bin/sh

if [ ! -x /bin/git ] && [ ! -x /opt/bin/git ] && [ ! -x /usr/bin/git ] && [ ! -x /usr/local/bin/git ] && [ -x /opt/bin/ipkg ]; then
	echo "attempting to install Git"
	/opt/bin/ipkg install git
	ln -s /usr/bin/git /bin/git
fi
