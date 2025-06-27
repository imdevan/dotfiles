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
    
    nvim ~/Documents/notes/$(date +%Y-%m-%d).txt
}

# Create alias
alias qn="quick_note"
