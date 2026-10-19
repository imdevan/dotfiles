#!/bin/sh

# Function: search_dir
# Description: searches current directory for a file or folder with the given name
# Usage: search_dir [arguments]
# Alias: sd

function search_dir() {
    # Function implementation goes here
    echo "Function search_dir called"

    # If no argument is provided, return usage
    if [ -z "$1" ]; then
        echo "${orange}Usage: search_dir [arguments]${reset}"
        return 1
    fi
    

    # If -d flag passed search for a directory with the given name
    if [ "$1" = "-d" ]; then
        echo "Searching for directory with name: $2"
        echo "${green}"
        find . -maxdepth 1 -type d -name "$2"
        echo "${reset}"
        return 0
    fi
    
    # Default case search for a file or folder with the given name
        echo "${green}"
        find . -maxdepth 1 -name "*$1*"
        echo "${reset}"
}

# Create alias
alias sd="search_dir"
