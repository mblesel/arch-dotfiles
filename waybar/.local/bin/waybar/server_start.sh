#!/usr/bin/env bash

if ping -q -c 1 -W 1 192.168.0.47 > /dev/null 2>&1 
then
    echo "Server already running"
else
    wol e0:3f:49:78:95:8b
fi



