#!/usr/bin/env bash

if ping -q -c 1 -W 1 192.168.0.47 > /dev/null 2>&1 
then
    PERCENTAGE=99
else
    PERCENTAGE=1
fi


echo {\"text\": \"\", \"alt\": \"\", \"tooltip\": \"\", \"class\": \"\", \"percentage\": $PERCENTAGE}

