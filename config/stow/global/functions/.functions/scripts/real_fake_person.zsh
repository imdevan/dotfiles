#!/usr/bin/env zsh

# Script: real_fake_person
# Description: Generate a fake person, append it to ~/Documents/rfp/real_fake_people.md and open it
# Usage: real_fake_person
# Alias: rfp

RFP_FILE=~/Documents/rfp/real_fake_people.md

function real_fake_person() {
    first=$(faker-cli -n firstName | tr -d '"')
    last=$(faker-cli -n lastName | tr -d '"')
    month=$(faker-cli -d month | tr -d '"')
    day=$((RANDOM % 28 + 1))
    year=$((RANDOM % (2003 - 1965 + 1) + 1965))
    password=$(faker-cli -i password | tr -d '"')

    echo "$first"
    echo "$last"
    echo "$month"
    echo "$day"
    echo "$year"
    echo "$password"

    mkdir -p ~/Documents/rfp
    {
        echo ""
        echo "$first $last"
        echo "$month $day, $year"
        echo "$password"
    } >> "$RFP_FILE"

  nvim +$ "$RFP_FILE"
}

real_fake_person "$@"
