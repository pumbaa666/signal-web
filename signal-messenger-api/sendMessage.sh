#!/bin/bash
myPhoneNumber=+41789998877
header="Content-Type: application/json"

if [ -z "$1" ]; then
        echo "Enter recipient"
        exit -1
fi
writeTo=$1

if [ -z "$2" ]; then
        echo "Enter message"
        exit -1
fi
message=$2

if  [[ $writeTo == \+* ]] ; then # if $writeTo starts with "+" --> is a phone number
        writeToNumber=$writeTo
else
        if  [[ $writeTo == 0* ]] ; then # if $writeTo starts "0" --> is a phone number, but replace the first "0" by "+41"
                writeToNumber=$(echo "$writeTo" | sed '0,/^0/s//\+41/')
        else # retreive contact from list
                writeToNumber=$(grep "$writeTo" ./contacts | awk '{print $2}')
                if [[ -z "$writeToNumber" ]] ; then
                        echo "Unable to find contact $writeTo"
                        exit -1
                fi
        fi
fi

echo "$writeToNumber < $message"
url="http://127.0.0.1:8080/v2/send"
#writeToNumber=+41761112233
curl -X POST -H "$header" -d '{"message": "'"$message"'", "number": "+41763773595", "recipients": ["'"$writeToNumber"'"]}' $url

#url -X POST -H "$header" -d '{"message": "'"$message"'", "number": "'"$myPhoneNumber"'", "recipients": ["'"$writeToNumber"'"]}' $url
