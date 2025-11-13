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
    if [ -n "$3" ]; then
      local ALIAS="alias ${1}=\"${2}\" # ${3}"
      echo $ALIAS >>$aliases_file
      echo "${green}Alias: ${pink}${1}${green}=${gold}\"${2}\"${green} ${light_green}# ${3}${green} created!${reset}\n"
    else
      local ALIAS="alias ${1}=\"${2}\""
      echo $ALIAS >>$aliases_file
      echo "${green}Alias: ${pink}${1}${green}=${purple}\"${2}\"${green} created!\n"
    fi
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
    echo "alias ${1}=\"cd ${current_dir}\"" >>$aliases_file
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
  one_arg_required "$@" || return 1

  local to_find="$@"

  local files=$(find ~/dotfiles \
    -type f \
    -not -path "*/docs/*" \
    -not -path "*/index.sh" \
    -not -path "*/functions/index.sh" \
    -not -path "*/functions/new_function.sh" \
    -not -path "*/functions/alias_utils.sh" \
    -not -path "*/.git/*" \
    -not -path "*/.history/*" \
    -exec grep -l "^[^#]*alias.*${to_find}" {} \;)

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
      done < <(grep "^[^#]*alias.*${to_find}" "$file")
    done <<<"$files"

    # Second pass: print with aligned equals signs
    while IFS= read -r file; do
      echo "${green}$(basename "$file")${reset}"
      grep "^[^#]*alias.*${1}" "$file" | while IFS= read -r line; do
        local alias_name=$(echo "$line" | sed -E 's/alias ([^=]+)=.*/\1/')
        local alias_value=$(echo "$line" | sed -E 's/alias [^=]+=(.*)/\1/')
        alias_value=$(echo "$alias_value" | sed 's/#.*$//')
        local alias_comment=$(echo "$line" | sed -E 's/.*#(.*)/\1/' | sed 's/^[[:space:]]*//')
        printf "${orange}%-${max_length}s${reset} = ${purple}%s${reset} ${yellow}%s${reset}\n" "$alias_name" "$alias_value" "# $alias_comment"
      done
      echo ""
    done <<<"$files"
  fi
}
alias isa="is_alias"

# Todo: fix this
# Does not currently remove the alias correctly from aliases.sh
# function remove_alias() {
#   if [ -z "$1" ]; then
#     echo "${red}Error:${reset} No alias name provided."
#     echo "Usage: remove_alias <alias_name>"
#     return 1
#   fi
#
#   local alias_name="$1"
#   local aliases_file=~/dotfiles/aliases.sh
#
#   if ! grep -q "^[^#]*alias[[:space:]]\+$alias_name=" "$aliases_file"; then
#     echo "${red}Alias '$alias_name' not found in $aliases_file.${reset}"
#     return 1
#   fi
#
#   # Remove the alias line (not commented out) from the file
#   sed -i '' "/^[^#]*alias[[:space:]]\+$alias_name=/d" "$aliases_file"
#
#   echo "${green}Alias '$alias_name' removed from $aliases_file.${reset}"
# }
# alias rma="remove_alias"
#
# function remove_duplicate_aliases() {
#   if [ ! -f "$aliases_file" ]; then
#     echo "Aliases file not found at $aliases_file"
#     return 1
#   fi
#
#   local temp_file=$(mktemp)
#
#   # Reverse the file, use awk to find unique aliases (based on the second field), and reverse back
#   tac "$aliases_file" | awk -F'[ =]' '!seen[$2]++' | tac >"$temp_file"
#
#   # Replace the original file with the de-duplicated version
#   mv "$temp_file" "$aliases_file"
#
#   echo "Duplicate aliases removed from $aliases_file"
# }
# alias rda="remove_duplicate_aliases"
#
#
# TODO: unfinished
# # Function: edit alias
# Description: edit an alias in alias.sh file
# Usage: edit alias [arguments]
# Alias: ea
#
# function edit_alias() {
#     if [ -z "$1" ]; then
#         echo "Usage: edit_alias <alias_name>"
#         return 1
#     fi
#
#     local alias_name="$1"
#     local alias_file="$dot_files/alias.sh"
#
#     if [ ! -f "$alias_file" ]; then
#         echo "Alias file not found at $alias_file"
#         return 1
#     fi
#
#     local existing_alias=$(grep -E "^alias ${alias_name}=" "$alias_file")
#
#     if [ -z "$existing_alias" ]; then
#         echo "Alias '$alias_name' not found."
#         return 1
#     fi
#
#     echo "Found alias: $existing_alias"
#     echo "Enter the new command for the alias '$alias_name':"
#     read new_command
#
#     if [ -z "$new_command" ]; then
#         echo "No new command entered. Aborting."
#         return 1
#     fi
#
#     local new_alias="alias ${alias_name}='${new_command}'"
#
#     read -p "Are you sure you want to change the alias to '$new_alias'? (y/n) " -n 1 -r
#     echo
#     if [[ $REPLY =~ ^[Yy]$ ]]; then
#         sed -i '' "s|^alias ${alias_name}=.*|${new_alias}|" "$alias_file"
#         echo "Alias '$alias_name' has been changed."
#         source "$alias_file"
#     else
#         echo "Alias change cancelled."
#     fi
# }
#
# # Create alias
# alias ea="edit_alias"
#
