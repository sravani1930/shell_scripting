#!/bin/bash

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
DISK_THRESHOLD=1
message=""

while IFS= read line
do
    usage=$(echo $line | awk '{print $6F}' | cut -d % -f1)
    partition=$(echo $line | awk '{print $1F}')
    if [ $usage -ge $DISK_THRESHOLD ]
    then
        message+="High Disk Usage on $partition: $usage <br>"
    fi
done <<< $DISK_USAGE

echo -e "Message: $message"

mail -s "$partition reached  more than 1%" sravani3093@example.com <<EOF
Hi Team,
This is to inform you below Filesystem reached more than 10%
please perform the houskeeping to limit the filesystem thereshold

$partition: $usage
Thanks & Regards,
Monitoring Team
EOF