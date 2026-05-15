#!/bin/zsh
uwsm-app -- ghostty -e zsh -ic 'dp; exec zsh' &
uwsm-app -- qutebrowser &
sleep 2
hyprctl dispatch splitratio exact 1.33
sleep 2
hyprctl dispatch splitratio exact 1.33
sleep 2
hyprctl dispatch splitratio exact 1.33

