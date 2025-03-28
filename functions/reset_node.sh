#!/bin/sh

# Function: reset_node
# Description: Reset node to lts
# Usage: reset_node
# Alias: rn

function reset_node() {
    # Get the current directory
    current_dir=$(pwd)

    # Navigate out of the current directory
    cd ~

    # Set node version to lts
    nvm use node --lts

    # Navigate back to the current directory
    cd $current_dir
}

# Create alias
alias rn="reset_node"
