#!/bin/bash
#https://www.debian.org/devel/passwordlessssh
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
echo ">>>>>>>>>>>>>>>"
while read name
do
	mount -o loop /dev/LVM/$name-disk /mnt/vm
	echo $name 
	fsck -y /dev/LVM/$name-disk
	umount /mnt/vm
done < $1
