# The following variable settings are the initial default values,
# which can be uncommented and modified to alter logcheck's behaviour

# Controls the format of date-/time-stamps in subject lines:
# Alternatively, set the format to suit your locale

#DATE="$(date +'%Y-%m-%d %H:%M')"

# Controls the presence of boilerplate at the top of each message:
# Alternatively, set to "0" to disable the introduction.
#
# If the files /etc/logcheck/header.txt and /etc/logcheck/footer.txt
# are present their contents will be read and used as the header and
# footer of any generated mails.

#INTRO=1

# Controls the level of filtering:
# Can be Set to "workstation", "server" or "paranoid" for different
# levels of filtering. Defaults to server if not set.

REPORTLEVEL="%%level%%"

# Controls the address mail goes to:
# *NOTE* the script does not set a default value for this variable!
# Should be set to an offsite "emailaddress@some.domain.tld"

SENDMAILTO="logcheck@%%domain%%"

# Send the results as attachment or not.
# 0=not as attachment; 1=as attachment; 2=as gzip attachment
# Default is 0

MAILASATTACH=0

# Should the hostname in the subject of generated mails be fully qualified?

FQDN=1

# Controls whether "sort -u" is used on log entries (which will
# eliminate duplicates but destroy the original ordering); the
# default is to use "sort -k 1,3 -s":
# Alternatively, set to "1" to enable unique sorting

#SORTUNIQ=0

# Controls whether /etc/logcheck/cracking.ignore.d is scanned for
# exceptions to the rules in /etc/logcheck/cracking.d:
# Alternatively, set to "1" to enable cracking.ignore support

#SUPPORT_CRACKING_IGNORE=0

# Controls the base directory for rules file location
# This must be an absolute path

#RULEDIR="/etc/logcheck"

# Controls if syslog-summary is run over each section.
# Alternatively, set to "1" to enable extra summary.
# HINT: syslog-summary needs to be installed.

#SYSLOGSUMMARY=0

# Controls Subject: lines on logcheck reports:

#ATTACKSUBJECT="Security Alerts"
#SECURITYSUBJECT="Security Events"
#EVENTSSUBJECT="System Events"

# Controls [logcheck] prefix on Subject: lines

#ADDTAG="no"

# Set a different location for temporary files than /tmp
# this is useful if your /tmp is small and you are getting
# errors such as:
# cp: writing `/tmp/logcheck.y12449/checked': No space left on device
# /usr/sbin/logcheck: line 161: cannot create temp file for here document: No space left on device
# mail: /tmp/mail.RsXXXXpc2eAx: No space left on device
# Null message body; hope that's ok
#
# If this is happening, likely you will want to change the following to be some other
# location, such as /var/tmp

TMP="/tmp"
