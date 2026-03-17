# Manual Setup Steps

## Terminal
------------------------------------------------------------------------

### clone dotfiles 

```sh
cd ~
git clone https://github.com/imdevan/dotfiles.git
```

### homebrew 

Install homebrew (https://brew.sh/)[https://brew.sh/]
https://docs.brew.sh/Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install packages

```bash
brew bundle install --file=~/dotfiles/config/homebrew/Brewfile
```

### oh my zsh 

Zsh https://ohmyz.sh/#install

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```

### GNU stow

```sh
cd ~/dotfiles/config/stow
stow -t ~/ stow
```


### connect everything else

```sh
cd ~/dotfiles/config/stow
stow *
```

### wezterm

https://wezterm.org/installation.html

```sh
brew install --cask wezterm
```

### theme - oh-my-posh
https://ohmyposh.dev/docs/installation/macos
brew install jandedobbeleer/oh-my-posh/oh-my-posh


## Editors
------------------------------------------------------------------------

### 1: download

#### cursor
https://www.cursor.com/

#### vs_code
https://code.visualstudio.com/

### 2: config

disable the Apple press and hold for VSCode and Cursor

```sh
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```



## Vim
------------------------------------------------------------------------

### install neovim
https://github.com/neovim/neovim/blob/master/INSTALL.md


### install lazyvim
https://www.lazyvim.org/

### config

Using GNU stow and installed aliases: 

```sh
cd ~/dotfiles/config/stow/
sto nvim
```

## Keyboard
------------------------------------------------------------------------

### swap keyboard keys - karabiner elements

https://karabiner-elements.pqrs.org/ 
- Swap caps_lock for esc

### macros - keyboard maestro

[Download](https://www.keyboardmaestro.com/main/)

Import macros from [saved macros](https://github.com/imdevan/keyboard-maestro-macros)

### desktop manager - aerospace

```sh
brew install --cask nikitabobko/tap/aerospace
```

note: I like aerospace but cautious of performance
- possible alternatives: 
- - raycast
- - yabai - https://github.com/koekeishiya/yabai/tree/master

### change native desktop switcher settings 

(mac keyboard > shortcuts)´





# Todo:
------------------------------------------------------------------------

- Move .zshrc to ./config/.zshrc(or consider different name)?
- - is it possible to use STOW for this? 
- - or should I just make the name the same and source it? 

- Add keyboard maestro config exports to d1otfiles- 
