#!/bin/sh

# Function: webify
# Description: given folder, create copy of folder with all images of folder converted to webp use convert tool e.g. convert abcs.png abcs.webp
# Usage: webify [arguments]
# Alias: w

function webify() {
    if [ -z "$1" ]; then
        echo "Usage: webify <folder>"
        return 1
    fi

    local src="${1%/}"

    if [ ! -d "$src" ]; then
        echo "webify: '$src' is not a directory"
        return 1
    fi

    if ! command -v convert >/dev/null 2>&1; then
        echo "webify: 'convert' command not found (install imagemagick)"
        return 1
    fi

    local dest="${src}-webp"

    cp -r "$src" "$dest"

    find "$dest" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | while read -r img; do
        convert "$img" "${img%.*}.webp"
        rm "$img"
    done

    echo "Converted images copied to $dest"
}

# Create alias
alias w="webify"
