#!/bin/sh

# Function: yaz
# Description: yazi wrapper
# Usage: yaz [arguments]
# Alias: y

function yaz() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"   echo "Function yaz called"
}

# Create alias
alias y="yaz"
