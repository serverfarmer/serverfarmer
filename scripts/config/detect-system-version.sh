#!/bin/sh

detect_os_type()
{
	if [ -f /etc/debian_version ] || [ -f /etc/devuan_version ]; then
		echo "debian"
	elif [ -f /etc/redhat-release ]; then
		echo "redhat"
	elif [ -f /etc/SuSE-release ]; then
		echo "suse"
	elif [ -f /etc/freebsd-update.conf ]; then
		echo "freebsd"
	elif [ -x /netbsd ]; then
		echo "netbsd"
	elif [ -f /bsd ] && [ -f /bsd.rd ]; then
		echo "openbsd"
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
				VER=`cat /var/lib/zentyal/latestversion |sed s/\\\.//g |cut -c1-2`
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

	elif [ -f /etc/rpi-issue ]; then
		DATA=`cat /etc/debian_version`
		case "$DATA" in
			8.?)
				echo "raspbian-jessie"
				;;
			*)
				;;
		esac

	elif [ -f /etc/devuan_version ]; then
		DATA=`cat /etc/devuan_version`
		case "$DATA" in
			jessie)
				echo "devuan-jessie"
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
			9.?)
				echo "debian-stretch"
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

detect_suse_version()
{
	if [ -f /etc/os-release ]; then
		. /etc/os-release
		echo "suse-`echo $VERSION_ID |cut -d. -f 1`"
	else
		echo "suse-legacy"
	fi
}

detect_netbsd_version()
{
	DATA=`uname -r`
	case "$DATA" in
		"6.1.5")
			echo "netbsd-6"
			;;
		*)
			;;
	esac
}

detect_openbsd_version()
{
	VER=`uname -r |sed s/\\\.//g`
	echo "openbsd-$VER"
}

detect_freebsd_version()
{
	DATA=`uname -r`
	case "$DATA" in
		"9.3-RELEASE")
			echo "freebsd-9"
			;;
		"10.1-RELEASE")
			echo "freebsd-10"
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
		suse)
			echo "`detect_suse_version`"
			;;
		netbsd)
			echo "`detect_netbsd_version`"
			;;
		openbsd)
			echo "`detect_openbsd_version`"
			;;
		freebsd)
			echo "`detect_freebsd_version`"
			;;
		*)
			exit 1
			;;
	esac
fi

