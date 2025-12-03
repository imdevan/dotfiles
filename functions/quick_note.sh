#!/bin/sh

# Function: quick_note
# Description: A quick note in the right folder
# Usage: quick_note [arguments]
# Alias: qn

notes_folder="$HOME/Documents/notes/"

function quick_note() {
    # Function implementation goes here
    # Possible improvements:
    # - pass an argument as a string containing the note
    # local note_file="~/Documents/notes/$(date +%Y-%m-%d).md"
   
  if [ "$#" -lt 1 ]; then
    nvim "$notes_folder"/$(date +%m-%d-%Y).md
  else  
    nvim "$notes_folder"/$(to_snake_case "$@").md
  fi
}

# Create alias
alias qn="quick_note"


# Function: notes function to print a list of files
# Description: shows notes in notes folder
# Usage: notes

function notes() {
  local named=()
  local dated=()

  for file in "$notes_folder"*; do
    [ -f "$file" ] || continue
    local basename=$(basename "$file")

    if [[ "$basename" =~ ^([0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[0-9]{4})\.(txt|md)$ ]]; then
      dated+=("${basename%.*}")
    else
      # Remove extension, replace underscores with spaces, and title case
      local clean_name="${basename%.*}"
      clean_name="${clean_name//_/ }"
      clean_name="$(echo "$clean_name" | awk '{for(i=1;i<=NF;++i) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}')"
      named+=("$clean_name")
    fi
  done

  named_notes=$(printf "%s\n" "${named[@]}")
  dated_notes=$(printf "%s\n" "${dated[@]}")

  echo ""
  echo "Named:"
  echo "--------------------------------"
  echo -e "${yellow}${named_notes}${reset}"
  echo "--------------------------------"
  echo ""
  echo "Dated:"
  echo "--------------------------------"
  echo -e "${green}${dated_notes}${reset}"
  echo "--------------------------------"
}

alias vqn="v ~/Documents/notes"

# Function: notes_grep
# Description: Opens notes folder in nvim with grep search
# Usage: notes_grep [search query]

function notes_grep() {
  local search_query="$*"
  # Escape single quotes in search query for lua
  local escaped_query=$(echo "$search_query" | sed "s/'/''/g")
  if [ -n "$search_query" ]; then
    nvim "$notes_folder" -c "lua vim.defer_fn(function() require('snacks').picker.grep({ cwd = '$notes_folder' }); vim.defer_fn(function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('$escaped_query', true, false, true), 't', false) end, 200) end, 100)"
  else
    nvim "$notes_folder" -c "lua vim.defer_fn(function() require('snacks').picker.grep({ cwd = '$notes_folder' }) end, 100)"
  fi
}

# Create alias
alias qng="notes_grep"
