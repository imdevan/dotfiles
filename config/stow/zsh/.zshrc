# Add this to the TOP of your .zshrc to profile
zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# eval "$(/opt/homebrew/bin/brew shellenv)"
# cach brew shellenv
if [[ -f ~/.brew_shellenv.zsh ]]; then
  source ~/.brew_shellenv.zsh
else
  /opt/homebrew/bin/brew shellenv > ~/.brew_shellenv.zsh
  source ~/.brew_shellenv.zsh
fi
# Must be before loading .oh-my-zsh
# Skip expensive security checks - useful in multi-user systems, but unnecessary on your personal
ZSH_DISABLE_COMPFIX=true

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# # Use cached completions (rebuild only once per day)
# autoload -Uz compinit
# if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
#   compinit
# else
#   compinit -C
# fi

# Oh My Posh!
eval "$(oh-my-posh init zsh)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # eval "$(oh-my-posh init zsh --config https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/bubbles.omp.json)"
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/hunk.omp.json)"
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin.omp.json)"
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/bubbles.omp.json)"
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/1_shell.omp.json)"
  eval "$(oh-my-posh init zsh --config ~/dotfiles/config/oh-my-posh/themes/bubbles.toml)"
  # eval "$(oh-my-posh init zsh --config ~/dotfiles/config/oh-my-posh/themes/catty.toml)"
  # eval "$(oh-my-posh init zsh --config ~/dotfiles/config/oh-my-posh/themes/1_shell.toml)"
fi

# cache oh-my-posh
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   if [[ ! -f ~/.oh-my-posh-init.zsh ]] || [[ ~/dotfiles/config/oh-my-posh/themes/bubbles.toml -nt ~/.oh-my-posh-init.zsh ]]; then
#     oh-my-posh init zsh --config ~/dotfiles/config/oh-my-posh/themes/bubbles.toml > ~/.oh-my-posh-init.zsh
#   fi
#   source ~/.oh-my-posh-init.zsh
# fi

# Add a blank line after the prompt
# echo ""

# function add_blank_line_after_prompt() {
#   echo ""
# }
# precmd() {
#   echo ""
# }

preexec(){
  echo
}

# precmd_functions+=(add_blank_line_after_prompt)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME=powerlevel420k/powerlevel420k

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ":omz:update" mode disabled  # disable automatic updates
# zstyle ":omz:update" mode auto      # update automatically without asking
# zstyle ":omz:update" mode reminder  # just remind me to update when it"s time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ":omz:update" frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see "man strftime" for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# custom plugin added: https://github.com/jeffreytse/zsh-vi-mode

# needed for nvm to be lazyloaded MUST come before plugins are loaded
export NVM_LAZY_LOAD=true

plugins=(zsh-vi-mode nvm web-search)

# Only load zsh-vi-mode if you want vi keybindings
# Option 1: Load on first ESC press (vi mode trigger)
# bindkey -v  # Enable vi mode built-in
# autoload -Uz zsh-vi-mode

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR="vim"
# else
#   export EDITOR="nvim"
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/dotfiles/index.sh

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# eval "$(zoxide init zsh)"
# with cache:
if [[ ! -f ~/.zoxide-init.zsh ]]; then
  zoxide init zsh > ~/.zoxide-init.zsh
fi
source ~/.zoxide-init.zsh

# Start tmux automatically if not already inside tmux
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux attach-session -t 0 || tmux new-session -s 0
# fi

# Add cargo (rust toolkit) to path
export PATH="${HOME}/.cargo/bin:${PATH}"


# Add aerospace to path
export PATH="/Applications/Aerospace.app/Contents/MacOS:$PATH"

## Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# # lazyload
# pyenv() {
#   unfunction pyenv
#   eval "$(command pyenv init - zsh)"
#   pyenv "$@"
# }
#
# python() {
#   unfunction pyenv python
#   eval "$(command pyenv init - zsh)"
#   python "$@"
# }

# Add android paths 
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulatorand
export PATH=$PATH:$ANDROID_HOME/platform-tools

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
export JAVA_HOME=$(brew --prefix)/opt/openjdk@17

# Added by Antigravity
export PATH="/Users/devy/.antigravity/antigravity/bin:$PATH"

# ZSH syntax highlight plugin
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2025-12-05 21:23:32
export PATH="$PATH:/Users/devy/.local/bin"
export PATH="/Users/devy/.bun/bin:$PATH"

# NU shell config

export NU_CONFIG_DIR="$HOME/.config/nushell"

# Bind keys to widgets
# Apply to the global/main keymap
bindkey -M main " " magic-space

# Apply specifically to emacs and vi-insert modes
bindkey -M emacs " " magic-space
bindkey -M viins " " magic-space

# For output testing 
zprof > ~/.zsh_profile

