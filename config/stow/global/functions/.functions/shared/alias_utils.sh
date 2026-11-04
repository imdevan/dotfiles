# Functions for managing aliases

# Todo:
# - Add a function to remove aliases
# - Add a function to edit aliases
# - integrate with als
#  https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
#

# Default editor
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.oh-my-zsh && clear"
alias r="refresh"

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

  # Also search in ~/.bookmarks/bookmarks.sh if it exists
  if [ -f ~/.bookmarks/bookmarks.sh ]; then
    if grep -q "^[^#]*alias.*${to_find}" ~/.bookmarks/bookmarks.sh 2>/dev/null; then
      if [ -n "$files" ]; then
        files="${files}"$'\n'"$HOME/.bookmarks/bookmarks.sh"
      else
        files="$HOME/.bookmarks/bookmarks.sh"
      fi
    fi
  fi

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
        if [ -n "$alias_comment" ] && [[ "$line" =~ \# ]]; then
          printf "${orange}%-${max_length}s${reset} = ${purple}%s${reset} ${yellow}%s${reset}\n" "$alias_name" "$alias_value" "# $alias_comment"
        else
          printf "${orange}%-${max_length}s${reset} = ${purple}%s${reset}\n" "$alias_name" "$alias_value"
        fi
      done
      echo ""
    done <<<"$files"
  fi
}
alias isa="is_alias"


