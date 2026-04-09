#!/bin/sh

# Function: claude_window
# Description: [Add description here]
# Usage: claude_window [arguments]
# Alias: cw

function claude_window() {
    # Get optional command argument, default to "bun dev"
    local cmd="${1:-cl}"
    local suffix="-cla"
    
    # Get current window name
    local current_window=$(tmux display-message -p '#W')
    
    # Create new window with suffix
    tmux new-window -n "${current_window}${suffix}"
    
    tmux send-keys "$cmd" C-m
}

# Create alias
alias cw="claude_window"
