#!/bin/sh

# Function: split
# Description: [Add description here]
# Usage: split [arguments]
# Alias: s

function split() {
    # Split horizontally (top and bottom)
    tmux split-window -v
    
    # Select top pane
    tmux select-pane -t 0
    
    # Change to app/backend directory in top pane
    tmux send-keys 'cd app/backend' C-m
    
    # Select bottom pane
    tmux select-pane -t 1

    # Change to app/expo directory in bottom pane
    tmux send-keys 'cd app/expo' C-m

  # if [[ -n "$1"]]; then
  #   tmux send-keys "$1" C-m
  # end
}

# Create alias
alias sp="split"
