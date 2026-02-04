#!/bin/bash

# Download wallpapers from wallhaven.cc
# Usage: download-wallhaven.sh <wallhaven_url> [path]
# Example: download-wallhaven.sh https://wallhaven.cc/w/nk2ypm nature/

set -e

# Default wallpaper location
wallpaper_location="$HOME/Wallpapers"

# Function to show usage
show_usage() {
  echo "Usage: $0 <wallhaven_url> [path]"
  echo "Example: $0 https://wallhaven.cc/w/nk2ypm"
  echo "Example: $0 https://wallhaven.cc/w/nk2ypm nature/"
  echo ""
  echo "Downloads wallpaper from wallhaven.cc to ~/Wallpaper or ~/Wallpaper/[path]"
  exit 1
}

# Check if URL is provided
if [ $# -eq 0 ]; then
  show_usage
fi

wallhaven_url="$1"
path_suffix="${2:-}"

# Validate URL format
if [[ ! "$wallhaven_url" =~ ^https://wallhaven\.cc/w/[a-zA-Z0-9]+$ ]]; then
  echo "Error: Invalid wallhaven URL format"
  echo "Expected format: https://wallhaven.cc/w/[id]"
  exit 1
fi

# Extract the wallpaper ID from the URL
wallpaper_id=$(echo "$wallhaven_url" | sed 's|https://wallhaven.cc/w/||')

# Get the first two characters for the subdirectory
subdir="${wallpaper_id:0:2}"

# Construct the full download URL (try jpg first)
download_url_jpg="https://w.wallhaven.cc/full/${subdir}/wallhaven-${wallpaper_id}.jpg"
download_url_png="https://w.wallhaven.cc/full/${subdir}/wallhaven-${wallpaper_id}.png"

# Create the destination directory
destination_dir="$wallpaper_location"
if [ -n "$path_suffix" ]; then
  destination_dir="$wallpaper_location/$path_suffix"
fi

mkdir -p "$destination_dir"

# Function to download and save file
download_wallpaper() {
  local url="$1"
  local extension="$2"
  local filename="wallhaven-${wallpaper_id}.${extension}"
  local filepath="$destination_dir/$filename"

  echo "Please enter a location for $url"
  echo "Downloading to: $filepath"

  if curl -f -L -o "$filepath" "$url" 2>/dev/null; then
    echo "Successfully downloaded: $filename"
    echo "Saved to: $filepath"
    return 0
  else
    return 1
  fi
}

# Try downloading as JPG first, then PNG if that fails
if download_wallpaper "$download_url_jpg" "jpg"; then
  exit 0
elif download_wallpaper "$download_url_png" "png"; then
  exit 0
else
  echo "Error: Failed to download wallpaper from both JPG and PNG URLs"
  echo "Tried:"
  echo "  - $download_url_jpg"
  echo "  - $download_url_png"
  exit 1
fi

