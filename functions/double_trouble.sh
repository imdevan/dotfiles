#!/bin/sh

# Function: double_trouble
# Description: Creates two tmux windows with splits, each running a script in a specific location
# Usage: double_trouble <location1> <window1> <script1> <location2> <window2> <script2>
# Alias: dt

# location1
# window1
# script1
# location2
# window2
# script2
#
# implement function that will go to a location, rename the tmux window, create tmux split, run a script in that split (that may be on going) then create a new tmux window, go to location2 rename tmux to window2, split the window, and run a second script that may be on going

function double_trouble() {
    local location1="$1"
    local window1="$2"
    local script1="$3"
    local location2="$4"
    local window2="$5"
    local script2="$6"

    # Window 1: go to location1, rename window, split, run script1
    cd "$location1" || return 1
    tmux rename-window "$window1"
    tmux split-window -h
    tmux send-keys -t 1 "$script1" C-m

    # Create new window, go to location2, rename, split, run script2
    tmux new-window
    tmux send-keys "cd $location2" C-m
    tmux rename-window "$window2"
    tmux split-window -h
    tmux send-keys -t 1 "$script2" C-m
}

# Create alias
alias dt="double_trouble"
