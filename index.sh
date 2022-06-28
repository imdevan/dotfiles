# Chance this is you change the location of these dotfiles
dotfile_dir=~/dotfiles

# ZSH Config
source $dotfile_dir/.zsh-config

# NVM Config
source $dotfile_dir/.nvm-config

# Variables used everywhere
source $dotfile_dir/vars/colors.sh

# A bunch of aliases
source $dotfile_dir/aliases.sh

# Functions loosely organized category
source $dotfile_dir/functions/hiddenfiles.sh
source $dotfile_dir/functions/localhost.sh
source $dotfile_dir/functions/github.sh
source $dotfile_dir/functions/emoji.sh
