#!/bin/bash
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
echo ">>>>>>>>>>>>>>>"
while read name
do
	mount -o loop /dev/LVM/$name-disk /mnt/vm
	echo $name 
	ip="$(cat /mnt/vm/etc/network/interfaces | grep address)"
	echo "IP ${ip}"
	umount /mnt/vm
	p="$(tail -2 /var/log/xen-tools/$name.log)"
	echo "Linux ${p}"
	echo ">>>>>>>>>>>>>>>"
	echo " "
done < $1
