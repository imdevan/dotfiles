# Set os flags
IS_MAC=false
IS_ARCH=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ -f /etc/arch-release ]] && IS_ARCH=true

if [[ $IS_ARCH ]]; then
  # check for and install yay if absent
  yay -S --needed - < ~/dotfiles/config/deps/aur
fi


if [[ $IS_MAC ]]; then
  echo "mac logic"
  # check for and install homebrew if absent
  # brew install $(~/dotfiles/config/deps/homebrew)
fi

# stow dotfiles
cd ~/dotfiles/config/stow
stow stowrc --target=$HOME
stow */ --ignore=stowrc

