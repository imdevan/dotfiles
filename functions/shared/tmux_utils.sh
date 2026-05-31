#!/bin/sh

# requires 2 args cmd and suffix 
function suffix_window() {
    local cmd="$1"
    local suffix="$2"
    local current_window=$(tmux display-message -p '#W')
    tmux new-window -n "${current_window}${suffix}"
    tmux send-keys "$cmd" C-m
}
