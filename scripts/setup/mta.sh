#!/bin/bash
# Mail Transfer Agent configuration
# TODO: consider support for full MTA on redhat

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install
. /opt/farm/scripts/functions.dialog



DOMAIN=`external_domain`

if [ -d /usr/local/cpanel ]
then
	echo "skipping mta configuration, system is controlled by cPanel, with Exim as MTA"

elif [ -f /etc/elastix.conf ]
then
	echo "skipping mta configuration, system is controlled by Elastix"

elif [ "$OSTYPE" != "debian" ]
then
	install_rpm postfix
	install_rpm mailx
	save_original_config /etc/postfix/main.cf

	echo "setting up postfix"
	cat $base/postfix.tpl |sed -e s/%%host%%/$HOST/g -e s/%%domain%%/$DOMAIN/g -e s/%%smtp%%/$SMTP/g >/etc/postfix/main.cf

	echo "setting up mail aliases"
	cat $common/aliases-$OSTYPE.tpl |sed -e s/%%host%%/$HOST/g -e s/%%domain%%/$DOMAIN/g >/etc/aliases
	newaliases

	service postfix reload

elif [ "$SMTP" != "true" ]
then
	install_deb ssmtp
	install_deb bsd-mailx

	echo "setting up ssmtp"
	cat $common/ssmtp.tpl |sed -e s/%%host%%/$HOST/g -e s/%%domain%%/$DOMAIN/g -e s/%%smtp%%/$SMTP/g >/etc/ssmtp/ssmtp.conf
else
	install_deb postfix
	install_deb libsasl2-modules
	install_deb bsd-mailx
	save_original_config /etc/postfix/main.cf

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
	cat $base/postfix.tpl |sed -e s/%%host%%/$HOST/g -e s/%%domain%%/$DOMAIN/g -e s/%%smtp%%/$smtprelay/g >/etc/postfix/main.cf

	echo "setting up mail aliases"
	cat $common/aliases-$OSTYPE.tpl |sed -e s/%%host%%/$HOST/g -e s/%%domain%%/$DOMAIN/g >/etc/aliases
	newaliases

	echo "setting up transport maps"
	touch /etc/postfix/transport
	postmap /etc/postfix/transport

	echo "setting up virtual aliasing"
	touch /etc/postfix/virtual_aliases
	postmap /etc/postfix/virtual_aliases

	echo "setting up sender address rewriting"
	touch /etc/postfix/sender_address_rewriting
	postmap /etc/postfix/sender_address_rewriting

	echo "setting up sender bcc notifications"
	touch /etc/postfix/sender_bcc_notifications
	postmap /etc/postfix/sender_bcc_notifications

	echo "setting up recipient bcc notifications"
	touch /etc/postfix/recipient_bcc_notifications
	postmap /etc/postfix/recipient_bcc_notifications

	service postfix restart
fi

