#!/bin/bash
# skrypt codziennie sprawdza i ewentualnie przywraca odpowiednie uprawnienia na
# katalogach, których zawartość nie powinna być widoczna dla zwykłych użytkowników.
# 0711 = nie widzisz zawartości, ale jak znasz konkretne nazwy, to masz dostęp
# 0750 = całkowity brak dostępu do zawartości dla użytkownika spoza grupy
# Tomasz Klim, sierpień 2014, styczeń 2015


# crontab -e (jako root):
#   22 1 * * *   root /opt/farm/scripts/check/security.sh


chmod 0700 /srv/rsync/* 2>/dev/null
chmod 0711 /srv/sites/* 2>/dev/null
chmod 0711 /home/* 2>/dev/null

GENERIC=(
	/app
	/backup
	/boot
	/etc
	/etc/apache2
	/etc/apache2/sites-available
	/etc/apache2/sites-enabled
	/etc/apt
	/etc/apt/sources.list.d
	/etc/courier
	/etc/iet
	/etc/iscsi
	/etc/lighttpd
	/etc/local
	/etc/logrotate.d
	/etc/mfs
	/etc/motion
	/etc/mysql
	/etc/nginx
	/etc/nginx/sites-available
	/etc/nginx/sites-enabled
	/etc/samba
	/etc/sysctl.d
	/home
	/media
	/mnt
	/opt
	/srv
	/srv/chunks
	/srv/cifs
	/srv/mounts
	/srv/mounts/internal1/backupy
	/srv/mounts/internal1/imap
	/srv/mounts/internal1/isync
	/srv/mounts/internal1/rsync
	/srv/mounts/internal1/sites
	/srv/mounts/internal1/uslugi
	/srv/mounts/internal1
	/srv/mounts/internal2
	/srv/mounts/internal2/archiwum
	/srv/mounts/shadow1
	/srv/mounts/shadow2
	/var/backups
	/var/cache
	/var/lib
	/var/spool
	/var/www
)

SAMBA=(
	/srv/mounts/internal1
	/srv/mounts/internal2
	/srv/mounts/moosefs
)


for D in ${GENERIC[@]}; do
	if [ -d $D ]; then
		perm=`stat -c %a:%U:%G $D`
		if [ "$perm" != "711:root:root" ]; then
			echo "directory $D had rights:owner 0$perm, fixed"
			chown root:root $D
			chmod 0711 $D
		fi
	fi
done

for D in ${SAMBA[@]}; do
	for P in `ls -d $D/samba* 2>/dev/null`; do
		perm=`stat -c %a:%U:%G $P`
		if [ "$perm" != "750:root:sambashare" ]; then
			echo "directory $P had rights:owner 0$perm, fixed"
			chown root:sambashare $P
			chmod 0750 $P
		fi
	done
done
