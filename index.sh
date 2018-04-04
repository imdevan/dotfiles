# Chance this is you change the location of these dotfiles
dotfile_dir=~/dotfiles

# Variables used everywhere
source $dotfile_dir/vars/colors.sh

# Functions loosely organized category
source $dotfile_dir/functions/localhost.sh
source $dotfile_dir/functions/aliases.sh
source $dotfile_dir/functions/github.sh
source $dotfile_dir/functions/facebook.sh

# A bunch of aliases
source $dotfile_dir/aliases.sh

alias ..='cd ..'
