#!/bin/sh

# Function: find_string
# Description: Grep in directory
# Usage: find_string [arguments]
# Alias: fs

function find_string() {
    # Function implementation goes here
    if [[ -z "$1" ]]; then
        echo "Usage: search <search_term>"
        return 1
    fi

    local term="$1"
    shift

    grep -r --color=auto "$term" "${@:-.}"
}

# Create alias
alias fs="find_string"
