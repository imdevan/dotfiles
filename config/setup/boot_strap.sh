#!/usr/bin/env bash

# WIP - use manual process for now :)

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Check if homebrew is installed
#
# Install Homebrew if not installed
#
# Install homebrew via brew file
#
./config/homebrew/install_packages.sh

# Run mac os setup
./config/macos/.macos

# Configure stow
# See https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow
# For more information on stowing packages
cd ./config/stow
stow -t ~/ stowrc

# Install remaining stow files
stow * --ignore=stowrc

# This should automatically add the dotfile setup to the zshrc config

# Check if zshrc or bashrc contains a source to dotfile index
#
# Add source $dotfile_dir/index if not present
#
#
