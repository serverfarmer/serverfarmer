#!/bin/bash

if [ "$1" = "" ]; then
	echo "usage: $0 <module>"
	exit 1
elif ! [[ $1 =~ ^[a-z0-9]+$ ]]; then
	echo "error: parameter $1 not conforming module name format"
	exit 1
fi

module=$1
keyfile=/etc/local/.ssh/id_github_$module

if [ ! -f $keyfile ]; then
	echo "creating new key `basename $keyfile`"
	ssh-keygen -N "" -C $module@`hostname` -f $keyfile
fi

if [ ! -f $keyfile ]; then
	echo "no public key associated with `basename $keyfile`"
else
	cat $keyfile.pub
fi
