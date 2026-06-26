# # Keep omarchy-zsh config
# If not running interactively, don't do anything
[[ $- != *i* ]] && return # todo: validate what the purpose of this interactively
                          # should probably be more of a check to conditionally run starthip. likely still want aliases, if not also functions. 

# Environment variables
# ================================================================================
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# fzf configuration - match fish
export FZF_DEFAULT_OPTS='--cycle --layout=default --height=90% --preview-window=wrap --marker="*"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:wrap"

# Ensure mise works (disable command hashing)
setopt NO_HASH_CMDS
setopt NO_HASH_DIRS

# Functions
# ================================================================================
# Open files with xdg-open
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Tool initialization with safety checks
# ================================================================================
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh --shims)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Homebrew for linux
# un comment when needed
# TODO: lazyload this (like above)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# History config
# ================================================================================
# TODO: probably move this to global configs
# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=32768
SAVEHIST=32768
setopt APPEND_HISTORY           # Append to history file
setopt SHARE_HISTORY            # Share history across sessions
setopt HIST_IGNORE_DUPS         # Ignore duplicate commands
setopt HIST_IGNORE_SPACE        # Ignore commands starting with space
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blanks

# Completion configuration
setopt COMPLETE_IN_WORD         # Complete from both ends of word
setopt ALWAYS_TO_END            # Move cursor to end after completion
setopt AUTO_MENU                # Show completion menu on tab
setopt AUTO_LIST                # List choices on ambiguous completion
setopt NO_MENU_COMPLETE         # Don't autoselect first completion

# Directory navigation
setopt AUTO_CD                  # cd by typing directory name
setopt AUTO_PUSHD               # Push directories onto stack
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_MINUS              # Exchange + and - for pushd

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Completion menu navigation
zstyle ':completion:*:*:*:*:*' menu select

# Don't complete hidden files unless explicitly requested
zstyle ':complaetion:*' special-dirs false





