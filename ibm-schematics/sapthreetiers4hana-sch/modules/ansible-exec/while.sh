#!/bin/sh

while [ `ps -ef | grep sapthreetiers4hana-$IP | wc -l` -gt 1 ]
do
   tail /tmp/ansible.sapthreetiers4hana-$IP/ansible.$IP.log; sleep 10
   if [ `ps -ef | grep sapthreetiers4hana-$IP | wc -l` -eq 1 ]
   then
      break
   else
      tail /tmp/ansible.sapthreetiers4hana-$IP/ansible.$IP.log; sleep 10
   fi
done
