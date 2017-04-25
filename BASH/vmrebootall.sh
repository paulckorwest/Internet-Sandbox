#!/bin/bash
#reboot all up virtual machines
(IFS='
'
#for x in `ls -l $1`; do echo $x; done)
for x in `xl list | awk`; do '{print $1 }'; done)
#xl list | while read  line ; do
#awk '{print $1}';
#done
#list = $'(xl list)';
#echo "$list"
#IFS=$'\n'
#for item in 'xl list'
#do 
#echo "Item: $item"
#done
#OUTPUT="$(xl list)"
#echo "${OUTPUT}"
#while read -r line; do
#   echo "... $line ..."
#done <<< "$OUTPUT"
xl list > /root/logs/activevm
while read word _; do printf '%s\n' "$word"; done < /root/logs/activevm
#cat > /root/logs/activevm
