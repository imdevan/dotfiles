#!/bin/sh

# Function: re_run
# Description: refresh and rerun the last bash function
# Usage: re_run [arguments]
# Alias: rr

function re_run() {
    # Function implementation goes here
    # Get the last command from history
    local last_command=$(history | tail -n 1 | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')
    
    # Check if we have a command
    if [ -z "$last_command" ]; then
        echo "No previous command found in history"
        return 1
    fi
    
    # Execute the last command with any additional arguments
    echo "\nReloading ..."
    source ~/.zshrc &&
    echo "${light_blue}Re-running:${reset} $last_command $*"
    eval "$last_command $*"
    echo ""
}

# Create alias
alias rr="re_run"
