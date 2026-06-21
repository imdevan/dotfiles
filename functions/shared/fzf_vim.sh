!/bin/bash

# fzf file search function
# Usage:
#   fzf_vim           - Interactive mode: select file and open in nvim
#   fzf_vim <query>   - Search mode: return first match for query
fzf_vim() {
  if [ $# -eq 0 ]; then
    # No arguments - interactive mode, open selected file in nvim
    fzf --bind 'enter:become(nvim {})'
  else
    # With argument - search and return first match
    local file
    file="$(fzf --filter="$1" | head -n 1)"
    # If no response
    if [[ -z "$file" ]]; then
      echo "${red}file not found${reset}"
      # Else open in nvim
    else
      nvim "$file"
    fi
  fi
}
alias fv="fzf_vim"

with_vim() {
  if [ $# -eq 0 ]; then
    # No arguments - open folder in vim
    nvim
  else
    # Check if argument contains :line_number syntax
    local query="$1"
    local line_number=""

    # Use parameter expansion instead of regex for more reliable extraction
    if [[ "$query" == *:* ]]; then
      # Extract line number (everything after last colon if it's a number)
      local potential_line="${query##*:}"
      if [[ "$potential_line" =~ ^[0-9]+$ ]]; then
        line_number="$potential_line"
        # Remove :line_number from query
        query="${query%:*}"
        # echo "DEBUG: Extracted file: $query, line: $line_number" >&2
      fi
    fi

    # If the query is an existing file, open it directly
    if [[ -f "$query" ]]; then
      if [[ -n "$line_number" ]]; then
        # echo "DEBUG: Opening existing file at line $line_number: nvim +${line_number} $query" >&2
        nvim "+${line_number}" "$query"
      else
        nvim "$query"
      fi
      return
    fi

    # Otherwise, search with fzf using just the basename for better matching
    local search_term
    search_term="$(basename "$query")"

    local file
    file="$(fzf --filter="$search_term" | head -n 1)"
    # If no response
    if [[ -z "$file" ]]; then
      # If original had line number, try opening with it
      if [[ -n "$line_number" ]]; then
        nvim "+${line_number}" "$query"
      else
        # Not found, in god's hands
        nvim "$@"
      fi
    # Else open in nvim
    else
      # If line number was specified, open at that line
      if [[ -n "$line_number" ]]; then
        # echo "DEBUG: Opening found file at line $line_number: nvim +${line_number} $file" >&2
        nvim "+${line_number}" "$file"
      else
        nvim "$file"
      fi
    fi
  fi
}

alias v="with_vim"
alias n=nvim
