#!/bin/bash
myPhoneNumber=$(cat ./conf/SENDER_PHONE_NUMBER)

result=$(signal-cli -u $myPhoneNumber -o json receive)
echo $result


#{"envelope":{"source":"+41763773595","sourceDevice":1,"timestamp":1611073933847,"syncMessage":{"sentMessage":{"timestamp":1611073933847,"message":"Lalala","expiresInSeconds":0,"viewOnce":false,"mentions":[],"attachments":[],"destination":"+41795561709"}}}}
echo "------"
echo 
senderNumber=$(echo $result | jq '.envelope.source')
message=$(echo $result | jq '.envelope.syncMessage.sentMessage.message')
timestamp=$(echo $result | jq '.envelope.syncMessage.sentMessage.timestamp')
attachments=$(echo $result | jq '.envelope.syncMessage.sentMessage.attachments

echo "[$senderNumber] $timestamp > $message"

