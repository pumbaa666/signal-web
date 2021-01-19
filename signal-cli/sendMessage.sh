#!/bin/bash
myPhoneNumber=$(cat ./conf/SENDER_PHONE_NUMBER)

if [ -z "$1" ]; then
        echo "Enter recipient number"
        exit -1
fi
writeTo=$1

if [ -z "$2" ]; then
        echo "Enter message"
        exit -1
fi
message=$2
message=$message"
---
Sent from Debian"

# Install signal-cli
# https://github.com/AsamK/signal-cli/wiki/Quickstart
signal-cli -u $myPhoneNumber send -m "$message" $writeTo
