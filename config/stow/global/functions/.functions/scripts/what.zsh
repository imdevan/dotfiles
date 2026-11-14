#!/usr/bin/env zsh

# Script: what
# Description: what is this thing
# Type: script
# Alias: what

source "$HOME/.functions/shared/gummy.sh"

main() {
  g_suc "$(echo "Witch:" && witch "$@" 2>&1)"

  g_suc "$(echo "Help:" && "$@" --help 2>&1 | head -4)" "..."
}

main "$@"
