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
function flip_coin() {
  generate_random 0 1
  local answer=$?

  if [ $answer -eq "1" ]; then
    echo "${green}Heads!${reset}"
  else
    echo "${red}Tails!${reset}"
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
