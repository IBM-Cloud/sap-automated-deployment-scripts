#!/bin/sh

while [ `cat /tmp/$HOSTNAME.precheck.log | egrep "ERROR"| wc -l` -ge 1 ]
do
   echo -e "SAP PATH ISSUE: \n `cat /tmp/$HOSTNAME.precheck.log` \n" ; sleep 5
done
