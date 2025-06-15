#!/bin/bash

# Function: simulator
# Description: Create or open ios simulator
# Usage: simulator [arguments]
# Alias: s

# Function to handle simulator booting and opening
function simulator() {
    local simulator_name=${1:-"iPhone 16"}

    # Check if simulator exists
    if xcrun simctl list devices | grep -q "${simulator_name}"; then
        # Boot the simulator if it exists
        xcrun simctl boot '${simulator_name}'; open -a Simulator
    else
        # Create and boot a new simulator
        xcrun simctl create "${simulator_name}" "${simulator_name}" "iOS"; \
        xcrun simctl boot '${simulator_name}'; \
        open -a Simulator
    fi
}

# Create alias
alias simu="simulator"
