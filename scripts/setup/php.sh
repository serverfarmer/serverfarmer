#!/bin/bash
# Konfiguracja PHP

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



set_php_option() {
	file=$1
	key=$2
	value=$3

	if ! grep -q ^$key $file; then
		echo >>$file
		echo "$key =" >>$file
	fi

	sed -i -e "s/^\($key\)[ =].*/\\1 = $value/" $file
}

process_php_ini() {
	file=$1

	if [ ! -f $file.farmer-orig ]; then
		cp $file $file.farmer-orig
	fi

	set_php_option $file error_log '\/var\/log\/php\/php-error.log'
	set_php_option $file include_path '\".:\/usr\/share\/php\"'
	set_php_option $file memory_limit 1536M
	set_php_option $file log_errors On
	set_php_option $file magic_quotes_gpc Off
	set_php_option $file expose_php Off
	set_php_option $file allow_url_fopen Off
	set_php_option $file post_max_size 16M
	set_php_option $file upload_max_filesize 16M
}


if [ -d /usr/local/cpanel ]; then
	echo "skipping php setup, system is controlled by cPanel"
	exit 0
fi

if [ "$PHP" != "true" ]; then
	echo "skipping php setup, not configured on this server"
	exit 0
fi

bash /opt/farm/scripts/setup/role.sh php-cli
echo "setting up php configuration"

mkdir -p /var/log/php

if [ "$OSTYPE" != "debian" ]; then

	chmod 0777 /var/log/php
	process_php_ini /etc/php.ini

	if [ -f /usr/bin/php ] && [ ! -f /usr/bin/php5 ]; then
		ln -s /usr/bin/php /usr/bin/php5
	fi

else
	touch /var/log/php/php-error.log
	chown -R www-data:www-data /var/log/php
	chmod g+w /var/log/php/*.log

	process_php_ini /etc/php5/cli/php.ini

	if [ -f /etc/php5/apache2/php.ini ]; then
		process_php_ini /etc/php5/apache2/php.ini
	fi

	if [ -f /etc/php5/fpm/php.ini ]; then
		process_php_ini /etc/php5/fpm/php.ini
	fi

	if [ -f /etc/php5/cgi/php.ini ]; then
		process_php_ini /etc/php5/cgi/php.ini
	fi
fi
