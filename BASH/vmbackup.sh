#!/bin/bash
#create mount directory
mkdir -p /mnt/bck
#mount the backup directory
umount /mnt/bck
mount 192.168.104.4:/volume2/FullBackup /mnt/bck 
#delete 7 day old files
find /mnt/bck/ -mtime +7 -type f -delete
#delete empty directories
find /mnt/bck/ -type d -empty -delete
DATE=`date +%Y-%m-%d-%H-%M-%S`;
mkdir /mnt/bck/$DATE
mkdir /mnt/bck/$DATE/cfg
arr=($(ls /dev/dm*))
#echo "${array[@]}"
prefix="/dev/dm-";
nameprefix="/dev/";
#match names with dm-x file
ls -l /dev/LVM > /mnt/bck/$DATE/directory-list
cp -r /etc/xen/*.cfg /mnt/bck/$DATE/cfg
for i in "${arr[@]}"
do
  name=${i#$nameprefix}
  echo $name
  digits=${i#$prefix}
  #disk files have the odd number, swap files are even numbered
  rem=$(($digits%2))
  if [ "$rem" -eq "1" ];
  then
   #cp /dev/$name /mnt/bck/$DATE/$name
   #http://stackoverflow.com/questions/3683910
   cmd="cp /dev/$name /mnt/bck/$DATE/$name"
   #echo $cmd
   eval "${cmd}" & > /dev/null &disown
   echo $digits;
  fi
done
