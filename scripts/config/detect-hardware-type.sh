#!/bin/sh

is_lxc_host() {
	if [ -f /usr/bin/lxc-create ]; then return 1; else return 0; fi
}

is_lxc_container() {
	if [ "`cat /proc/1/environ |grep lxc`" != "" ]; then return 1; else return 0; fi
}


is_openvz_host() {
	if [ -f /proc/vz/version ]; then return 1; else return 0; fi
}

is_openvz_container() {
	if [ -d /proc/vz ] && [ ! -f /proc/vz/version ]; then return 1; else return 0; fi
}

is_openvz_container_with_venet() {
	if [ "`/sbin/ifconfig -a |grep venet0:0`" != "" ]; then return 1; else return 0; fi
}

is_openvz_container_with_veth() {
	return 0
}


is_vserver_host() {
	return 0
}

is_vserver_container() {
	return 0
}


is_virtualbox_guest() {
	if [ -f /sys/devices/virtual/dmi/id/product_name ] && [ "`cat /sys/devices/virtual/dmi/id/product_name |grep VirtualBox`" != "" ]; then return 1; else return 0; fi
}

is_vmware_guest() {
	if [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i vmware`" != "" ]; then return 1; else return 0; fi
}

is_hyperv_guest() {
	return 0
}

is_kvmqemu_guest() {
	if [ "`cat /proc/cpuinfo |grep \"QEMU Virtual CPU\"`" != "" ]; then return 1; else return 0; fi
}

is_xen() {
	if [ -d /proc/xen ] || [ -d /proc/sys/xen ] || [ -d /sys/bus/xen  ]; then return 1; else return 0; fi
}

is_xen_guest() {
	return 0
}



is_container() {
	is_lxc_container || return 1
	is_openvz_container || return 1
	is_vserver_container || return 1
	return 0
}

is_guest() {
	is_virtualbox_guest || return 1
	is_vmware_guest || return 1
	is_hyperv_guest || return 1
	is_kvmqemu_guest || return 1
	is_xen_guest || return 1
	return 0
}

is_physical() {
	is_container || return 0
	is_guest || return 0
	return 1
}


is_container || echo "container"
is_guest || echo "guest"
is_physical || echo "physical"

