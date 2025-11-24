#!/bin/sh

# Function: command_not_found_handler
# Description: function that runs when a command is not found
# Usage: command_not_found_handler [bad_command]

command_not_found_handler() {
  # $1 is the command name typed
  # $@ is the whole argument list
  echo -e "${mauve}\"$1\"${reset}\nCommand not found :(${reset}" | cowsay -n
  echo "\n${yellow}Checking for aliases... Ctrl + C to cancel${reset}\n"
  is_alias "$1"
}
