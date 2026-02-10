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

# Confirmation dialog
# Usage: g_confirm [prompt] [affirmative] [negative]
# Examples:
#   g_confirm
#   g_confirm "Delete files?"
#   g_confirm "Continue?" "Yes" "No"
#   if g_confirm "Proceed?"; then echo "Confirmed"; fi
g_confirm() {
  local prompt="${1:-Are you sure?}"
  local affirmative="${2:-Yes}"
  local negative="${3:-No}"
  
  echo ""
  gum confirm "$prompt" \
    --affirmative "$affirmative" \
    --negative "$negative" \
    --padding "1 2"
  echo ""
}

alias gu=gummy
alias gus=gum_success
alias gud=gum_danger
