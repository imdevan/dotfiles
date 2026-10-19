#!/bin/sh
# Function: sh_utils
# Description: Shell utils
# Usage: sh_utils [arguments]
# Alias: su

function startup_speed_test() {
  local threshold=0.100  # 100 ms as seconds

  for i in {1..5}; do
local start end diff

start=$EPOCHREALTIME
zsh -i -c exit > /dev/null 2>&1
end=$EPOCHREALTIME

diff=$(printf "%.3f" "$(echo "$end - $start" | bc)")

# Convert to ms for display
local ms=$(printf "%.0f" "$(echo "$diff * 1000" | bc)")

if (( $(echo "$diff <= $threshold" | bc) )); then
  printf "%b%ims%b startup time\n" "$green" "$ms" "$reset"
else
  printf "%b%ims%b startup time\n" "$red" "$ms" "$reset"
fi
  done


  echo "\nSourced files:\n"
  grep -E "^\s*(source|\.|autoload)" ~/.zshrc  ~/dotfiles/index.sh ~/dotfiles/functions/index.sh /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh | wc -l
}


# Create alias
alias sst="startup_speed_test"


# Summarize zsh profile
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

alias zps="zsh_profile_sum"
