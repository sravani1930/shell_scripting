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
FROM="sravani3093@gmail.com"
TO="sravani.jamithireddy@gmail.com"
SUBJECT="Disk Usage Alert on Server $(hostname)"
EMAIL_TEXT="/tmp/email_body_$$.txt"

cat <<EOF > "$EMAIL_TEXT"
Hello Team,

Please find the disk usage alert details below:

$message

Kindly perform housekeeping to free up disk space.

Thanks & Regards,
Linux Admin
EOF

EMAIL_JSON="/tmp/email_json_$$.json"

cat <<EOF > "$EMAIL_JSON"
{
  "Source": "$FROM",
  "Destination": {
    "ToAddresses": ["$TO"]
  },
  "Message": {
    "Subject": {
      "Data": "$SUBJECT"
    },
    "Body": {
      "Text": {
        "Data": "$(sed 's/"/\\"/g' "$EMAIL_TEXT")"
      }
    }
  }
}
EOF

aws ses send-email --cli-input-json file://$EMAIL_JSON

rm -f "$EMAIL_TEXT" "$EMAIL_JSON"



