#!/bin/sh

# Function: clear-all-modules
# Description: Clear all node modules
# Usage: clear-all-modules [arguments]
# Alias: c

function clear-all-modules() {
    echo "Searching for all node_modules folders..."
    find . -type d -name 'node_modules' -prune -print

    echo -n "Delete all of the above node_modules directories? [Y/n] "
    read confirm

    # Default to 'y' if user just presses Enter
    confirm=${confirm:-y}

    if [[ "$confirm" == [yY] ]]; then
    echo "Deleting..."
        find . -type d -name 'node_modules' -prune -exec rm -rf '{}' +
        echo "${green}All node_modules folders deleted.${reset}"
    else
        echo "${red}Operation cancelled.${reset}"
    fi
}

# Create alias
alias 'can!'="clear-all-modules" # ! to prevent accidental trigger
