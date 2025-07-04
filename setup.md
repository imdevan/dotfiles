# Manual Setup Steps

## Terimal
------------------------------------------------------------------------

### homebrew 

Install homebrew (https://brew.sh/)[https://brew.sh/]
https://docs.brew.sh/Installation

### zsh + dotfiles

Zsh https://ohmyz.sh/#install

### clone dotfiles 

```sh
cd ~
git clone https://github.com/imdevan/dotfiles.git
```

### connect zsh

```sh
cd ~/dotfiles/config/stow
stow -t ~/ zsh
```

### ghostty

https://ghostty.org/download

```sh
brew install --cask ghostty

```
### theme - oh-my-posh
https://ohmyposh.dev/docs/installation/macos
brew install jandedobbeleer/oh-my-posh/oh-my-posh


### font

```sh
brew install --cask font-fira-code-nerd-font

### helpful homebrew

todo: setup brewfile in config
```
```

## Editors
------------------------------------------------------------------------

## cursor
https://www.cursor.com/

## vs_code
https://code.visualstudio.com/

disable the Apple press and hold for VSCode and Cursor

```sh
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```


Copy ./vscode/settings.json into the vscode settings found in vscode and cursor

todo: can i use stow for this?

## Vim
------------------------------------------------------------------------

### install neovim
https://github.com/neovim/neovim/blob/master/INSTALL.md


### install lazyvim
https://www.lazyvim.org/

### config

clone nvim_config repo into `~/.config/nvim`

```
git clone https://github.com/imdevan/nvim_config
```

todo: can i use stow for this?

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

- Add keyboard maestro config exports to dotfiles- 
