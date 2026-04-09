#!/bin/sh

# Function: tdpv
# Description: [Add description here]
# Usage: tdpv [arguments]
# Alias: t

function tdpv() {
local session_name="${1:-dpv}"
local location="${2:-~/Projects/dance-partner-vibes}"
local plan_file="tasks"



if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else

    # Create session and first window
    tmux new-session -d -s "$session_name" -n "$session_name" -c "$location"
    
    # Navigate to location and source functions to make them available
    tmux send-keys -t "$session_name:$session_name" "cd $location" C-m
    tmux send-keys -t "$session_name:$session_name" "source ~/dotfiles/functions/claude_window.sh" C-m
    tmux send-keys -t "$session_name:$session_name" "source ~/dotfiles/functions/split_dev.sh" C-m
    tmux send-keys -t "$session_name:$session_name" "source ~/dotfiles/functions/fzf_vim.sh" C-m
    
    # Call claude_window function to create dpv-cla window
    tmux send-keys -t "$session_name:$session_name" "claude_window" C-m
    
    # Wait a moment for the window to be created
    sleep 0.5
    
    # Go back to first window
    tmux select-window -t "$session_name:$session_name"
    
    # Call split_dev function to create dpv-serve window
    tmux send-keys -t "$session_name:$session_name" "split_dev" C-m
    
    # Wait a moment for the window to be created
    sleep 0.5
    
    # Go back to first window and open vim with plan file using v alias
    tmux select-window -t "$session_name:$session_name"
    tmux send-keys -t "$session_name:$session_name" "v $plan_file" C-m
    
    # Attach to the session
    tmux attach-session -t "$session_name"
  fi

}

# Create alias
alias t="tdpv"
