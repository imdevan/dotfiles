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


# Function: two_arg_required
# Description: Helper function to ensure only one argument was passed
# Usage: two_arg_required [arguments]
# Alias: none
function two_arg_required() {
  if [ "$#" -lt 2 ]; then
    echo "${red}Error: At least two arguments are required${reset}"
    return 1
  fi

  return 0
}