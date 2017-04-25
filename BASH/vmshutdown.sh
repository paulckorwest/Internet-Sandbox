#!/bin/bash
#shutdown  virtual machines
while read name
do
        if xl uptime | grep $name; then
                up[$name]=1
        fi
done < $1
while read name
do
	if [[ ${up[$name]} ]]; then
		printf "\n"
		echo "Shutdown $name"
		xl shutdown $name
	else
		echo "$name is not running"
	fi
done < $1
sleep 30
#shutdown does not always work in xl
#follow with destroy command 
#shutdown - gracefully shutdown a domain
#destroy is an immediate shutdown
while read name
do
	if [[ ${up[$name]} ]]; then
		xl destroy $name
	fi
done < $1
