#!/bin/sh

# Function: omni_copy
# Description: Cross-platform copy to clipboard (pbcopy on macOS, wl-copy elsewhere)
# Usage: omni_copy [text]
# Alias: oc

function omni_copy() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    pbcopy
  else
    wl-copy
  fi
}

alias oc="omni_copy"


function omni_paste() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    pbpaste
  else
    wl-paste
  fi
}

alias op="omni_paste"
# Function: to_copy
# Description: Copy output
# Usage: copy [arguments]
# Alias: c

function to_copy() {
  "$@" | omni_copy
}

# Create alias
alias tc="to_copy"


function copy_text() {
  echo "$@" | omni_copy
}

alias ct="copy_text"

function copy_pwd() {
  pwd | sed "s|^$HOME|~|" | omni_copy
}

# Create alias
alias cpw="copy_pwd"


function copy_directory() {
  basename "$(pwd)" | omni_copy
}

# Create alias
alias cpd="copy_directory"
