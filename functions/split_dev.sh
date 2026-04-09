#!/bin/sh

# Function: split_dev
# Description: 
# get the current tmux window name
#   create a new window with a new name "current_window$suffix"
# split the current tmux homrizontally
#   top pane:
#     cd app/backend
#     split top pane
#       left side: run bun dev
#       right side: run lazydocker
#   bottom pane:
#     run bun dev
#
# Usage: split_dev [arguments]
# Alias: sd
#

function split_dev() {
    # Get optional command argument, default to "bun dev"
    local cmd="${1:-bun dev}"
    local suffix="-serve"
    
    # Get current window name
    local current_window=$(tmux display-message -p '#W')
    
    # Create new window with suffix
    tmux new-window -n "${current_window}${suffix}"
    
    # Split horizontally (top and bottom)
    tmux split-window -v
    
    # Select top pane
    tmux select-pane -t 0
    
    # Change to app/backend directory in top pane
    tmux send-keys 'cd app/backend' C-m
    
    # Split top pane vertically (left and right)
    tmux split-window -h
    
    # Send command to left side of top pane
    tmux select-pane -t 0
    tmux send-keys "$cmd" C-m
    
    # Send 'lazydocker' to right side of top pane
    tmux select-pane -t 1
    tmux send-keys 'lazydocker' C-m
    
    # Select bottom pane
    tmux select-pane -t 2

    # Change to app/expo directory in bottom pane
    tmux send-keys 'cd app/expo' C-m

    tmux send-keys "$cmd" C-m
}

# Create alias
alias sd="split_dev"
