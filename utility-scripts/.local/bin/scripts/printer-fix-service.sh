#!/bin/bash

FILE_TO_WATCH="$1"
SCRIPT_TO_RUN="$2"

if [ -z "$FILE_TO_WATCH" ] || [ -z "$SCRIPT_TO_RUN" ]; then
  echo "Usage: $0 <file_to_watch> <script_to_run>"
  exit 1
fi

while true; do
  echo "$FILE_TO_WATCH" | entr -np "$SCRIPT_TO_RUN"
done

