#!/usr/bin/env zsh

# Script: claude_chatgpt
# Description: Open claude and chatgpt in browser via query param
# Usage: claude_chatgpt <prompt...>
#
# possibly small go cli
# Alias: cc

source "$HOME/.functions/shared/colors.sh"
source "$HOME/.functions/shared/validators.sh"
source "$HOME/.functions/shared/join_args.sh"

function claude_chatgpt() {
    # Function implementation goes here
    one_arg_required "$@" || return 1

    local claude_url="https://claude.ai/new?q="
    local gpt_url="https://chat.openai.com/?q="

    local prompt

    # If more then one argument, join them with a space
    if [ $# -gt 1 ]; then
        prompt=$(join_args "$@")
    else
        prompt=$1
    fi

    # Escape spaces in prompt
    prompt=$(echo "$prompt" | sed 's/ /+/g')

    local urls=(
      "$gpt_url$prompt"
      "$claude_url$prompt"
      )

    # Open the URL in the default browser
    open -na "Google Chrome" --args --new-window "${urls[@]}"

    # Use AppleScript to hit return in one tab, then tab to next and hit return
    osascript -e 'delay 1' \
      -e 'tell application "Google Chrome" to activate' \
      -e 'tell application "System Events" to keystroke return' \
      -e 'delay 1' \
      -e 'tell application "System Events" to keystroke tab using control down' \
      -e 'delay 1' \
      -e 'tell application "System Events" to keystroke return' \
      -e 'delay 1' \
      -e 'tell application "System Events" to keystroke tab using control down'
}

claude_chatgpt "$@"
