#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <name> <repo> <path> <label> <token>"
	exit 1
fi

name=$1
repo=$2
path=$3
label=$4
token=$5

if [ ! -d $path ]; then
	git clone $repo $path

elif [ ! -d $path/.git ] && [ ! -d $path/.svn ]; then
	echo "directory $path busy, skipping $label installation"

elif [ "$token" = "--update" ]; then
	/opt/farm/scripts/git/pull.sh $path
fi

if [ -x $path/setup.sh ]; then
	$path/setup.sh
fi

/opt/farm/scripts/links/create.sh $path
