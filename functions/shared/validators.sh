#!/bin/sh

# Function: one-arg-required
# Description: Helper function to ensure only one argument was passed
# Usage: one-arg-required [arguments]
# Alias: none
function one-arg-required() {
  if [ "$#" -lt 1 ]; then
    echo "${red}Error: At least one argument is required${reset}"
    return 1
  fi

  return 0
}

