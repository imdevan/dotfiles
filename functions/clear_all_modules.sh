#!/bin/sh

# Function: clear_all_modules
# Description: Clear all specified folders (defaults to common build/module directories)
# Usage: clear_all_modules [folder_name1] [folder_name2] ...
# Examples:
#   clear_all_modules                    # Prompts to delete common directories
#   clear_all_modules dist                # Deletes all dist folders
#   clear_all_modules node_modules dist   # Deletes all node_modules and dist folders
# Alias: can!

function clear_all_modules() {
    local folders=()
    
    # If no arguments were passed, prompt for common directories
    if [ $# -eq 0 ]; then
        echo -n "Remove common build/module directories? [Y/n] "
        read use_common
        
        # Default to 'y' if user just presses Enter
        use_common=${use_common:-y}
        
        if [[ "$use_common" == [yY] ]]; then
            # Common directories for various frameworks/languages
            folders=(
                "node_modules"    # Node.js dependencies
                ".next"           # Next.js build output
                "dist"            # Common build output
                "build"           # Common build output
                "out"             # Next.js/other static exports
                ".nuxt"           # Nuxt.js build
                ".svelte-kit"     # SvelteKit build
                ".turbo"          # Turborepo cache
                "__pycache__"     # Python bytecode cache
                ".pytest_cache"   # Pytest cache
                "venv"            # Python virtual environment
                ".venv"           # Python virtual environment
                "vendor"          # Ruby/PHP dependencies
                ".bundle"         # Ruby bundler
                "target"          # Rust/Java build output
            )
        else
            echo "${red}Operation cancelled.${reset}"
            return
        fi
    else
        # Use provided arguments
        folders=("$@")
    fi
    
    echo "Searching for folders: ${folders[*]}"
    
    # Find and display all matching folders
    for folder in "${folders[@]}"; do
        find . -type d -name "$folder" -prune -print
    done
    
    echo -n "Delete all of the above directories? [Y/n] "
    read confirm

    # Default to 'y' if user just presses Enter
    confirm=${confirm:-y}

    if [[ "$confirm" == [yY] ]]; then
        echo "Deleting..."
        for folder in "${folders[@]}"; do
            find . -type d -name "$folder" -prune -exec rm -rf '{}' +
        done
        echo "${green}All specified folders deleted.${reset}"
    else
        echo "${red}Operation cancelled.${reset}"
    fi
}

# Create alias
alias 'can!'="clear_all_modules" # ! to prevent accidental trigger
