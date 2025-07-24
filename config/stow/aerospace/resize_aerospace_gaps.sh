#!/usr/bin/env bash

update_toml_presets() {
  local target_file="~/dotfiles/config/stow/aerospace/.aerospace.toml"
  local preset_option="$1"
  local preset_file=""

  if [[ "$preset_option" == "0" ]]; then
    preset_file=".no_gap_preset"
  elif [[ "$preset_option" == "1" ]]; then
    preset_file=".md_gap_preset"
  else
    echo "Invalid preset option: $preset_option (use 0 or 1)"
    return 1
  fi

  if [[ ! -f "$target_file" || ! -f "$preset_file" ]]; then
    echo "Missing target file or preset file: $target_file / $preset_file"
    return 1
  fi

  # Keep everything up to and including "## presets", then append preset
  awk '/## presets/ { print; exit } { print }' "$target_file" > "${target_file}.tmp"
  cat "$preset_file" >> "${target_file}.tmp"
  mv "${target_file}.tmp" "$target_file"
}