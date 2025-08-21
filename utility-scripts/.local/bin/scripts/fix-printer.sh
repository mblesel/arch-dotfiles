#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo 'Error: You must run this script with root privileges.' >&2
    exit 1
fi

ppd_file='/etc/cups/ppd/325-Drucker.ppd'
ppd_file_bak='/etc/cups/ppd/325-Drucker.ppd.O'
erroneous_string='*cupsMandatory: job-account-id'
broken_line_num=2

function is_ppd_broken {
    [[ "$(sed -n "$broken_line_num"p "$ppd_file")" == "$erroneous_string" ]]
}

if ! is_ppd_broken ; then
    echo "Error: The PPD file doesn't look broken to me." >&2
    exit 1
fi

echo 'Fixing PPD file...'

cp "$ppd_file_bak" "$ppd_file"

# More manual approach if mv doesn't work for some reason (e.g. backup missing):
# sed -i "$broken_line_num"d "$ppd_file"

if is_ppd_broken ; then
    echo "Error: The PPD file somehow is still broken?" >&2
    exit 1
fi

echo 'Success!'

echo 'Restarting CUPS...'

systemctl restart cups

echo 'Done'
