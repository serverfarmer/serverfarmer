#!/bin/sh

detect_os_type()
{
	if [ -f /etc/debian_version ]; then
		echo "debian"
	elif [ -f /etc/redhat-release ]; then
		echo "redhat"
	fi
}

detect_debian_version()
{
	if [ -f /etc/lsb-release ]; then
		. /etc/lsb-release
		if [ "$DISTRIB_ID" = "Ubuntu" ] && [ "$DISTRIB_CODENAME" != "" ]; then
			if [ -f /var/lib/zentyal/latestversion ]; then
				VER=`cat /var/lib/zentyal/latestversion |sed s/\\\.//g`
				echo "ubuntu-$DISTRIB_CODENAME-zentyal$VER"
			else
				echo "ubuntu-$DISTRIB_CODENAME"
			fi
		fi

	elif [ -f /etc/pve/.version ]; then
		DATA=`cat /etc/debian_version`
		case "$DATA" in
			7.?)
				echo "debian-wheezy-pve"
				;;
			*)
				;;
		esac

	elif [ -f /etc/openattic/settings.py ]; then
		DATA=`cat /etc/debian_version`
		case "$DATA" in
			7.?)
				echo "debian-wheezy-openattic"
				;;
			*)
				;;
		esac

	else
		DATA=`cat /etc/debian_version`
		case "$DATA" in
			4.0)
				echo "debian-etch"
				;;
			5.0 | 5.0.? | 5.0.10)
				echo "debian-lenny"
				;;
			6.0 | 6.0.? | 6.0.10)
				echo "debian-squeeze"
				;;
			7.?)
				echo "debian-wheezy"
				;;
			8.0)
				echo "debian-jessie"
				;;
			*)
				;;
		esac
	fi
}

detect_redhat_version()
{
	if [ -f /etc/oracle-release ]; then
		DATA=`cat /etc/oracle-release`
		case "$DATA" in
			"Oracle Linux Server release 6.2")
				echo "redhat-oracle62"
				;;
			"Oracle Linux Server release 6.3")
				echo "redhat-oracle63"
				;;
			"Oracle Linux Server release 6.6")
				echo "redhat-oracle66"
				;;
			"Oracle Linux Server release 7.1")
				echo "redhat-oracle71"
				;;
			*)
				;;
		esac

	elif [ -d /usr/local/cpanel ]; then
		DATA=`cat /etc/redhat-release`
		case "$DATA" in
			"CentOS release 6.6 (Final)")
				echo "redhat-centos66-cpanel"
				;;
			*)
				;;
		esac

	else
		DATA=`cat /etc/redhat-release`
		case "$DATA" in
			"CentOS release 5.2 (Final)")
				echo "redhat-centos52"
				;;
			"CentOS release 5.8 (Final)")
				echo "redhat-centos58"
				;;
			"CentOS release 6.6 (Final)")
				echo "redhat-centos66"
				;;
			"CentOS Linux release 7.1.1503 (Core) ")
				echo "redhat-centos71"
				;;
			*)
				;;
		esac
	fi
}



TYPE="`detect_os_type`"

if [ "$1" = "-type" ]; then
	echo $TYPE
else
	case "$TYPE" in
		debian)
			echo "`detect_debian_version`"
			;;
		redhat)
			echo "`detect_redhat_version`"
			;;
		*)
			exit 1
			;;
	esac
fi

