#!/bin/sh

bat_dir=$(find /sys/class/power_supply -maxdepth 1 -name "BAT*" 2>/dev/null | head -n 1)
if [ -z "$bat_dir" ]; then
  exit 0
fi

capacity=$(cat "$bat_dir/capacity" 2>/dev/null)
status=$(cat "$bat_dir/status" 2>/dev/null)

if [ -z "$capacity" ]; then
  exit 0
fi

if [ "$status" = "Charging" ]; then
  color="color2"
  if [ "$capacity" -ge 95 ]; then icon="󰂅"
  elif [ "$capacity" -ge 90 ]; then icon="󰂋"
  elif [ "$capacity" -ge 80 ]; then icon="󰂊"
  elif [ "$capacity" -ge 70 ]; then icon="󰢞"
  elif [ "$capacity" -ge 60 ]; then icon="󰂉"
  elif [ "$capacity" -ge 50 ]; then icon="󰢝"
  elif [ "$capacity" -ge 40 ]; then icon="󰂈"
  elif [ "$capacity" -ge 30 ]; then icon="󰂇"
  elif [ "$capacity" -ge 20 ]; then icon="󰂆"
  elif [ "$capacity" -ge 10 ]; then icon="󰢜"
  else icon="󰢟"
  fi
else
  color="color11"
  if [ "$capacity" -le 20 ]; then
    color="color1"
  fi
  if [ "$capacity" -ge 95 ]; then icon="󰁹"
  elif [ "$capacity" -ge 90 ]; then icon="󰂂"
  elif [ "$capacity" -ge 80 ]; then icon="󰂁"
  elif [ "$capacity" -ge 70 ]; then icon="󰂀"
  elif [ "$capacity" -ge 60 ]; then icon="󰁿"
  elif [ "$capacity" -ge 50 ]; then icon="󰁿"
  elif [ "$capacity" -ge 40 ]; then icon="󰁾"
  elif [ "$capacity" -ge 30 ]; then icon="󰁽"
  elif [ "$capacity" -ge 20 ]; then icon="󰁼"
  elif [ "$capacity" -ge 10 ]; then icon="󰁺"
  else icon="󰂃"
  fi
fi

printf "#[fg=%s,bg=color0]#[bg=%s,fg=color0]%s #[fg=%s,bg=color0] %s%%#[default]" "$color" "$color" "$icon" "$color" "$capacity"
