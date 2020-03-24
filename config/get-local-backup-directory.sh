#!/bin/sh

# Local backup directory:
#
# - it is used to create and store backup archives from current host, until they are fetched
#   by central server called "backup collector" (see https://github.com/serverfarmer/sm-backup-collector)
#
# - it acts as a temporary directory, and also contains 3 subdirectories: daily, weekly and custom
#
# - temporary archive is created in eg. /backup, and when finished, moved to eg. /backup/daily
#
# - these 3 subdirectories are created automatically as normal directories, but later can be
#   manually moved to other drives and symlinked, to split backups across many drives and have
#   better control over free/used disk space
#
# - also the main directory can be later moved manually to other drive and symlinked
#
# - NFS or other network solutions can be used for these 3 subdirectories, bud don't use them
#   for the main directory
#
# !!!
# IMPORTANT: this directory has to be set exactly the same for your whole deployment of Server Farmer.
# !!!
#
# If you use Server Farmer to manage your clients' hosts, and don't have full control of their
# content (so you're not sure if /backup directories aren't already taken by any other backup solution),
# then it is reasonable to change it to some other name, that is not used for any other purpose.
#
# To read more about how Server Farmer backups are organized, go to https://github.com/serverfarmer/sf-backup


echo "/backup"
