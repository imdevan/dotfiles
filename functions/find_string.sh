#!/bin/sh

# Function: find_string
# Description: Grep in directory
# Usage: find_string [arguments]
# Alias: fs

function find_string() {
    # Function implementation goes here
   grep -r "search_string" .
 
}

# Create alias
alias fs="find_string"
