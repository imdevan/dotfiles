#!/bin/sh

width="${1}"
if [ -z "$width" ]; then
  width=$(tmux display-message -p '#{client_width}')
fi

# If width is still empty (e.g. no client active yet), default to a large layout
if [ -z "$width" ]; then
  width=120
fi

# Define the status elements
# Clock
clock='#[fg=color15,bg=default]#[bg=color15,fg=color0]#[fg=color15,bg=default]#[bg=color15,fg=color0] %H:%M#[default]#[fg=color15,bg=default]#[bg=color15,fg=color0]'

# Directory
dir='#[fg=color13,bg=default]#[fg=color0,bg=color13]󰉋 #[fg=color13,bg=default] #(sh ~/.tmux/scripts/status_path.sh "#{pane_current_path}" "#{@status_path_max_chars}" "#{@status_path_preserve_separators}") '

# Inactive window format
inactive_window_format='#[fg=color15,bg=default] #I #W '
current_window_format='#[fg=color5,bg=default]#[fg=color0,bg=color5]#I #W#[fg=color5,bg=default]'

# Large status right (all elements)
app='#[fg=color9]#[fg=color0,bg=color9] #[fg=color9,bg=default]#{E:@catppuccin_application_text}  '
session='#[fg=color13]#[fg=color0,bg=color13] #[fg=color13,bg=default]#{E:@catppuccin_session_text} '
battery='#(p=$(memory_pressure 2>/dev/null | awk '\''/percentage/{print $5}'\'' | tr -d '\''%'\''); [ -n "$p" ] && [ "$p" -le 20 ] && echo "#[fg=color9,bg=default]#[fg=color0,bg=color9]󱀙 #[fg=color9,bg=default] ${p}%")'

# Battery pill (togglable via @show_battery, always shown at 20% or less)
bat_pill='#(sh ~/.tmux/scripts/status_battery.sh "#{@show_battery}")'

status_right_lg="${app}${session}${battery}${dir}${bat_pill}${clock}"
status_right_md="${bat_pill}${dir}${clock}"
status_right_sm="${bat_pill}${dir}"

tmux set-window-option -g window-status-current-format "$current_window_format"

if [ "$width" -lt 56 ]; then
  # xxxs, xxs, xs (0-55)
  tmux set-option -g status-right ""
  tmux set-window-option -g window-status-format ""
elif [ "$width" -lt 80 ]; then
  # sm (56-83)
  tmux set-option -g status-right "$status_right_sm"
  tmux set-window-option -g window-status-format ""
elif [ "$width" -lt 120 ]; then
  # md (90-119)
  tmux set-option -g status-right "$status_right_md"
  tmux set-window-option -g window-status-format "$inactive_window_format"
else
  # lg (120+)
  tmux set-option -g status-right "$status_right_lg"
  tmux set-window-option -g window-status-format "$inactive_window_format"
fi
