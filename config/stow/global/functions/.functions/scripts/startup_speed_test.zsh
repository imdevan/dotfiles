#!/usr/bin/env zsh

# Script: startup_speed_test
# Description: Time zsh startup 5 times and count sourced files
# Usage: startup_speed_test
# Alias: sst

zmodload zsh/datetime # $EPOCHREALTIME
source "$HOME/.functions/shared/colors.sh"

function startup_speed_test() {
  local threshold=0.100  # 100 ms as seconds

  for i in {1..5}; do
local start end diff

start=$EPOCHREALTIME
zsh -i -c exit > /dev/null 2>&1
end=$EPOCHREALTIME

diff=$(printf "%.3f" "$(echo "$end - $start" | bc)")

# Convert to ms for display
local ms=$(printf "%.0f" "$(echo "$diff * 1000" | bc)")

if (( $(echo "$diff <= $threshold" | bc) )); then
  printf "%b%ims%b startup time\n" "$green" "$ms" "$reset"
else
  printf "%b%ims%b startup time\n" "$red" "$ms" "$reset"
fi
  done


  echo "\nSourced files:\n"
  grep -E "^\s*(source|\.|autoload)" ~/.zshrc  ~/dotfiles/index.sh ~/dotfiles/functions/index.sh /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh | wc -l
}

startup_speed_test "$@"
