#!/bin/bash
# deletes installed virtual machine
while read name
do
	xl destroy $name
	lvchange -a n /dev/LVM/$name-swap
	lvchange -a n /dev/LVM/$name-disk
	lvremove /dev/LVM/$name-swap
	lvremove /dev/LVM/$name-disk
	rm /etc/xen/$name.cfg
	rm /var/log/xen-tools/$name.log
	rm /var/log/xen/xl-$name.log*
done < $1
