#!/bin/sh

# Function: to-copy
# Description: Copy output
# Usage: copy [arguments]
# Alias: c

function to-copy() {
  "$@" | pbcopy
}

# Create alias
alias tc="to-copy"
