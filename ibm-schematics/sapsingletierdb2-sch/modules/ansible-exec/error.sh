#!/bin/sh

while [ `cat /tmp/ansible.sapsingletierdb2-$IP/ansible.$IP.log | egrep "FAILED\!|UNREACHABLE\!" | wc -l` -ge 1 ]
do
   echo -e "Ansible deployment ERROR: \n `cat /tmp/ansible.sapsingletierdb2-$IP/ansible.$IP.log | egrep "FAILED\!|UNREACHABLE\!"` \n  `tail -3 /tmp/ansible.sapsingletierdb2-$IP/ansible.$IP.log`";sleep 5

done

