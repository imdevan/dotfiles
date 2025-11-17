#!/bin/sh

# Function: to_grep
# Description: calls first agrument, and greps it on second argument
# Usage: to_grep "ls -la" ".txt"
# Alias Usage: tg lsa .txt
# Alias: tg

to_grep() {
  two_arg_required "$@" || return 1

  eval "$1" | grep "$2"
}

# Create alias
alias tg="to_grep"
