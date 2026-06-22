# # Keep omarchy-zsh config
# If not running interactively, don't do anything
[[ $- != *i* ]] && return # todo: validate what the purpose of this line is

# Load omarchy-zsh configuration
if [[ -d $HOME/dotfiles/config/omarchy-zsh/conf.d ]]; then
  for config in $HOME/dotfiles/config/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d $HOME/dotfiles/config/omarchy-zsh/functions ]]; then
  for func in $HOME/dotfiles/config/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi

# Homebrew for linux
# un comment when needed
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ZSH syntax highlighting loaded via zinit turbo in .zshrc


