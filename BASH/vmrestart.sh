#!/bin/bash
#shutdown machines on list
#fsck machines on list
#restart machines on list
/root/scripts/vmshutdown.sh $1
#wait
/root/scripts/vmfsck.sh $1
#wait
/root/scripts/vmstart.sh $1
echo DONE

