#!/bin/sh

# Function: which_lock
# Description: Which lock file in directory
# Usage: which_lock [arguments]
# Alias: wl

function which_lock() {
    # Check current directory for lock files and return package manager
    if [ -f "bun.lockb" ]; then
        echo "bun"
    elif [ -f "package-lock.json" ]; then
        echo "npm"
    elif [ -f "yarn.lock" ]; then
        echo "yarn"
    elif [ -f "pnpm-lock.yaml" ]; then
        echo "pnpm"
    elif [ -f "Cargo.lock" ]; then
        echo "cargo"
    elif [ -f "poetry.lock" ]; then
        echo "poetry"
    elif [ -f "Pipfile.lock" ]; then
        echo "pipenv"
    elif [ -f "Gemfile.lock" ]; then
        echo "bundler"
    elif [ -f "composer.lock" ]; then
        echo "composer"
    elif [ -f "go.sum" ]; then
        echo "go"
    elif [ -f "requirements.txt.lock" ]; then
        echo "pip-tools"
    else
        echo "none"
    fi
}

# Create alias
alias wl="which_lock"
