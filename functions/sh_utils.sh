#!/bin/sh

# Function: sh_utils
# Description: Shell utils
# Usage: sh_utils [arguments]
# Alias: su

function sh_utils() {

}

# Create alias
alias su="sh_utils"

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


## number of files loaded
# grep -E "^\s*(source|\.|autoload)" ~/.zshrc
# grep -E "^\s*(source|\.|autoload)" ~/.zshrc  ~/dotfiles/index.sh ~/dotfiles/functions/index.sh /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh | wc -l
#
startup_benchmark() {
  local profile_file="${1:-$HOME/.zsh_profile}"
  
  # Check if profile file exists
  if [[ ! -f "$profile_file" ]]; then
    echo "Error: Profile file not found at $profile_file"
    echo "Run 'zsh -i -c exit' with profiling enabled first"
    return 1
  fi
  
  # Extract the first table between separator lines
  # Format: num) calls total_time time_per_call percent self self_per_call self_percent name
  # Column 3 is total time in ms, Column 5 is percent (with %)
  local total_time_ms=$(awk '
    BEGIN { in_table = 0; total = 0 }
    /^-{50,}/ {
      if (in_table == 0) {
        in_table = 1
        next
      } else {
        exit
      }
    }
    in_table && /^[[:space:]]*[0-9]+\)/ {
      if (NF >= 5) {
        # Column 3 is the total time for this function
        total += $3
      }
    }
    END { printf "%.2f", total }
  ' "$profile_file")
  
  # Convert ms to seconds for threshold comparison
  local total_time_s=$(echo "scale=3; $total_time_ms / 1000" | bc)
  
  # Determine color based on total time thresholds (in seconds)
  local color_code
  
  if (( $(echo "$total_time_s <= 0.100" | bc -l) )); then
    color_code="$green"
  elif (( $(echo "$total_time_s <= 0.200" | bc -l) )); then
    color_code="$yellow"
  else
    color_code="$red"
  fi
  
  # Display total time with color
  echo "\nZsh Startup Benchmark:"
  printf "Total time: %b%.2fms%b (%.3fs)\n\n" "$color_code" "$total_time_ms" "$reset" "$total_time_s"
  
  # Extract top 3 entries by time (column 3 = total time in ms, column 5 = percent)
  echo "Top 3 slowest components:"
  awk '
    BEGIN { in_table = 0; count = 0 }
    /^-{50,}/ {
      if (in_table == 0) {
        in_table = 1
        next
      } else {
        exit
      }
    }
    in_table && /^[[:space:]]*[0-9]+\)/ {
      if (NF >= 9) {
        count++
        time[count] = $3  # Total time
        # Remove % sign from percent (column 5)
        gsub(/%/, "", $5)
        percent[count] = $5
        name[count] = $NF  # Last column is name
      }
    }
    END {
      # Simple bubble sort to get top 3
      for (i = 1; i <= count; i++) {
        for (j = i + 1; j <= count; j++) {
          if (time[j] + 0 > time[i] + 0) {
            # Swap times
            tmp = time[i]
            time[i] = time[j]
            time[j] = tmp
            # Swap percents
            tmp = percent[i]
            percent[i] = percent[j]
            percent[j] = tmp
            # Swap names
            tmp = name[i]
            name[i] = name[j]
            name[j] = tmp
          }
        }
      }
      # Print top 3
      limit = (count < 3) ? count : 3
      for (i = 1; i <= limit; i++) {
        printf "  %d. %-50s %6.2fms (%s%%)\n", i, name[i], time[i], percent[i]
      }
    }
  ' "$profile_file"
}

alias sb="startup_benchmark"
