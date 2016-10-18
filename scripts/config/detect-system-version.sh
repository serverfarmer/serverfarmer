#!/bin/sh

detect_os_type()
{
	if [ -f /etc/debian_version ]; then
		echo "debian"
	elif [ -f /etc/redhat-release ]; then
		echo "redhat"
	elif [ -x /netbsd ]; then
		echo "netbsd"
	else
		echo "generic"
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
			8.?)
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
			"Oracle Linux Server release 6.2" | "Oracle Linux Server release 6.3" | "Oracle Linux Server release 6.6")
				echo "redhat-oracle6"
				;;
			"Oracle Linux Server release 7.1")
				echo "redhat-oracle7"
				;;
			*)
				;;
		esac

	elif [ -f /etc/elastix.conf ]; then
		DATA=`cat /etc/redhat-release`
		case "$DATA" in
			"CentOS release 5.10 (Final)" | "CentOS release 5.11 (Final)")
				echo "redhat-centos5-elastix"
				;;
			"CentOS release 6.4 (Final)")
				echo "redhat-centos6-elastix"
				;;
			"CentOS Linux release 7.0.1406 (Core) " | "CentOS Linux release 7.1.1503 (Core) ")
				echo "redhat-centos7-elastix"
				;;
			*)
				;;
		esac

	elif [ -d /usr/local/cpanel ]; then
		DATA=`cat /etc/redhat-release`
		case "$DATA" in
			"CentOS release 6.6 (Final)")
				echo "redhat-centos6-cpanel"
				;;
			*)
				;;
		esac

	else
		DATA=`cat /etc/redhat-release`
		case "$DATA" in
			"CentOS release 5.11 (Final)")
				echo "redhat-centos5"
				;;
			"CentOS release 6.6 (Final)")
				echo "redhat-centos6"
				;;
			"CentOS Linux release 7.1.1503 (Core) ")
				echo "redhat-centos7"
				;;
			"Red Hat Enterprise Linux Server release 5.5 (Tikanga)")
				echo "redhat-rhel5"
				;;
			"Red Hat Enterprise Linux Server release 6.6 (Santiago)")
				echo "redhat-rhel6"
				;;
			"Red Hat Enterprise Linux Server release 7.1 (Maipo)")
				echo "redhat-rhel7"
				;;
			*)
				;;
		esac
	fi
}

detect_netbsd_version()
{
	DATA=`uname -v`
	case "$DATA" in
		"NetBSD 6.1.5 (GENERIC)")
			echo "netbsd-6"
			;;
		*)
			;;
	esac
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
		netbsd)
			echo "`detect_netbsd_version`"
			;;
		*)
			exit 1
			;;
	esac
fi

