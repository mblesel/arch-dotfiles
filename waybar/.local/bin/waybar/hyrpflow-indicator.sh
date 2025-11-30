#!/bin/bash

if pgrep -f "rec.*hyprflow" >/dev/null; then
  echo '{"text": "󱑽 ", "class": "active"}'
else
  echo '{"text": ""}'
fi
