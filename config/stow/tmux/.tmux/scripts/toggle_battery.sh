#!/bin/sh

# Toggle the @show_battery tmux global option
state=$(tmux show-option -gv @show_battery 2>/dev/null)

if [ "$state" = "1" ]; then
  tmux set-option -g @show_battery 0
else
  tmux set-option -g @show_battery 1
fi

# Refresh status bar layout
sh ~/.tmux/scripts/responsive.sh
