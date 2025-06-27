#!/bin/sh

# Function: open_github
# Description: Opens the github url of the current repo
# Usage: open_github [arguments]
# Alias: og

function open_github() {
    # Get the remote origin URL
    local remote_url=$(git config --get remote.origin.url)
    
    # Convert SSH URL to HTTPS if needed
    if [[ $remote_url == *"git@"* ]]; then
        remote_url=${remote_url/git@github.com:/https://github.com/}
    fi
    
    # Remove .git suffix if present
    remote_url=${remote_url%.git}
    
    # Open URL in default browser
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$remote_url"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open "$remote_url"
    else
        echo "Unsupported operating system"
        return 1
    fi
}

# Create alias
alias og="open_github"
