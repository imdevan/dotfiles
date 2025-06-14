# Generate random number print, Yes if 2, No if 1
function yes-or-no() {
  local ANSWER=$((1 + RANDOM % 2))
  
  if [ "$ANSWER" -eq "1" ]; then
    echo "${green}Yes!${reset}"
  else
    echo "${red}Nope!${reset}"
  fi
}
alias yon="yes-or-no"

# Same as above but flip a coin instead
function flip-coin() {
  local ANSWER=$((1 + RANDOM % 2))
  
  if [ "$ANSWER" -eq "1" ]; then
    echo "${green}Heads!${reset}"
  else
    echo "${red}Tails!${reset}"
  fi
}
alias flip="flip-coin"

# Calls yes-or-no if no props provided 
# Calls
function random() {
  local MIN=1
  local MAX=10

  if [ ! -z "$1" ]; then
    MAX=$1
  fi
  
  if [ ! -z "$2" ]; then
    MIN=$2
  fi
  
  echo $(($MIN + RANDOM % $MAX))
}
alias rand="random"
