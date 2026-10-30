#!/usr/bin/env bash

# OS bootstrap
# install packages, stow config files, set zsh as default shell
# additional steps
# mkdir ~/Projects && cd ~/Projects && git clone 

# Set os flags
# ========================================================================================================================
IS_MAC=false
IS_ARCH=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ -f /etc/arch-release ]] && IS_ARCH=true

# Install omarch packages
if [[ $IS_ARCH == true ]]; then
  # check for and install yay if absent
  # only install packages that aren't already installed
  echo "omarchy detected"
  missing=$(comm -23 <(sort -u ~/dotfiles/config/packages/aur) <(pacman -Qq | sort))
  [[ -n "$missing" ]] && yay -Su --needed - <<< "$missing"
fi


# Install mac packages
if [[ $IS_MAC == true ]]; then
  echo "mac detected"
  # check for and install homebrew if absent
  # brew install $(~/dotfiles/config/deps/homebrew)
  # run mac/macos_setup.sh
fi

# stow dotfiles
# ========================================================================================================================
# packages are grouped by os: global is stowed everywhere, plus the group for this os
STOW_ROOT=~/dotfiles/config/stow
stow_groups=(global)
[[ $IS_MAC == true ]] && stow_groups+=(macos)
[[ $IS_ARCH == true ]] && stow_groups+=(omarchyos)

# stow stow config
stow -d "$STOW_ROOT/global" -t "$HOME" stowrc

# remove conflicts
# ========================================================================================================================
# dry run stow and pull conflicting target paths (relative to $HOME) out of its warnings
conflicts=$(for group in "${stow_groups[@]}"; do
  (cd "$STOW_ROOT/$group" && stow -n */ 2>&1)
done | sed -nE \
  -e 's/^  \* cannot stow .* over existing target (.*) since .*/\1/p' \
  -e 's/^  \* existing target is [^:]*: (.*)/\1/p' | sort -u)

if [[ -n "$conflicts" ]]; then
  echo "stow conflicts found:"
  echo "$conflicts" | sed 's/^/  ~\//'
  read -rp "remove conflicting files? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    while IFS= read -r target; do
      rm -rf -- "$HOME/$target" && echo "removed ~/$target"
    done <<< "$conflicts"
  fi
fi

# stow everything else
for group in "${stow_groups[@]}"; do
  echo "stowing $group"
  (cd "$STOW_ROOT/$group" && stow */)
done


# set zsh as the login shell
# ========================================================================================================================
zsh_path=$(command -v zsh)
if [[ -n "$zsh_path" && "$SHELL" != "$zsh_path" ]]; then
  grep -qx "$zsh_path" /etc/shells || echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null
  chsh -s "$zsh_path" && echo "login shell set to $zsh_path (log out and back in to apply)"
fi
