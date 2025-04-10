#!/bin/sh

# Function: npm-latest
# Description: Get the latest version of package published to npm
# Usage: npm-latest [arguments]
# Alias: n

function npm-latest() {
    # Function implementation goes here
    # echo "Function npm-latest called"

    # If no argument is provided, return usage
    if [ -z "$1" ]; then
        echo "${orange}Usage: search-dir [arguments]${reset}"
        return 1
    fi
    
    npm view "$1" version

}

# Create alias
alias nl="npm-latest"
