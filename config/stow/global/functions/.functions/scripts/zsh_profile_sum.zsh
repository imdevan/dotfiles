#!/usr/bin/env zsh

# Script: zsh_profile_sum
# Description: Summarize zsh profile
# Usage: zsh_profile_sum [profile_file] [top_count]
# Defaults: profile_file=~/.zsh_profile, top_count=3

zsh_profile_sum(){
  local profile_file="${1:-$HOME/.zsh_profile}"
  local top_count="${2:-3}"
  
  # Check if profile file exists
  if [[ ! -f "$profile_file" ]]; then
    echo "Profile file not found: $profile_file"
    return 1
  fi
  
  # Extract only the summary section (from line 3 until first empty line)
  local data=$(sed -n '3,/^$/p' "$profile_file" | head -n -1)
  
  # Calculate total startup time (sum of self time - column 6)
  local total_time=$(echo "$data" | awk '{sum += $6} END {printf "%.2f", sum}')
  
  echo "Total startup time: ${total_time}ms"
  echo -e "\nTop $top_count offenders:"
  echo "----------------------------------------"
  
  # Show top offenders (already sorted in the profile)
  # Format: rank) total_time(ms) (total_percentage%) function_name
  echo "$data" | head -n "$top_count" | awk '{
    printf "%2d) %6.2fms (%5.1f%%) %s\n", NR, $3, $5, $NF
  }'
}

zsh_profile_sum "$@"
