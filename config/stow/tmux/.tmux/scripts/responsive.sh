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
clock='#[fg=color15,bg=color0]#[bg=color15,fg=color0]#[fg=color15,bg=color0]#[bg=color15,fg=color0] %H:%M#[default]#[fg=color15,bg=color0]#[bg=color15,fg=color0]'

# Directory
dir='#[bg=#{@thm_pink},fg=color0]#[reverse]#[noreverse]󰉋 #[fg=#{@thm_pink},bg=color0] #(sh ~/.tmux/scripts/status_path.sh "#{pane_current_path}" "#{@status_path_max_chars}" "#{@status_path_preserve_separators}") '

# Inactive window format
window_format_default='#[fg=#181926,bg=color0]#[fg=color0,reverse]#[none]#[fg=color15]#I #[fg=#cad3f5,bg=color0]#[fg=color15]#W#[fg=color0,reverse]#[none]'

# Large status right (all elements)
app='#[fg=color9]#[fg=color0,bg=color9] #[fg=color9,bg=color0]#{E:@catppuccin_application_text}  '
session='#[fg=color13]#[fg=color0,bg=color13] #[fg=color13,bg=color0]#{E:@catppuccin_session_text} '
battery='#(p=$(memory_pressure 2>/dev/null | awk '\''/percentage/{print $5}'\'' | tr -d '\''%'\''); [ -n "$p" ] && [ "$p" -le 20 ] && echo "#[bg=#{@thm_flamingo},fg=color0]#[reverse]#[noreverse]󱀙 #[fg=#{@thm_flamingo},bg=color0] ${p}%")'

# Battery pill (togglable via @show_battery)
show_bat=$(tmux show-option -gv @show_battery 2>/dev/null)
if [ "$show_bat" = "1" ]; then
  bat_pill='#(sh ~/.tmux/scripts/status_battery.sh) '
else
  bat_pill=""
fi

status_right_lg="${app}${session}${battery}${dir}${bat_pill}${clock}"
status_right_sm="${bat_pill}${clock}"
status_right_md="${bat_pill}${clock}"

if [ "$width" -lt 56 ]; then
  # xxxs, xxs, xs (0-55)
  tmux set-option -g status-right ""
  tmux set-window-option -g window-status-format ""
elif [ "$width" -lt 84 ]; then
  # sm (56-83)
  tmux set-option -g status-right "$status_right_sm"
  tmux set-window-option -g window-status-format ""
elif [ "$width" -lt 120 ]; then
  # md (90-119)
  tmux set-option -g status-right "$status_right_md"
  tmux set-window-option -g window-status-format "$window_format_default"
else
  # lg (120+)
  tmux set-option -g status-right "$status_right_lg"
  tmux set-window-option -g window-status-format "$window_format_default"
fi
