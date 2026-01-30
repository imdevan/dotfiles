#!/bin/bash

# fzf file search function
# Usage:
#   fzf_vim           - Interactive mode: select file and open in nvim
#   fzf_vim <query>   - Search mode: return first match for query
fzf_vim() {
  if [ $# -eq 0 ]; then
    # No arguments - interactive mode, open selected file in nvim
    fzf --bind 'enter:become(nvim {})'
  else
    # With argument - search and return first match
    local file
    file="$(fzf --filter="$1" | head -n 1)"
    # If no response
    if [[ -z "$file" ]]; then
      echo "${red}file not found${reset}"
      # Else open in nvim
    else
      nvim "$file"
    fi
  fi
}

alias fv="fzf_vim"

with_vim() {
  if [ $# -eq 0 ]; then
    # No arguments - open folder in vim
    nvim
  else
    # With argument - search and return first match
    local file
    file="$(fzf --filter="$1" | head -n 1)"
    # If no response
    if [[ -z "$file" ]]; then
      nvim "$@"
      # Else open in nvim
    else
      nvim "$file"
    fi
  fi
}

alias v="with_vim"
