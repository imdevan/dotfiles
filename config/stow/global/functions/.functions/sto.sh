#!/bin/sh

# Function: sto
# Description: Functions to help with stowing dotfiles
# Usage: sto [arguments]
# Alias: s

function copy_to_stow() {
    # Function implementation goes here
    echo "Function copy_to_stow called"
    local copy_to=""

#   if second argument is present add it to the file path before the first 
    # If second argument is present, add it to the file path before the first
    if [ $# -gt 1 ]; then
        copy_to="~/dotfiles/config/stow/$2/$1"
    else
        copy_to="~/dotfiles/config/stow/$1"
    fi
    
    # Copy the file to the stow directory
    cp $1 ~/dotfiles/config/stow/$file_name
}
alias cts="copy_to_stow"
