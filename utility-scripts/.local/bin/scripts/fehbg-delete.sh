#! /bin/bash

WAL_PATH=$(cut -d " " -f 4 <~/.fehbg | tail -n 1 | tr -d "'")

read -r -p "Delete ""$WAL_PATH"" from disk? (y/n)?" choice
case "$choice" in
y | Y)
    rm "$WAL_PATH"
    echo "Deleted: $WAL_PATH"
    ;;
n | N)
    echo "Not deleting file."
    ;;
*) echo "invalid" ;;
esac
