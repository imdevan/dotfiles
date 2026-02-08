#!/bin/zsh
# gum utility functions
# https://github.com/charmbracelet/gum
#
# Usage examples:
#   gummy "Hello World"
#   gum_success "Operation completed!"
#   gum_danger "Error: Something went wrong"
#
# In a function:
#   my_function() {
#     if [[ $? -eq 0 ]]; then
#       gum_success "Build succeeded"
#     else
#       gum_danger "Build failed"
#     fi
#   }

# Base gum style wrapper with configurable border color
_gum_style() {
  local color="${1:-212}"
  shift
  gum style \
    --border-foreground "$color" --border rounded \
    --margin "1 2" --padding "1 2" \
    "$@"
  #
    # $(join_args "$@")
}

_gum_log() {
  local level="${1:-info}"
  shift
  gum log --time TimeOnly --structured --level "$level" "$@"
}

# Wrapper for default gum styles
gummy() { _gum_style 212 "$@"; }
g_suc() { _gum_style 2 "$@"; }
g_dang() { _gum_style 3 "$@"; }

# Logging functions
g_info() { _gum_log info "$@"; }
g_warn() { _gum_log warn "$@"; }
g_error() { _gum_log error "$@"; }

# Input function
g_input() {
  local prompt="${1:-Enter value}"
  local default="${2:-}"
  
  if [[ -n "$default" ]]; then
    gum input --placeholder "$prompt" --value "$default"
  else
    gum input --placeholder "$prompt"
  fi
}

alias gu=gummy
alias gus=gum_success
alias gud=gum_danger
