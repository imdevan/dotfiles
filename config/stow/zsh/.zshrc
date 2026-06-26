# Profiler (uncomment to profile)
zmodload zsh/zprof

# Zinit installer
# ================================================================================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"
# Compile zinit for faster loads
if [[ ! -e "$ZINIT_HOME/zinit.zsh.zwc" || "$ZINIT_HOME/zinit.zsh" -nt "$ZINIT_HOME/zinit.zsh.zwc" ]]; then
  zcompile "$ZINIT_HOME/zinit.zsh"
fi

# Plugins
# ================================================================================
# zsh-vi-mode must load synchronously (it hijacks keymaps on load)
zinit light jeffreytse/zsh-vi-mode

# defer id snippet — deferred atload via zinit turbo mode
# defer_plugins plugin... — deferred plugin load
defer() { zinit wait lucid light-mode for id-as"$1" atload"$2" zdharma-continuum/null }
defer_plugins() { zinit wait lucid light-mode for "$@" }

# Turbo (deferred) plugins
defer_plugins \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search \
  Aloxaf/fzf-tab \
  OMZP::web-search

# Arch system syntax highlighting (avoid duplicate install)
defer "zsh-syntax-highlighting" "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

# Completion
# ================================================================================
autoload -Uz compinit
compinit -C -u
# zinit cdreplay -q

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

# Keybinds
# ================================================================================
bindkey '^ ' autosuggest-accept
bindkey -M main " " magic-space
bindkey -M viins " " magic-space

# Zsh behavior
# ================================================================================
preexec(){ echo }
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
zstyle ':completion:*' verbose no
zstyle ':fzf-tab:*' continuous-trigger ''

# Path and vars
# ================================================================================
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="$PATH:$HOME/.local/bin"
export ANDROID_HOME=/opt/android-sdk
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
export NU_CONFIG_DIR="$HOME/.config/nushell"

# Python (lazy)
# ================================================================================
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

# My dotfiles
# ================================================================================
source ~/dotfiles/index.sh
source ~/.github_token

# OS specific setup
# ================================================================================
IS_MAC=false
IS_ARCH=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ -f /etc/arch-release ]] && IS_ARCH=true

$IS_ARCH && source ~/.config/zsh/omarchy.zsh
$IS_MAC  && defer "mac" "source ~/.config/zsh/mac.zsh"

# Bookmarks (deferred)
defer "bookmarks" "source ~/.bookmarks/bookmarks.sh"

# Kiro shell integration
defer "kiro" '[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"'

# Prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Profiler output (uncomment to profile)
zprof > ~/.zsh_profile
