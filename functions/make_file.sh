#!/bin/sh

# Function: make_file
# Description: Create file at location
# Usage: make_file [arguments]
# Alias: mf

function make_file() {
    local file_path="$1"
    mkdir -p "$(dirname "$file_path")" && touch "$file_path"
    echo "File created at $file_path"
}

# Create alias
alias mf="make_file"
