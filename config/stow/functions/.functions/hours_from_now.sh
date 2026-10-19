#!/bin/sh

# Function: hours_from_now
# Description: take in a number of hours e.g. 154. print what day and time it will be after that many hours from current time
# Usage: hours_from_now [arguments]
# Alias: hfn

function hours_from_now() {
    if [ $# -ne 1 ]; then
        echo "Usage: hours_from_now <hours>" >&2
        # g_dang "Usage: hours_from_now <hours>" >&2
        return 1
    fi
    local target diff_days result
    target=$(date -d "+$1 hours" +%s)
    diff_days=$(( (target - $(date +%s)) / 86400 ))
    if [ "$diff_days" -eq 0 ]; then
        result=$(date -d "@$target" "+today %H:%M")
    elif [ "$diff_days" -eq 1 ]; then
        result=$(date -d "@$target" "+tomorrow %H:%M")
    elif [ "$diff_days" -lt 7 ]; then
        result="next $(date -d "@$target" "+%A %H:%M")"
    else
        result=$(date -d "@$target" "+%A %m-%d %H:%M")
    fi
    # g_suc "$result"
    echo "$result"
}

# Create alias
alias hfn="hours_from_now"
