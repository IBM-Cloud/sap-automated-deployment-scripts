#!/bin/bash

for FILE in ${@}
do
  if [[ ! -f $FILE ]]
  then
    echo -e "ERROR! \n The FILE ${FILE} does not exist!"
  fi
done
