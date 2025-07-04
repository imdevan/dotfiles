#!/bin/sh

# Function: encore_app_create
# Description: Create encore app
# Usage: encore_app_create [arguments]
# Alias: eac

function encore_app_create() {
    one_arg_required "$@" || return 1
    
    if [ "$#" -eq 1 ]; then 
        # Create the app
        encore app create "$1"
    else
        # Create the app with example
        encore app create "$1" --example="$2"
    fi
}

# Create alias
alias eace="encore_app_create"
