#!/bin/bash
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
echo ">>>>>>>>>>>>>>>"
while read name
do
	mount -o loop /dev/LVM/$name-disk /mnt/vm
	echo $name 
        cp /root/default/php.ini /mnt/vm/etc/php5/apache2/php.ini
	umount /mnt/vm
	echo ">>>>>>>>>>>>>>>"
	echo " "
done < $1
