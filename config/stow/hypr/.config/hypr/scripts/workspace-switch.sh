#!/bin/bash
direction=$1
current=$(hyprctl activeworkspace -j | jq '.id')
max=5  # Adjust to your max workspace number

if [ "$direction" = "next" ]; then
    if [ "$current" -ge "$max" ]; then
        next=1
    else
        next=$((current + 1))
    fi
    hyprctl dispatch workspace $next
else
    if [ "$current" -le 1 ]; then
        prev=$max
    else
        prev=$((current - 1))
    fi
    hyprctl dispatch workspace $prev
fi
