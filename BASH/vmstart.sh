#!/bin/bash
#start a VM from an input list
while read name
do
	if xl uptime | grep -w $name; then
		up[$name]=1
	fi
done < $1
	
while read name
do
	printf "\n"
	if [[ ${up[$name]} ]]; then
	   	echo $name already started
	else
		echo "starting $name"
		xl create  /etc/xen/$name.cfg 
	fi
done < $1
