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

# Hidden unless toggled on (@show_battery passed as $1), but always shown at 20% or less
if [ "$1" != "1" ] && [ "$capacity" -gt 20 ]; then
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

  printf "#[fg=%s,bg=color0]#[bg=%s,fg=color0]%s #[fg=%s,bg=color0] %s%%#[default] " "$color" "$color" "$icon" "$color" "$capacity"
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

  if [ "$capacity" -le 10 ]; then
    # Flash inverting color warning on 10% or less battery while not charging
    sec=$(date +%s)
    if [ $((sec % 2)) -eq 1 ]; then
      printf "#[fg=color0,bg=color1]#[bg=color0,fg=color1]%s #[fg=color0,bg=color1] %s%%#[default] " "$icon" "$capacity"
    else
      printf "#[fg=color1,bg=color0]#[bg=color1,fg=color0]%s #[fg=color1,bg=color0] %s%%#[default] " "$icon" "$capacity"
    fi
  else
    printf "#[fg=%s,bg=color0]#[bg=%s,fg=color0]%s #[fg=%s,bg=color0] %s%%#[default] " "$color" "$color" "$icon" "$color" "$capacity"
  fi
fi
