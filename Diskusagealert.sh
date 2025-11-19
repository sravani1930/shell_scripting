#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0_$TIMESTAMP.log"
echo "script started executing at $TIMESTAMP" &>> $LOGFILE

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $ID -ne 0 ]
then
   echo -e "$R please switch to root user $N"
   exit 1
else
   echo "proceed to check diskusage"
fi



DISKUSAGE=$(df -hT | grep -vE 'tmp|file')
Threshold=1
while IFS= read line
do
   USAGE=$(echo $line | awk '{print $5F}' | cut -d % -f1)
   DISK_NAME=$(echo $line | awk '{print $F}')
   if [ $USAGE -ge $THRESHOLD ]
   then 
       Message+= "HigH usage alert on $DISKNAME with threshold limit $usage/n"
   fi

done <<< $DISKUSAGE

# if [ $DISKUSAGE -ge 10%]
# then
#     mail -s "Disk usage reaches more than 10%" sravani3093@example.com <<EOF
# Hi Team,
# This is to inform you below Filesystem reached more than 10%
# please perform the houskeeping to limit the filesystem thereshold

# Thanks & Regards,
# Monitoring Team
# EOF
