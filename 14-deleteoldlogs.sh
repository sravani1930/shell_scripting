#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"

if [ $ID -ne 0 ] {
then
   echo " please switch to root user"
   exit 1
else
   echo "proceed to delete package"
fi
}

find /var/log/ -type f -name "*.log" -mtime +15 &>> $LOGFILE
if [ $? -ne 0] {
then
    echo " There are no log files available more than 15 days "
    exit 1
else
    echo "LOGFILES more than 15 days has been removed"   
}
