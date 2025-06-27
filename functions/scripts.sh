#!/bin/sh

# Function: scripts
# Description: Show available scripts in package.json
# Usage: scripts [arguments]
# Alias: sc

function scripts() {
    # Check if package.json exists
    if [ ! -f "package.json" ]; then
        echo "${red}Error: package.json not found${reset}"
        return 1
    fi

    # Get the package.json file
    local package_json=$(cat package.json)
    

    # Get the scripts object
    local scripts=$(echo "$package_json" | jq -r '.scripts')
    
    # Remove the curly braces and quotes
    # local scripts=$(echo "$scripts" | sed 's/[\[\]"]//g')

    # Print out the scripts
    echo "$scripts"
}

# Create alias
alias sc="scripts"
