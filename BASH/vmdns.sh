#!/bin/bash
#http://stackoverflow.com/questions/1310422/how-to-do-something-to-every-file-in-a-directory-using-bash
echo "<><><><><><><><>>>>><><><><<><><><>><><><><><><><><>";
#http://stackoverflow.com/questions/1310422/how-to-do-something-to-every-file-in-a-directory-using-bash
#http://stackoverflow.com/questions/4467735/how-to-find-substring-inside-a-string-or-how-to-grep-a-variable
#http://stackoverflow.com/questions/12671406/bash-removing-part-of-a-string
#http://stackoverflow.com/questions/20551566/display-current-date-and-time-without-punctuation
#http://stackoverflow.com/questions/9768228/bash-script-store-command-output-into-variable
#http://www.thegeekstuff.com/2009/11/unix-sed-tutorial-append-insert-replace-and-count-file-lines/#replace_lines
#
#
#current date
cur=$(/bin/date +%Y%m%d%H%M);
#echo $cur;
#backup current files
cp /etc/bind/elab.cis.for /etc/bind/backup/elab.cis.for.$cur;
cp /etc/bind/elab.cis.rev /etc/bind/backup/elab.cis.rev.$cur;
#start new forward and reverse lookup zone files
#
cat /etc/bind/stub/elab.cis.for.stub > /etc/bind/elab.cis.for
cat /etc/bind/stub/elab.cis.rev.stub > /etc/bind/elab.cis.rev
#
#create mount directories
#
mkdir /mnt/vm >& /dev/null
umount /mnt/vm >& /dev/null
#string manipulation
extra=" address ";
prefix="/dev/LVM/";
#subnet="192.168.104.";
#subnet 104-111 addresses
subnet="192.168.";
#
#loop through all virtual machines in /dev/LVM extracting the machine name
#machine name matches username and domain name
for i in  /dev/LVM/*
do
	echo "$i";
	#format of machines lised in/dev/LVM
	#/dev/LVM/name-disk
	#need to extract the variable name
	if echo "$i" | grep -q "disk"; then
	  #remove the prefix
	  name=${i#$prefix}
	  #remove the -disk suffix
	  name=${name%-disk}
	  #now have machine name
	  echo $name
	  #mount each virtual machine
	  mount -o loop /dev/LVM/$name-disk /mnt/vm
	  #get the IP address for each virtual machine
	  addr=$(cat /mnt/vm/etc/network/interfaces | grep address)
	  addr=${addr#$extra}
	  #format the IP address for the DNS forward lookup zone record
	  echo -ne $name '\t' IN '\t' A '\t' $addr
	  echo -ne $name '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  #overkill for one class!!?
	  #Generate 5 additional names pointing to same IP address
	  #Used for virtual web  hosting, CIS1715 and CIS 1750, other classes ??
	  echo -ne $name'1' '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  echo -ne $name'2' '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  echo -ne $name'3' '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  echo -ne $name'4' '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  echo -ne $name'5' '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.for
	  echo " " >> /etc/bind/elab.cis.for;
	  echo " ";
	  #format the address for the reverse lookup zone record
	  addr=${addr#$subnet}
	  echo -ne $addr '\t' IN '\t' PTR '\t' $name.elab.cis
	  echo -ne $name '\t' IN '\t' A '\t' $addr >> /etc/bind/elab.cis.rev
	  echo " "  >> /etc/bind/elab.cis.rev;
	  echo " ";
	  umount /mnt/vm
	fi
done
#ppend virtual hosting domains
cat /etc/bind/stub/elab.cis.virtual.domains >> /etc/bind/elab.cis.for
