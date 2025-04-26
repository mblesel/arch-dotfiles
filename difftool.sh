#!/usr/bin/env bash

# Get the differences between two directories
DIFF_OUTPUT=$(diff -qr "$1" "$2")

# Open differences in nvim for files that differ
echo "$DIFF_OUTPUT" | grep "and" | while read -r _ FILE1 _ FILE2 _; do
    nvim -d "$FILE1" "$FILE2"
done

# Display new files that are only in one directory
echo "New files:"
echo "$DIFF_OUTPUT" | grep "Only"
