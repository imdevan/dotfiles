#!/bin/zsh
uwsm-app -- ghostty -e zsh -ic 'tre; exec zsh' &
uwsm-app -- qutebrowser &
sleep 2
hyprctl dispatch 'hl.dsp.layout("splitratio 1.33 exact")'
sleep 2
hyprctl dispatch 'hl.dsp.layout("splitratio 1.33 exact")'
sleep 2
hyprctl dispatch 'hl.dsp.layout("splitratio 1.33 exact")'

