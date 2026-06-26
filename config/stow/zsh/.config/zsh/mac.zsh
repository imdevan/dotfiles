# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path and vars
# ================================================================================

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Bun
export PATH="$HOME/.bun/bin:$PATH"

# Android (macOS)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"

# eval "$(/opt/homebrew/bin/brew shellenv)"
# cach brew shellenv
# only execute on darwin

# if [[ -f ~/.brew_shellenv.zsh ]]; then
#   source ~/.brew_shellenv.zsh
# else
#   /opt/homebrew/bin/brew shellenv > ~/.brew_shellenv.zsh
#   source ~/.brew_shellenv.zsh
# fi

# https://ohmyposh.dev/docs/installation/linux
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
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  if [[ ! -f ~/.oh-my-posh-init.zsh ]] || [[ ~/dotfiles/config/oh-my-posh/themes/bubbles.toml -nt ~/.oh-my-posh-init.zsh ]]; then
    oh-my-posh init zsh --config ~/dotfiles/config/oh-my-posh/themes/bubbles.toml >~/.oh-my-posh-init.zsh
  fi
  source ~/.oh-my-posh-init.zsh
fi

# todo: go is managed by omarchy seperate mac deps
# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="$HOME/go/bin:$PATH"

# Add aerospace to path
# export PATH="/Applications/Aerospace.app/Contents/MacOS:$PATH"

# todo: conslidate mac configs
# export JAVA_HOME=$(brew --prefix)/opt/openjdk@17

# Mac
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# zoxide
# eval "$(zoxide init zsh)"
# with cache:
# if [[ ! -f ~/.zoxide-init.zsh ]]; then
#   zoxide init zsh > ~/.zoxide-init.zsh
# fi
# source ~/.zoxide-init.zsh
