#!/usr/bin/env zsh

# Script: npm_latest
# Description: Get the latest version of package published to npm
# Usage: npm_latest [arguments]
# Alias: nl

source "$HOME/.functions/shared/colors.sh"

function npm_latest() {
    # Function implementation goes here
    # echo "Function npm_latest called"

    # If no argument is provided, return usage
    if [ -z "$1" ]; then
        echo "${orange}Usage: search_dir [arguments]${reset}"
        return 1
    fi
    
    npm view "$1" version

}

npm_latest "$@"
