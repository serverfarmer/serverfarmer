#!/bin/bash

if [ "$1" = "" ]; then
	echo "usage: $0 <new-hostname>"
	exit 1
elif ! [[ $1 =~ ^[a-z0-9.-]+$ ]]; then
	echo "error: parameter $1 not conforming hostname format"
	exit 1
fi

HOST=$1
SHORT="${HOST%.*}"

hostname $HOST

if grep -q $SHORT /etc/hosts; then
	sed -i -e "/$SHORT/d" /etc/hosts
fi

if [ -f /etc/sysconfig/network ]; then
	sed -i -e '/HOSTNAME=/d' /etc/sysconfig/network
	echo "HOSTNAME=$HOST" >> /etc/sysconfig/network
fi

if [ -f /etc/rc.conf ]; then
	sed -e '/hostname=/d' /etc/rc.conf >/etc/rc.conf.$$
	echo "hostname=$HOST" >>/etc/rc.conf.$$
	cat /etc/rc.conf.$$ >/etc/rc.conf
fi

if [ -x /usr/bin/hostnamectl ]; then
	/usr/bin/hostnamectl set-hostname $HOST
fi

if [ -f /etc/HOSTNAME ]; then echo $HOST >/etc/HOSTNAME; fi
if [ -f /etc/hostname ]; then echo $HOST >/etc/hostname; fi
if [ -f /etc/mailname ]; then echo $HOST >/etc/mailname; fi
