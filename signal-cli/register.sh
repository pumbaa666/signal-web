#!/bin/bash
myPhoneNumber=$(cat ./conf/SENDER_PHONE_NUMBER)
header="Content-Type: application/json"

if [ -z "$myPhoneNumber" ]; then
	echo "No phone in ./conf/SENDER_PHONE_NUMBER"
	exit -1
fi

if [ -z "$1" ]; then
        #Register
        url="http://127.0.0.1:8080/v1/register/$myPhoneNumber"
        curl -X POST -H "$header" $url
else
        #Verify
        code=$1
        url="http://127.0.0.1:8080/v1/register/$myPhoneNumber/verify/$code"
        curl -X POST -H "$header" $url
fi
