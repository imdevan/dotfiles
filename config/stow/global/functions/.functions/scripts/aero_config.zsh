#!/usr/bin/env zsh

# Script: aero_config
# Description:
#
# Swap out aeorspace config files. 
# This was implemented as a work around. Ideally specific properties should be updateable. 
# Should probably also be an aero space plugin of some kind
#
# Usage: aero_config [config_name]
#
# possibly move inside of aerosace config stow dir
# Alias: ac

dotfile_dir="${dotfile_dir:-$HOME/dotfiles}"

function aero_config() {
    if [ -z "$dotfile_dir" ]; then
        echo "Error: dotfile_dir is not set."
        return 1
    fi

    local config_name=$1
    if [ -z "$config_name" ]; then
        config_name="default"
    fi

    local source_config="$dotfile_dir/config/stow/aerospace/.aerospace.$config_name.toml"
    local dest_config="$dotfile_dir/config/stow/aerospace/.aerospace.toml"

    if [ -f "$source_config" ]; then
        cp "$source_config" "$dest_config"
        aerospace reload-config
        echo "Aerospace configuration reloaded with '$config_name' config."
    else
        echo "Error: Configuration '$config_name' not found at '$source_config'"
    fi
}

aero_config "$@"
