#!/bin/sh

is_systemd_nspawn_container() {
	if [ -f /run/systemd/container ] && [ "`cat /run/systemd/container |grep systemd-nspawn`" != "" ] ; then return 1; else return 0; fi
}

is_lxc_container() {
	if [ "`cat /proc/1/environ |grep lxc`" != "" ]; then return 1; fi
	if [ -f /run/systemd/container ] && [ "`cat /run/systemd/container |grep lxc`" != "" ] ; then return 1; fi
	return 0
}

is_openvz_container() {
	if [ -d /proc/vz ] && [ ! -f /proc/vz/version ]; then return 1; else return 0; fi
}

is_vserver_container() {
	if [ "`cat /proc/self/status |grep -i vxid`" != "" ]; then return 1; else return 0; fi
}


is_virtualbox_guest() {
	if [ -f /sys/devices/virtual/dmi/id/product_name ] && [ "`cat /sys/devices/virtual/dmi/id/product_name |grep VirtualBox`" != "" ]; then return 1; fi
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep innotek`" != "" ]; then return 1; fi
	if [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i \"VBOX HARDDISK\"`" != "" ]; then return 1; fi
	return 0
}

is_vmware_guest() {
	if [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i vmware`" != "" ]; then return 1; fi
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |egrep \"(VMware|VMW)\"`" != "" ]; then return 1; fi
	return 0
}

is_hyperv_guest() {
	if [ -x /usr/bin/lspci ] && [ "`/usr/bin/lspci |grep Hyper-V`" != "" ]; then return 1; else return 0; fi
}

is_virtualpc_guest() {
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep \"Microsoft Corporation\"`" != "" ]; then return 1; else return 0; fi
}

is_kvmqemu_guest() {
	if [ "`cat /proc/cpuinfo |grep \"QEMU Virtual CPU\"`" != "" ]; then return 1; fi
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep QEMU`" != "" ]; then return 1; fi
	if [ "`ls /dev/disk/by-id/ata-* |grep QEMU_HARDDISK`" != "" ]; then return 1; fi
	return 0
}

is_bochs_guest() {
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep Bochs`" != "" ]; then return 1; else return 0; fi
}

is_xen_guest() {
	if [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep Xen`" != "" ]; then return 1; fi
	if [ -f /proc/xen/capabilities ]; then return 1; fi
	if [ -f /sys/hypervisor/type ] && [ "`cat /sys/hypervisor/type |grep -i xen`" != "" ]; then return 1; fi
	return 0
}

is_uml_guest() {
	if [ "`cat /proc/cpuinfo |grep \"User Mode Linux\"`" != "" ]; then return 1; else return 0; fi
}



is_container() {
	is_systemd_nspawn_container || return 1
	is_lxc_container || return 1
	is_openvz_container || return 1
	is_vserver_container || return 1
	return 0
}

is_guest() {
	is_virtualbox_guest || return 1
	is_vmware_guest || return 1
	is_hyperv_guest || return 1
	is_virtualpc_guest || return 1
	is_kvmqemu_guest || return 1
	is_bochs_guest || return 1
	is_xen_guest || return 1
	is_uml_guest || return 1
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
