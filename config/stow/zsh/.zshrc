# Zsh profiler start
# ================================================================================
# Add this to the TOP of your .zshrc to profile
# Uncomment to track load times
zmodload zsh/zprof

# Zsh preload
# ================================================================================
# Must be before loading .oh-my-zsh
# Skip expensive security checks - useful in multi-user systems, but unnecessary on your personal
ZSH_DISABLE_COMPFIX=true

# initialize zsh defer
# https://github.com/romkatv/zsh-defer
source ~/zsh-defer/zsh-defer.plugin.zsh

# 
autoload -Uz compinit
compinit -C -u -d ~/.zcompdump

# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Zsh behavior
# ================================================================================
# Add a blank line after the prompt
preexec(){
  echo
}

# Use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Auto-update behavior
zstyle ":omz:update" mode disabled  # disable automatic updates
# zstyle ":omz:update" mode auto      # update automatically without asking
# zstyle ":omz:update" mode reminder  # just remind me to update when it"s time

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Speed up OMZ by disabling unnecessary features
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"


# Zsh plugins
# ================================================================================
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
# custom plugin added: https://github.com/jeffreytse/zsh-vi-mode

# needed for nvm to be lazyloaded MUST come before plugins are loaded
# export NVM_LAZY_LOAD=true
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh

# Plugins
# plugins=(zsh-vi-mode web-search zsh-autosuggestions)

# Directly source plugins for defer optimization
source $ZSH/custom/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
zsh-defer source $ZSH/plugins/web-search/web-search.plugin.zsh
zsh-defer source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

bindkey '^ ' autosuggest-accept

# Zsh load
# ================================================================================
source $ZSH/oh-my-zsh.sh

# Zsh post-load
# ================================================================================
# todo find where to fix this
unalias l

# Magic space plugin config
# ================================================================================
# Bind keys to widgets
# Apply to the global/main keymap
bindkey -M main " " magic-space

# Apply specifically to emacs and vi-insert modes
bindkey -M viins " " magic-space

# My dotfiles
# ================================================================================
source ~/dotfiles/index.sh
zsh-defer source ~/.bookmarks/bookmarks.sh

# OS specific setup
# ================================================================================
IS_MAC=false
IS_ARCH=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ -f /etc/arch-release ]] && IS_ARCH=true

# Omarchy
if $IS_ARCH; then
  source ~/.config/zsh/.omarchyrc.sh
fi

# Mac
if $IS_MAC; then
  zsh-defer source ~/.config/zsh/.macrc.sh
fi

# Tmux
# ================================================================================
# Start tmux automatically if not already inside tmux
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux attach-session -t 0 || tmux new-session -s 0
# fi

# Python setup
# ================================================================================
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

# lazyload
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  pyenv "$@"
}

python() {
  unfunction pyenv python
  eval "$(command pyenv init - zsh)"
  python "$@"
}

# Path and vars
# ================================================================================

# Rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# Android
export ANDROID_HOME=/opt/android-sdk
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

# Local bin
export PATH="$PATH:$HOME/.local/bin"

# Nushell
export NU_CONFIG_DIR="$HOME/.config/nushell"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

zstyle ':completion:*' verbose no
zstyle ':fzf-tab:*' continuous-trigger ''


# Github token
source ~/.github_token

# Zsh profiler end
# ================================================================================
# For output testing 
# Uncomment to track load times
zprof > ~/.zsh_profile

