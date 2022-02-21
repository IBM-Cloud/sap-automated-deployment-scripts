#!/bin/sh

while [ `ps -ef | grep sapsingletierdb2-$IP | wc -l` -gt 1 ]
do
   tail /tmp/ansible.sapsingletierdb2-$IP/ansible.$IP.log; sleep 10
   if [ `ps -ef | grep sapsingletierdb2-$IP | wc -l` -eq 1 ]
   then
      break
   else
      tail /tmp/ansible.sapsingletierdb2-$IP/ansible.$IP.log; sleep 10
   fi
done
