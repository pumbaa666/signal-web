#!/bin/bash
myPhoneNumber=+41789998877
header="Content-Type: application/json"

if [ -z "$1" ]; then
        echo "Enter recipient"
        exit -1
fi
writeTo=$1

if [ -z "$2" ]; then
        #Register
        url="http://127.0.0.1:8080/v1/register/$myPhoneNumber"
        curl -X POST -H "$header" $url
else
        #Verify
        code=$2
        url="http://127.0.0.1:8080/v1/register/$myPhoneNumber/verify/$code"
        curl -X POST -H "$header" $url
fi
