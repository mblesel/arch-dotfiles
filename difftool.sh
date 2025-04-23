#!/usr/bin/env bash

DIFF_RAW=$(diff -qr "$1" "$2")

echo "$DIFF_RAW" | grep and | while read -r _ FILE1 _ FILE2 _; do
    nvim -d "$FILE1" "$FILE2"
done

echo "New files:"
echo "$DIFF_RAW" | grep Only
