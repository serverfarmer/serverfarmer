#!/bin/bash
# Konfiguracja PHP i opcjonalnie Apache 2

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



if [ -d /usr/local/cpanel ]; then
	echo "skipping php setup, system is controlled by cPanel"
	exit 0
fi


bash /opt/farm/scripts/setup/role.sh php-cli
echo "setting up php configuration"

if [ "$OSTYPE" != "debian" ]; then
	install_copy $base/php.ini /etc/php.ini

	if [ -f /usr/bin/php ] && [ ! -f /usr/bin/php5 ]; then
		ln -s /usr/bin/php /usr/bin/php5
	fi

	mkdir -p /var/log/php
	chmod 0777 /var/log/php
else
	mkdir -p /var/log/apache2
	mkdir -p /var/log/php

	if [ -f $base/php-apache.ini ]; then
		mkdir -p /etc/php5/apache2
		install_copy $base/php-apache.ini /etc/php5/apache2/php.ini
	fi

	install_copy $base/php-cli.ini /etc/php5/cli/php.ini

	touch /var/log/php/php-error.log
	chown -R www-data:www-data /var/log/php /var/log/apache2

	if [ "$OSVER" = "debian-wheezy" ] || [ "$OSVER" = "debian-wheezy-openattic" ] || [ "$OSVER" = "debian-wheezy-pve" ]; then
		chmod g+w /var/log/php/*.log
	else
		chmod -R g+w /var/log/php /var/log/apache2
	fi
fi


if [ "$WWW" != "true" ] || [ ! -f $base/apache2.tpl ]; then
	echo "skipping apache2 configuration"
else
	bash /opt/farm/scripts/setup/role.sh php-apache

	echo "preparing apache2 configuration"
	install_customize $base/apache2.tpl /etc/apache2/apache2.conf
fi

