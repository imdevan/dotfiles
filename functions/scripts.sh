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
    
    # Print header
    echo "\nScripts:"
    echo "----------------------------------------"
    # Get and format the scripts using jq
    # Print as a table with aligned columns
    # printf "  ${blue}%-20s${yellow}%s${reset}\n" "Script" "Command"
    # printf "  ${blue}%-20s${yellow}%s${reset}\n" "--------------------" "--------------------"
    echo "$package_json" | jq -r '.scripts | to_entries[] | "\(.key)\t\(.value)"' | while IFS=$'\t' read -r key value; do
        printf "  ${blue}%-12s${yellow}%-20s${reset}\n" "$key" "$value"
    done
    echo "----------------------------------------"
    # echo "--------------------------------"
}

# Create alias
alias sc="scripts"
