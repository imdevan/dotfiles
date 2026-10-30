#!/bin/sh

# Find battery directory
bat_dir=$(find /sys/class/power_supply -maxdepth 1 -name "BAT*" | head -n 1)

if [ -z "$bat_dir" ]; then
  tmux display-message "No battery found"
  exit 0
fi

capacity=$(cat "$bat_dir/capacity" 2>/dev/null)
status=$(cat "$bat_dir/status" 2>/dev/null)

if [ -z "$capacity" ]; then
  tmux display-message "Failed to read battery capacity"
  exit 0
fi

# Choose an icon based on charging status
icon="🔋"
if [ "$status" = "Charging" ]; then
  icon="⚡"
fi

tmux display-message "${icon} Battery: ${capacity}% (${status})"
