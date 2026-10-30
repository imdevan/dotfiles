#!/bin/sh

# Function: make_directory
# Description: Create a directory and navigate to it
# Usage: make_directory [arguments]
# Alias: md

function make_directory() {
    mkdir -p "$1"
    cd "$1"
}

# Create alias
alias md="make_directory"
