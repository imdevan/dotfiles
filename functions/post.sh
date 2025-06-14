#!/bin/sh

# Function: post
# Description: send post request with auth header

# Usage: post [arguments]
# Alias: p

# Function to make a POST request to a Supabase Edge Function
function post() {
    # Default function name to 'hello' if no argument provided
    local function_name=${1:-""}
    
    # Default data to empty object if no second argument provided
    local data=${2:-"{}"}e
    
    local url="http://localhost:54321/functions/v1/${function_name}"
    
    echo $url
    
    # Todo update the auth header to be more dynamic or pull from an env file
    curl --request POST $url \
        --header 'Authorization: Bearer ' $3\
        --header 'Content-Type: application/json' \
        --data "${data}"
}

# Create alias
alias p="post"
