# Generate random number print, Yes if 2, No if 1
function yes-or-no() {
  ANSWER=$((1 + RANDOM % 2))
  
  if [ "$ANSWER" -eq "1" ]; then
    echo "${green}Yes!${reset}"
  else
    echo "${red}Nope!${reset}"
  fi
}
alias yon="yes-or-no"

# Calls yes-or-no if no props provided 
# Calls
function random() {
  if [ -z "$1" ]; then
    MAX=10
  fi
  
  if [ -z "$2" ]; then
    MIN=1
  fi
  
  echo $(($MIN + RANDOM % $MAX))
}
alias rand="random"
