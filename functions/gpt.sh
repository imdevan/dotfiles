#!/bin/sh

# Function: gpt
# Description: Search chatgpt with prompt. 
# Usage: search_gpt [arguments]
# Alias: gpt

function search_gpt() {
    one_arg_required "$@" || return 1

    local url="https://chat.openai.com/?q="
    local prompt=$1

    # If more then one argument, join them with a space
    if [ $# -gt 1 ]; then
        prompt=$(echo "$@" | sed 's/ /+/g')
    fi

    # Escape spaces in prompt
    prompt=$(echo "$prompt" | sed 's/ /+/g')

    # Open the URL in the default browser
    open "$url$prompt"

    # Function implementation goes here
    # echo "Function gpt called"
    echo "$url$prompt"
}

# Create alias
alias gpt="search_gpt" # Search GPT
