#!/bin/sh

# Function: to_copy
# Description: Copy output
# Usage: copy [arguments]
# Alias: c

function to_copy() {
  "$@" | pbcopy
}

# Create alias
alias tc="to_copy"
