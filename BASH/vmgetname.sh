#!/bin/bash
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
echo ">>>>>>>>>>>>>>>"
while read name
do
	mount -o loop /dev/LVM/$name-disk /mnt/vm
	echo $name 
	cat /mnt/vm/etc/hostname
	umount /mnt/vm
done < $1
for filename in /mnt/bck/2015-10-20-01-01-01/dm-*; 
do
 mount   $filename /mnt/vm
#	cat /mnt/vm/etc/hostname
 	echo $filename
 umount /mnt/vm
done
