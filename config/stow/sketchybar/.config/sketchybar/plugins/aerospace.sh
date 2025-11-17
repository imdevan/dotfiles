#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# Currently undecided if i want to do border highlight or label color highlight
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME drawing=on
  sketchybar --set $NAME label.drawing=on
  # sketchybar --set $NAME background.drawing=on
  # sketchybar --set $NAME background.color=0xfff74f9e
  # sketchybar --set $NAME label.color=0xfff74f9e
  # sketchybar --set $NAME label.color=0xffce02d0
else
  sketchybar --set $NAME drawing=off
  sketchybar --set $NAME label.drawing=off
  # sketchybar --set $NAME background.drawing=off
  # sketchybar --set $NAME label.color=0xffffffff
fi
