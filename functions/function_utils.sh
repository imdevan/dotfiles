#!/bin/sh

# Function: vim_function
# Description: Open given function in vim. Will open the functions folder if no arg is provided
# Usage: function_utils [arguments]
# Alias: fu

function vim_function() {
  local functions_path="$dotfile_dir/functions"

  if [ -z "$1" ]; then
    nvim "$functions_path/"
  else
    local function_name=$(to_snake_case "$@")

    if [[ "${function_name: -3}" == ".sh" ]]; then
      nvim "$functions_path/$function_name"
    else 
      nvim "$functions_path"/*"$function_name"*

      # other attempts. consider these if the above in sufficient
      # find . -iname "*partial_filename*" -print0 | xargs -0 nvim
      # nvim '$(find "$functions_path" -type f -name "*$function_name"" | head -n 1)'
    fi
  fi
}

# Create alias
alias vf="vim_function"
