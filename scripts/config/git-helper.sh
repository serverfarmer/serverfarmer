#!/bin/sh

if [ "$GIT_KEY" != "" ] && [ -f $GIT_KEY ]; then
	ssh -i $GIT_KEY "$@"
else
	ssh "$@"
fi

