#!/bin/sh bash

# Function: multi-agent-search
# Description: Open multiple agens in browser via query param
# Usage: multi-agent-search [arguments]
# Alias: m

function multi_agent_search() {
    # Function implementation goes here
    one_arg_required "$@" || return 1

    local gpt_url="https://chat.openai.com/?q="
    local claude_url="https://claude.ai/new?q="
    local perplexity_url="https://www.perplexity.ai/search?q="
    local gemini_url="https://gemini.google.com/app?q="

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
      "$gemini_url$prompt"
      "$gpt_url$prompt"
      "$claude_url$prompt"
      "$perplexity_url$prompt"
      )

    # Open the URL in the default browser
    open -na "Google Chrome" --args --new-window "${urls[@]}"

    # 2. Use AppleScript to wait for load and paste the prompt (for gemini)
    osascript -e 'delay 3' -e 'tell application "Google Chrome" to activate' -e "tell application \"System Events\" to keystroke \"$prompt\"" -e 'tell application "System Events" to keystroke return' -e 'delay 1' -e 'tell application "System Events" to keystroke tab' -e 'delay 1' -e 'tell application "System Events" to keystroke return'
}

alias search_ai="multi_agent_search"

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

alias cc="claude_chatgpt"
