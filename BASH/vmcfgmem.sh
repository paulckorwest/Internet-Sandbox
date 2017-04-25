#!/bin/bash
echo ">>>>>>>>>>>>>>>"
#http://stackoverflow.com/questions/12735788/bash-find-and-replace-with-sed
#change first number to second number
cp -r /etc/xen/*.cfg /etc/xen/cfg-bck
while read name
do
	if [ -f "/etc/xen/cfg-bck/$name.cfg" ]; then
#	echo "file exists"
#	echo $name;
	sed "s/128/192/" /etc/xen/cfg-bck/$name.cfg > /etc/xen/$name.cfg
	fi
done < $1
