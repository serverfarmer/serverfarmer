#!/bin/bash
# Konfiguracja PHP i opcjonalnie Apache 2

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



bash /opt/farm/scripts/setup/role.sh php-cli
echo "setting up php configuration"

if [ "$OSTYPE" != "debian" ]; then
	install_copy $base/php.ini /etc/php.ini

	mkdir -p /var/log/php
	chmod 0777 /var/log/php
else
	mkdir -p /etc/php5/apache2
	mkdir -p /var/log/apache2
	mkdir -p /var/log/php

	install_copy $base/php-apache.ini /etc/php5/apache2/php.ini
	install_copy $base/php-cli.ini /etc/php5/cli/php.ini

	touch /var/log/php/php-error.log
	chown -R www-data:www-data /var/log/php /var/log/apache2

	if [ "$OSVER" = "debian-wheezy" ]; then
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

