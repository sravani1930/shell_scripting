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

DISKUSAGE=$(df -hT | grep -vE 'tmp|file|Filesystem')
THRESHOLD=1
MESSAGE=""

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $7F}' | tr -d '%')
    DISK_NAME=$(echo $line | awk '{print $1F}')
    if [ $USAGE -ge $THRESHOLD ] 
    then
        MESSAGE+="High usage alert on $DISK_NAME: ${USAGE}%\n"
    fi
done <<< $DISKUSAGE

echo -e "message:\n$MESSAGE"



# if [ $DISKUSAGE -ge 10%]
# then
#     mail -s "Disk usage reaches more than 10%" sravani3093@example.com <<EOF
# Hi Team,
# This is to inform you below Filesystem reached more than 10%
# please perform the houskeeping to limit the filesystem thereshold

# Thanks & Regards,
# Monitoring Team
# EOF
