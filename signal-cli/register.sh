#!/bin/bash
myPhoneNumber=$(cat ./conf/SENDER_PHONE_NUMBER)
header="Content-Type: application/json"

if [ -z "$myPhoneNumber" ]; then
	echo "No phone in ./conf/SENDER_PHONE_NUMBER"
	exit -1
fi

if [ -z "$1" ]; then
        #Register
	signal-cli -u $myPhoneNumber register
else
        #Verify
        code=$1
	signal-cli -u $myPhoneNumber verify $code
fi
