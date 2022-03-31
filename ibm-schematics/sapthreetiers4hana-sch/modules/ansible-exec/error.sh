#!/bin/sh

while [ `cat /tmp/ansible.sapthreetiers4hana-$IP/ansible.$IP.log | egrep "FAILED\!|UNREACHABLE\!" | wc -l` -ge 1 ]
do
   echo -e "Ansible deployment ERROR: \n `cat /tmp/ansible.sapthreetiers4hana-$IP/ansible.$IP.log | egrep "FAILED\!|UNREACHABLE\!"` \n  `tail -3 /tmp/ansible.sapthreetiers4hana-$IP/ansible.$IP.log`";sleep 5

done
