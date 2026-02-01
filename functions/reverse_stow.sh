#!/bin/sh

# Function: reverse_stow
# Description: Put current directory in dotfiles/stow directory with name
# Usage: reverse_stow [stow_name]
# Alias: rs

function reverse_stow() {
    # Set default STOW_DIR if not already set
    local STOW_DIR="${STOW_DIR:-$HOME/dotfiles/config/stow}"
    local current_dir="$(pwd)"
    local stow_name="$1"
    
    # Ensure STOW_DIR exists
    if [ ! -d "$STOW_DIR" ]; then
        echo "Creating stow directory: $STOW_DIR"
        mkdir -p "$STOW_DIR"
    fi
    
    # If no name provided, calculate default from current directory
    if [ -z "$stow_name" ]; then
        local suggested_name=""
        
        # Simple approach: use basename and clean it up
        # If we're in a .config subdirectory, try to get the parent
        local dir_name=$(basename "$current_dir")
        local parent_dir=$(basename "$(dirname "$current_dir")")
        
        # If current dir is config-related, try parent
        if [ "$dir_name" = "config" ] || [ "$dir_name" = ".config" ]; then
            suggested_name=$(echo "$parent_dir" | sed 's/^[._-]*//; s/[._-]*$//')
        else
            suggested_name=$(echo "$dir_name" | sed 's/^[._-]*//; s/[._-]*$//')
        fi
        
        # Fallback if still empty
        if [ -z "$suggested_name" ] || [ "$suggested_name" = "." ]; then
            suggested_name="dotfiles"
        fi
        
        # Prompt user for name with default
        echo -n "Enter stow directory name [$suggested_name]: "
        read stow_name
        
        # Use suggested name if user didn't provide one
        if [ -z "$stow_name" ]; then
            stow_name="$suggested_name"
        fi
    fi
    
    # Validate stow_name
    if [ -z "$stow_name" ]; then
        echo "Error: No stow directory name provided"
        return 1
    fi
    
    # Calculate relative path from HOME to current directory; fall back to root
    local relative_path=""
    if [[ "$current_dir" == "$HOME"* ]]; then
        relative_path="${current_dir#$HOME/}"
        # Handle case where we're exactly in HOME
        if [ -z "$relative_path" ]; then
            relative_path="."
        fi
    else
        relative_path="${current_dir#/}"
        # Handle case where we're exactly in /
        if [ -z "$relative_path" ]; then
            relative_path="."
        fi
    fi
    
    # Create target directory path
    local target_dir="$STOW_DIR/$stow_name/$relative_path"
    
    # Check if target already exists
    if [ -d "$target_dir" ]; then
        echo "Target directory already exists: $target_dir"
        echo -n "Override existing content? [y/N]: "
        read override
        
        if [[ ! "$override" =~ ^[Yy]$ ]]; then
            echo "Operation cancelled"
            return 0
        fi
        
        # Remove existing content
        echo "Removing existing content..."
        rm -rf "$target_dir"
    fi
    
    # Create parent directories
    mkdir -p "$(dirname "$target_dir")"
    
    # Copy current directory contents to target
    echo "Copying $current_dir to $target_dir"
    
    # Handle the case where we're copying to a nested path
    if [ "$relative_path" = "." ]; then
        # We're in HOME, copy contents not the directory itself
        cp -r "$current_dir"/* "$STOW_DIR/$stow_name/" 2>/dev/null || true
        cp -r "$current_dir"/.[!.]* "$STOW_DIR/$stow_name/" 2>/dev/null || true
    else
        # Copy the directory structure
        cp -r "$current_dir" "$(dirname "$target_dir")/"
    fi
    
    if [ $? -eq 0 ]; then
        echo "Successfully copied to stow directory: $target_dir"
        echo "You can now use: stow -d $STOW_DIR $stow_name"
    else
        echo "Error: Failed to copy directory"
        return 1
    fi
}

# Create alias
alias rs="reverse_stow"
