#!/bin/sh

# Function: math
# Description: Do math
# Usage: math [arguments]
# Alias: m

function math() {
  local result=$(echo "scale=10; $*" | bc -l)
  local rounded=$(printf "%.2f" "$result")
  # Remove trailing .00 or .0
  echo "$rounded" | sed -E 's/\.?0+$//' | sed 's/^\./0./'
}

# Create alias
alias m="math"
