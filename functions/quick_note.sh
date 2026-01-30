#!/bin/sh


# Function: quick_note
# Description: A quick note in the right folder
# Usage: quick_note [arguments]
# Alias: qn
#
# TODO: consider replacing with https://jrnl.sh/en/stable/overview/

notes_folder="$HOME/Documents/obsidian_notes/quick_notes"

# # How it started
# function quick_note() {
#   if [ "$#" -lt 1 ]; then
#     nvim "$notes_folder"/$(date +%m-%d-%Y).md
#   else  
#     nvim "$notes_folder"/$(to_snake_case "$@").md
#   fi
# }

# How it's going
function quick_note() {
  local quick_note_to_open=""

  if [ "$#" -lt 1 ]; then
    quick_note_to_open="$notes_folder"/$(date +%m-%d-%Y).md
  else  
    quick_note_to_open="$notes_folder"/$(to_snake_case "$@").md
  fi

  # Check if text is being piped in (stdin is not a terminal)
  if [ ! -t 0 ]; then
    # Text is being piped: append it to the file
    if [ -f "$quick_note_to_open" ]; then
      # File exists: add a blank line separator, then append piped text
      echo "" >> "$quick_note_to_open"
    fi
    cat >> "$quick_note_to_open"
  else
    # No piped text: open in nvim as usual
    if [ -f "$quick_note_to_open" ]; then
      # File exists: go to last line and open in insert mode
      nvim +'normal G2o' +'startinsert' "$quick_note_to_open"
    else
      # File doesn't exist: open in insert mode at the beginning
      nvim +'startinsert' "$quick_note_to_open"
    fi
  fi
}

# Create alias
alias qn="quick_note"


# Function: quick_notes_list function to print a list of files
# Description: shows notes in notes folder
# Usage: quick_notes_list

function quick_notes_list() {
  local named=()
  local dated=()

  for file in "$notes_folder"/*; do
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

  echo ""
  echo "Named:"
  echo "--------------------------------"
  if [ ${#named[@]} -eq 0 ]; then
    echo "  (no named notes)"
  else
    for note in "${named[@]}"; do
      echo -e "${yellow}  $note${reset}"
    done
  fi
  echo "--------------------------------"
  echo ""
  echo "Dated:"
  echo "--------------------------------"
  if [ ${#dated[@]} -eq 0 ]; then
    echo "  (no dated notes)"
  else
    for note in "${dated[@]}"; do
      echo -e "${green}  $note${reset}"
    done
  fi
  echo "--------------------------------"
}
alias qnl="quick_notes_list"

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
