#!/bin/sh

# Function: fcd
# Description: [Add description here]
# Usage: fcd [arguments]
# Alias: f

function fzf_cd() {
  local dir
  dir=$(fd -t d . | fzf)
  if [[ -n "$dir" ]]; then
    z "$dir"
  fi
}

# Create alias
alias fcd="fzf_cd"
