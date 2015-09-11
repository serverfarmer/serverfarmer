#!/bin/bash
# Konfiguracja PHP i opcjonalnie Apache 2

. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install



set_php_value() {
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

	set_php_value $file error_log '\/var\/log\/php\/php-error.log'
	set_php_value $file include_path '\".:\/usr\/share\/php\"'
	set_php_value $file memory_limit 1536M
	set_php_value $file log_errors On
	set_php_value $file magic_quotes_gpc Off
	set_php_value $file expose_php Off
	set_php_value $file allow_url_fopen Off
	set_php_value $file post_max_size 16M
	set_php_value $file upload_max_filesize 16M
}


if [ -d /usr/local/cpanel ]; then
	echo "skipping php setup, system is controlled by cPanel"
	exit 0
fi

bash /opt/farm/scripts/setup/role.sh php-cli
echo "setting up php configuration"

if [ "$OSTYPE" != "debian" ]; then

	mkdir -p /var/log/php
	chmod 0777 /var/log/php
	process_php_ini /etc/php.ini

	if [ -f /usr/bin/php ] && [ ! -f /usr/bin/php5 ]; then
		ln -s /usr/bin/php /usr/bin/php5
	fi

else
	mkdir -p /var/log/apache2
	mkdir -p /var/log/php
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

