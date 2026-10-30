#!/bin/sh

# Display window width (along with height and index/name for clarity)
width=$(tmux display-message -p '#{window_width}')
height=$(tmux display-message -p '#{window_height}')
name=$(tmux display-message -p '#{window_name}')
index=$(tmux display-message -p '#{window_index}')

tmux display-message "Window ${index} (${name}): ${width} cols x ${height} lines"
