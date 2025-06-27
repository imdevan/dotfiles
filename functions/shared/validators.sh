#!/bin/sh

# Function: one_arg_required
# Description: Helper function to ensure only one argument was passed
# Usage: one_arg_required [arguments]
# Alias: none
function one_arg_required() {
  if [ "$#" -lt 1 ]; then
    echo "${red}Error: At least one argument is required${reset}"
    return 1
  fi

  return 0
}

