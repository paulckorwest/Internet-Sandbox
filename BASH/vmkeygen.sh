#!/bin/bash
#https://www.debian.org/devel/passwordlessssh
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
echo ">>>>>>>>>>>>>>>"
while read name
do
	mount -o loop /dev/LVM/$name-disk /mnt/vm
	echo $name 
	mkdir -p /mnt/vm/root/.ssh
	cp /root/.ssh/id_rsa.pub /mnt/vm/root/.ssh/authorized_keys
	umount /mnt/vm
done < $1
