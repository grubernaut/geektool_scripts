#!/bin/sh
HOST=$1
PING=`ping -q -c 1 $HOST`
if [[ $? -eq 0 ]] ; then
	TIME=`echo $PING |tail -1 | cut -d/ -f 5`
   echo ${TIME}ms away from $HOST
   exit 0
else
   echo $HOST is down!!!
   exit 2
fi
