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
    echo "${green}Reloading ...${reset}"
    source ~/.zshrc &&
    echo "${green}Re-running: $last_command $* ${reset}"
    eval "$last_command $*"
}

# Create alias
alias rr="re_run"
