#!/bin/sh

# Function: open_github
# Description: Opens the github url of the current repo
# Usage: open_github [arguments]
# Alias: og

function open_github() {
    local remote_arg=${1:-origin}
    local remote

    if [[ "$remote_arg" == "u" || "$remote_arg" == "up" ]]; then
        remote="upstream"
    else
        remote="$remote_arg"
    fi

    # Get the remote origin URL
    local remote_url=$(git config --get remote."$remote".url)

    if [ -z "$remote_url" ]; then
        echo "Error: Remote '$remote' not found."
        return 1
    fi

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
