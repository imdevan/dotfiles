#!/bin/sh

# Function: math
# Description: Do math
# Usage: math [arguments]
# Alias: m

function math() {
  local result=$(echo "scale=10; $*" | bc -l)
  local rounded=$(printf "%.2f" "$result")
  # Remove trailing .00 or .0
  local cleaned=$(echo "$rounded" | sed -E 's/\.?0+$//' | sed 's/^\./0./')
  # Add commas for thousands, millions, etc.
  echo "$cleaned" | awk '{
    # Handle negative sign
    sign = ""
    if (substr($0, 1, 1) == "-") {
      sign = "-"
      num = substr($0, 2)
    } else {
      num = $0
    }
    
    # Split into integer and decimal parts
    n = split(num, parts, ".")
    int_part = parts[1]
    dec_part = (n > 1) ? "." parts[2] : ""
    
    # Add commas to integer part (working from right to left)
    len = length(int_part)
    formatted = ""
    pos = len
    while (pos > 0) {
      start = (pos - 2 >= 1) ? pos - 2 : 1
      chunk = substr(int_part, start, pos - start + 1)
      if (formatted == "") {
        formatted = chunk
      } else {
        formatted = chunk "," formatted
      }
      pos = start - 1
    }
    
    print sign formatted dec_part
  }'
}

# Create alias
alias m="math"
