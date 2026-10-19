# Random functions

# Generate a random number between 0 and 32767 (RANDOM's max value)
function generate_random() {
  local min=${1:-0}
  local max=${2:-100}
  local result=$((RANDOM % (max - min + 1) + min))
  return $result
}

# Generate random number print, Yes if 2, No if 1
function yes_or_no() {
  generate_random 0 1
  local answer=$?

  if [ $answer -eq "1" ]; then
    echo "${green}Yes!${reset}"
  else
    echo "${red}Nope!${reset}"
  fi
}
alias yon="yes_or_no"

# Same as above but flip a coin instead
# If a number is passed, flip the coin that many times with delay and summary
function flip_coin() {
  local flips=${1:-1}
  local heads_count=0
  local tails_count=0

  if [ "$flips" -eq 1 ]; then
    # Single flip - original behavior
    generate_random 0 1
    local answer=$?

    if [ $answer -eq "1" ]; then
      echo "${green}Heads!${reset}"
    else
      echo "${red}Tails!${reset}"
    fi
  else
    # Multiple flips with delay and summary
    echo "Flipping coin ${blue}$flips${reset} times..."
    echo ""

    for ((i = 1; i <= flips; i++)); do
      generate_random 0 1
      local answer=$?

      if [ $answer -eq "1" ]; then
        echo "Flip $i: ${green}Heads${reset}"
        ((heads_count++))
      else
        echo "Flip $i: ${red}Tails${reset}"
        ((tails_count++))
      fi

      # Small delay between flips (except for the last one)
      if [ $i -lt $flips ]; then
        sleep 1
      fi
    done

    echo ""
    echo "=== Summary ==="
    echo "${green}Heads: $heads_count${reset}"
    echo "${red}Tails: $tails_count${reset}"

    if [ $heads_count -gt $tails_count ]; then
      echo "Winner: ${green}Heads!${reset}"
    elif [ $tails_count -gt $heads_count ]; then
      echo "Winner: ${red}Tails!${reset}"
    else
      echo "Result: ${blue}It's a tie!${reset}"
    fi
  fi
}
alias flip="flip_coin"

# Random number between 1 and 10 or provided range
function random() {
  if [ "$#" -eq "1" ]; then
    echo "Number between ${green}1${reset} and ${green}$1${blue}"
    generate_random 1 "$1"
  else
    echo "Number between ${green}$1${reset} and ${green}$2${blue}"
    generate_random "$@"
  fi
  echo $?
}
alias rand="random"
