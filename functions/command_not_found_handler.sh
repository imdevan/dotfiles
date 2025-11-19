#!/bin/sh

# Function: command_not_found_handler
# Description: [Add description here]
# Usage: command_not_found_handler [arguments]
# Alias: cnfh

command_not_found_handler() {
  # $1 is the command name typed
  # $@ is the whole argument list

  cowsay -r "${red}Command not found :(${reset}"
  echo "\n${yellow}Checking for aliases...${reset}\n"

  is_alias "$1"
}

# Create alias
alias cnfh="command_not_found_handler"
