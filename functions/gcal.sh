#!/bin/sh

# Function: gcal
# Description: [Add description here]
# Usage: gcal [arguments]
# Alias: g

# alias gc="gcalcli"

function gcal_quick_add() {
  one_arg_required "$@" || return 1

  gcalcli quick "$1" 

  if [ "$#" -gt 1 ]; then
    shift
    gcalcli calw "$@"
  else
    gcalcli calw
  fi

  return 0
}

# Create alias
alias gcq="gcal_quick_add"
