#!/bin/bash

# Focus or launch Kiro
omarchy-launch-or-focus kiro

# Wait for Kiro window to be focused
sleep 0.4

# Send Ctrl+L
wtype -M ctrl l -m ctrl

# Wait
sleep 0.02

# Send Shift+Tab
wtype -M shift -k Tab -m shift

# Wait
sleep 0.02

# Send Shift+Tab again
# wtype -M shift -k Tab -m shift

# Wait
# sleep 0.4

# Send Enter
wtype -k Return
