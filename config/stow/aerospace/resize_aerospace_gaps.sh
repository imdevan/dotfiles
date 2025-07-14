#!/usr/bin/env bash

resize_aerospace_gaps() {
  local config_file="$(dirname "${BASH_SOURCE[0]}")/.aerospace.toml"
  local -a configs=(
    $'    inner.horizontal = 0\n    inner.vertical =   0\n    outer.left =       0\n    outer.bottom =     0\n    outer.top =        0\n    outer.right =      0'
    $'    inner.horizontal = 10\n    inner.vertical =   8\n    outer.left =       10\n    outer.bottom =     10\n    outer.top =        10\n    outer.right =      10'
    $'    inner.horizontal = 20\n    inner.vertical =   16\n    outer.left =       20\n    outer.bottom =     20\n    outer.top =        20\n    outer.right =      20'
  )

  local input="${1:-1}"
  local index=$((input - 1))

  if ((index < 0 || index >= ${#configs[@]})); then
    echo "Invalid config index: $input"
    echo "Available indices: 1 to ${#configs[@]}"
    return 1
  fi

  awk -v replacement="${configs[$index]}" '
    BEGIN { found = 0; lines_skipped = 0 }
    /^\[gaps\]/ {
      print
      found = 1
      next
    }
    found && lines_skipped < 6 {
      lines_skipped++
      next
    }
    found && lines_skipped == 6 {
      print replacement
      found = 0
    }
    {
      if (!found || lines_skipped == 6)
        print
    }
  ' "$config_file" >"$config_file.tmp" && mv "$config_file.tmp" "$config_file"

  echo "Applied gap config index: $input"
}
