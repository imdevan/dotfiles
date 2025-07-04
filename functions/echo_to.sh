#!/bin/sh

# Function: echo_to
# Description: Echo arg into file
# Usage: echo_to [arguments]
# Alias: et

function echo_to() {
    two_arg_required "$@" || return 1

    echo "$1" >> "$2"
}

# Create alias
alias et="echo_to"
