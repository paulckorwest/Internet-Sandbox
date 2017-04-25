#!/bin/bash
#creates a virtual machine from input list
#input list contains CNM username, one per line
while read name
do
	printf "\n"
	echo "Creating $name"
	printf "\n"
	xen-create-image --hostname $name --ip=auto --vcpus 2 --pygrub --dist jessie --lvm LVM
done < $1
