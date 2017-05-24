#!/bin/sh

if [ -f /proc/1/environ ] && [ "`cat /proc/1/environ |grep lxc`" != "" ]; then
	echo "lxc"
elif [ -f /run/systemd/container ] && [ "`cat /run/systemd/container |grep lxc`" != "" ]; then
	echo "lxc"

elif [ -f /run/systemd/container ] && [ "`cat /run/systemd/container |grep systemd-nspawn`" != "" ]; then
	echo "container"  # nspawn
elif [ -d /proc/vz ] && [ ! -f /proc/vz/version ]; then
	echo "container"  # openvz
elif [ -f /proc/self/status ] && [ "`cat /proc/self/status |grep -i vxid`" != "" ]; then
	echo "container"  # linux-vserver

elif [ -f /sys/devices/virtual/dmi/id/product_name ] && [ "`cat /sys/devices/virtual/dmi/id/product_name |grep VirtualBox`" != "" ]; then
	echo "guest"      # virtualbox
elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep innotek`" != "" ]; then
	echo "guest"      # virtualbox
elif [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i \"VBOX HARDDISK\"`" != "" ]; then
	echo "guest"      # virtualbox

elif [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i vmware`" != "" ]; then
	echo "guest"      # vmware
elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |egrep \"(VMware|VMW)\"`" != "" ]; then
	echo "guest"      # vmware

elif [ -x /usr/bin/lspci ] && [ "`/usr/bin/lspci |grep Hyper-V`" != "" ]; then
	echo "guest"      # ms hyper-v
elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep \"Microsoft Corporation\"`" != "" ]; then
	echo "guest"      # ms virtualpc or hyper-v

elif [ -f /proc/cpuinfo ] && [ "`cat /proc/cpuinfo |grep \"QEMU Virtual CPU\"`" != "" ]; then
	echo "guest"      # kvm/qemu
elif [ -f /proc/scsi/scsi ] && [ "`cat /proc/scsi/scsi |grep -i QEMU`" != "" ]; then
	echo "guest"      # kvm/qemu
elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep QEMU`" != "" ]; then
	echo "guest"      # kvm/qemu
elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep Google`" != "" ]; then
	echo "guest"      # kvm/qemu
elif [ -d /dev/disk/by-id ] && [ "`ls /dev/disk/by-id/ata-* 2>/dev/null |grep QEMU_HARDDISK`" != "" ]; then
	echo "guest"      # kvm/qemu

elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep Xen`" != "" ]; then
	echo "guest"      # xen
elif [ -f /proc/xen/capabilities ]; then
	echo "guest"      # xen
elif [ -f /sys/hypervisor/type ] && [ "`cat /sys/hypervisor/type |grep -i xen`" != "" ]; then
	echo "guest"      # xen

elif [ -d /sys/class/dmi/id ] && [ "`cat /sys/class/dmi/id/*_vendor |grep Bochs`" != "" ]; then
	echo "guest"      # bochs
elif [ -f /proc/cpuinfo ] && [ "`cat /proc/cpuinfo |grep \"User Mode Linux\"`" != "" ]; then
	echo "guest"      # uml

elif [ "`dmesg |grep VirtualBox`" != "" ]; then
	echo "guest"      # virtualbox
elif [ "`dmesg |grep VBOX`" != "" ]; then
	echo "guest"      # virtualbox
elif [ "`dmesg |grep VMware`" != "" ]; then
	echo "guest"      # vmware
elif [ "`dmesg |grep Hyper-V`" != "" ]; then
	echo "guest"      # ms hyper-v
elif [ "`dmesg |grep QEMU`" != "" ]; then
	echo "guest"      # kvm/qemu
else
	echo "physical"
fi
