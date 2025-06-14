# Default editor
editor="code"
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.oh-my-zsh && clear"
alias r="refresh"

# Function to create new aliases
function new-alias() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "${red}Invalid alias provided${reset}"
  else
    local ALIAS="alias ${1}=\"${2}\""
    echo $ALIAS >> $aliases_file
    echo "${green}Alias: ${pink}${1}${green}=${purple}\"${2}\"${green} created!\n"
    source $aliases_file
  fi
}
alias na="new-alias"

# Bookmark position
function bookmark() {
  if [ -z "$1" ]; then
    echo 'No name provided'
  else
    local current_dir=$(pwd | sed 's/ /\\ /g')
    echo "alias ${1}=\"cd ${current_dir}\"" >> $aliases_file
    source $aliases_file
    echo "${green}Alias: ${pink}${1}${green}=${purple}\"${current_dir}\"${green} created!\n"
  fi
}
alias b="bookmark"

# Warning position
function warning() {
  if [ -z "$1" ]; then
    echo 'No name provided'
  else
    echo "${green}Warning: ${purple}${1}${green} created!"
    echo "echo ${1}" >> $aliases_file
  fi
}
alias w="warning"

# Prints aliases if it exists
function print-alias() {
  local ALIAS=$(grep "${1}" ~/dotfiles/aliases.sh)
  
  if [ -z "$ALIAS" ]; then
    echo "${red}No alias found "
  else
    echo ""
    echo "${green}Aliases Found:${reset}"
    echo ""
    echo "${ALIAS}"
  fi
}
alias isa="print-alias"

