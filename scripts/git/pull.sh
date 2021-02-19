#!/bin/sh

target=$1

if [ ! -d $target ]; then
	echo "directory $target not exists"
	exit 1
elif [ ! -d $target/.git ] && [ ! -d $target/.svn ]; then
	echo "directory $target is not a repository clone, skipping update"
	exit 0
elif [ -d $target/.svn ]; then
	svn up $target
	exit 0
fi

repo=`basename $target`
echo "updating $target"

DIR="`pwd`"
cd $target

if grep -q git@ $target/.git/config && [ -f ~/.ssh/id_github_$repo ]; then
	# if possible, use Github deployment key, without ssh-agent
	# (deployment key can be used only for a single repository, so can't be host-wide)
	GIT_SSH=/opt/farm/scripts/git/helper.sh GIT_KEY=~/.ssh/id_github_$repo git pull
else
	git pull
fi

cd "$DIR"
