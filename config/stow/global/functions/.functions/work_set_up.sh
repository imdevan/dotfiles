#!/bin/sh

# Function: work_set_up
# Description:
# try to attach tmux session 'work'
# create if not found
#
# if created 
#   - rename window 1: todo
#     - split with top: wee bottom half: calls alias todo
#   - create window 2: dot
#     - call dot alias
#   - create window 3: leave empty window
#   - re navigate back to window 1 if left

# Usage: work_set_up
# Alias: w

function work_set_up() {
    # Try to attach to existing 'work' session
    if tmux has-session -t work 2>/dev/null; then
        tmux attach-session -t work
    else
        # Create new session with first window named 'todo'
        tmux new-session -d -s work -n todo
        
        # Split 30% left vertical pane for todo
        tmux split-window -t work:1 -h -l 60%
        
        # Move to left pane and run todo
        tmux select-pane -t work:1.0
        tmux send-keys -t work:1.0 'todo' C-m
        
        # Move to right pane and split it horizontally
        tmux select-pane -t work:1.1
        tmux split-window -t work:1.1 -v
        
        # Send 'w2' to top right pane
        tmux send-keys -t work:1.1 'w2' C-m
        
        # Send 'cbonsai -li' to bottom right pane
        tmux send-keys -t work:1.2 'cbonsai -li' C-m
        
        # Create window 2 named 'dot'
        tmux new-window -t work:2 -n dot
        tmux send-keys -t work:2 'dot' C-m
        
        # Create window 3 (empty)
        tmux new-window -t work:3
        
        # if passed an arg pass through to window 3
        if [ -n "$1" ]; then
            tmux send-keys -t work:3 "$1" C-m
        fi
        
        # Navigate back to window 1
        tmux select-window -t work:1
        tmux select-pane -t work:1.0
        
        # Attach to the session
        tmux attach-session -t work
    fi
}

# Create alias
alias w="work_set_up"
