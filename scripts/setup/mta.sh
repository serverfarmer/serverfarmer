#!/bin/bash
# Konfiguracja MTA i elementów związanych z pocztą

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install
. /opt/farm/scripts/functions.dialog



if [ "$OSTYPE" != "debian" ]
then
	install_rpm postfix

	echo "setting up postfix"
	cat $base/postfix.tpl |sed -e s/%%host%%/$HOST/g -e s/%%smtp%%/$SMTP/g >/etc/postfix/main.cf

	echo "setting up mail aliases"
	install_customize $common/aliases.tpl /etc/aliases
	newaliases

	/etc/init.d/postfix reload

elif [ "$SMTP" = "true" ]
then
	install_deb postfix
	install_deb libsasl2-modules

	map="/etc/postfix/sasl/passwd"
	if [ ! -f $map.db ]; then
		smtprelay="`input \"enter external smtp relay hostname\" smtp.gmail.com`"
		echo -n "[$smtprelay] enter login: "
		read userlogin
		echo -n "[$smtprelay] enter password for $userlogin: "
		stty -echo
		read userpass
		stty echo
		echo ""  # force a carriage return to be output
		echo "$smtprelay  $userlogin:$userpass" >$map
		chmod 0600 $map
		postmap $map
	fi

	echo "setting up postfix"
	smtprelay="`cat $map |cut -f 1 -d \" \"`"
	cat $base/postfix.tpl |sed -e s/%%host%%/$HOST/g -e s/%%smtp%%/$smtprelay/g >/etc/postfix/main.cf

	echo "setting up mail aliases"
	install_customize $common/aliases.tpl /etc/aliases
	newaliases

	echo "setting up sender address rewriting"
	touch /etc/postfix/sender_address_rewriting
	postmap /etc/postfix/sender_address_rewriting

	if [ "$SYSLOG" = "true" ]; then
		echo "setting up gmail ssl error ignoring rules for logcheck"
		install_copy $common/logcheck/gmail.tpl /etc/logcheck/ignore.d.server/local-gmail
	fi

	/etc/init.d/postfix reload |grep -v "Reloading Postfix configuration" |grep -v "...done"
else
	install_deb ssmtp

	echo "setting up ssmtp"
	cat $common/ssmtp.tpl |sed -e s/%%host%%/$HOST/g -e s/%%smtp%%/$SMTP/g >/etc/ssmtp/ssmtp.conf
fi

