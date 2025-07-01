# Functions for managing aliases

# Todo:
# - Add a function to remove aliases
# - Add a function to edit aliases
# - integrate with als
#  https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
#  

# Default editor
editor="code"
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.oh-my-zsh && clear"
alias r="refresh"

# Function to create new aliases
function new_alias() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "${red}Invalid alias provided${reset}"
  else
    local ALIAS="alias ${1}=\"${2}\""
    echo $ALIAS >> $aliases_file
    echo "${green}Alias: ${pink}${1}${green}=${purple}\"${2}\"${green} created!\n"
    source $aliases_file
  fi
}
alias na="new_alias"

# Bookmark position
function bookmark() {
  if [ -z "$1" ]; then
    echo 'No name provided'
  else
    # local current_dir=$(pwd | sed 's/ /\\ /g')
    local current_dir=$(pwd | sed "s|^$HOME|~|")
    echo "alias ${1}=\"cd ${current_dir}\"" >> $aliases_file
    source $aliases_file
    echo "${green}Alias: ${pink}${1}${green}=${purple}\"${current_dir}\"${green} created!\n"
  fi
}
alias b="bookmark"

# Warning position
# function warning() {
#   if [ -z "$1" ]; then
#     echo 'No name provided'
#   else
#     echo "${green}Warning: ${purple}${1}${green} created!"
#     echo "echo ${1}" >> $aliases_file
#   fi
# }
# alias w="warning"

# Alias search
function is_alias() {
  local files=$(find ~/dotfiles \
    -type f \
    -not -path "*/docs/*" \
    -not -path "*/index.sh" \
    -not -path "*/functions/index.sh" \
    -not -path "*/functions/new_function.sh" \
    -not -path "*/functions/alias_utils.sh" \
    -not -path "*/.git/*" \
    -not -path "*/.history/*" \
    -exec grep -l "^[^#]*alias.*${1}" {} \;)
  
  if [ -z "$files" ]; then
    echo "${red}No alias found "
  else
    echo ""
    echo "${green}Aliases Found:${reset}"
    echo ""
    
    # First pass: find the longest alias name
    local max_length=0
    while IFS= read -r file; do
      while IFS= read -r line; do
        local alias_name=$(echo "$line" | sed -E 's/alias ([^=]+)=.*/\1/')
        local name_length=${#alias_name}
        if [ $name_length -gt $max_length ]; then
          max_length=$name_length
        fi
      done < <(grep "^[^#]*alias.*${1}" "$file")
    done <<< "$files"
    
    # Second pass: print with aligned equals signs
    while IFS= read -r file; do
      echo "${green}$(basename "$file")${reset}"
      grep "^[^#]*alias.*${1}" "$file" | while IFS= read -r line; do
        local alias_name=$(echo "$line" | sed -E 's/alias ([^=]+)=.*/\1/')
        local alias_value=$(echo "$line" | sed -E 's/alias [^=]+=(.*)/\1/')
        printf "${orange}%-${max_length}s${reset} = ${purple}%s${reset}\n" "$alias_name" "$alias_value"
      done
      echo ""
    done <<< "$files"
  fi
}
alias isa="is_alias"

