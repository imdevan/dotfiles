#!/bin/sh

# Function: to_log
# Description: Log the output of a command or content to a log file
# Usage: to_log [command] [arguments] OR echo "content" | to_log
# Alias: tl

function to_log() {
  # Create logs directory if it doesn't exist
  local log_dir="$HOME/.logs"
  mkdir -p "$log_dir"
  
  # Generate filename with date and time
  local timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  local log_file="$log_dir/log-${timestamp}.log"
  
  # If arguments provided, execute command and log output
  # Otherwise, read from stdin
  if [ $# -gt 0 ]; then
    # Execute command, write output to file, and also print to terminal
    "$@" 2>&1 | tee "$log_file"
  else
    # Read from stdin, write to file, and also print to terminal
    tee "$log_file"
  fi
  
  echo "${green}log file created: $log_file${reset}"
  
  # Open in nvim
  nvim "$log_file"
}

# Create alias
alias tl="to_log"

# Same as to_log includes prompt
function to_log_with_prompt() {
  # Create logs directory if it doesn't exist
  local log_dir="$HOME/.logs"
  mkdir -p "$log_dir"
  
  # Generate filename with date and time
  local timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  local log_file="$log_dir/log-${timestamp}.log"
  
  # Build the prompt string
  local prompt=""
  
  # If arguments provided, execute command and log output
  # Otherwise, read from stdin
  if [ $# -gt 0 ]; then
    # Build prompt from command and arguments
    prompt="$ $*"
    # Execute command, capture output
    local output=$("$@" 2>&1)
    # Write prompt and output to file
    {
      echo "$prompt"
      echo ""
      echo "$output"
    } > "$log_file"
    # Print output to terminal
    echo "$output"
  else
    # Read from stdin
    prompt="$ (stdin input)"
    local input=$(cat)
    # Write prompt and input to file
    {
      echo "$prompt"
      echo ""
      echo "$input"
    } > "$log_file"
    # Print input to terminal
    echo "$input"
  fi
  
  echo "${green}log file created: $log_file${reset}"
  
  # Open in nvim
  nvim "$log_file"
}

# Create alias
alias tlp="to_log_with_prompt"

