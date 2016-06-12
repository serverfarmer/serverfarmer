#!/bin/sh

update="/opt/farm `ls -d /opt/farm/ext/* 2>/dev/null`"

DIR="`pwd`"

for PD in $update; do
	if [ -d $PD/.git ]; then
		repo=`basename $PD`
		echo "updating $PD"
		cd $PD

		if grep -q git@ $PD/.git/config && [ -f /etc/local/.ssh/id_github_$repo ]; then
			# if possible, use Github deployment key, without ssh-agent
			# (deployment key can be used only for a single repository, so can't be host-wide)
			GIT_SSH=/opt/farm/scripts/config/git-helper.sh GIT_KEY=/etc/local/.ssh/id_github_$repo git pull
		else
			git pull
		fi

	elif [ -d $PD/.svn ]; then
		svn up $PD
	fi

done

cd "$DIR"
