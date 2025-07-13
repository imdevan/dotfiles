#!/bin/sh

# Function: quick_note
# Description: A quick note in the right folder
# Usage: quick_note [arguments]
# Alias: qn

function quick_note() {
    # Function implementation goes here
    # Possible improvements:
    # - pass an argument to specify the name of the note
    # - pass an argument as a string containing the note
    # local note_file="~/Documents/notes/$(date +%Y-%m-%d).md"
   
  if [ "$#" -lt 1 ]; then
    nvim ~/Documents/notes/$(date +%d-%m-%Y).md
  else  
    nvim ~/documents/notes/$(to_snake_case "$@").md
  fi
}

# Create alias
alias qn="quick_note"


# Function: notesbash function to print a list of files
# Description: shows notes in notes folder
# Usage: notes

function notes() {
  local folder=~/Documents/notes/

  local named=()
  local dated=()

  for file in "$folder"*; do
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
