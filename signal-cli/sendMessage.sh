#!/bin/bash
myPhoneNumber=+41789998877

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
message=$message"
---
Envoyé depuis Debian"

# Install signal-cli
# https://github.com/AsamK/signal-cli/wiki/Quickstart
signal-cli -u $myPhoneNumber send -m "$message" $writeTo
