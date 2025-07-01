# Manual Setup Steps

## Terimal
------------------------------------------------------------------------

### zsh + dotfiles

Zsh https://ohmyz.sh/#install

### clone dotfiles 

```bash
cd ~
git clone https://github.com/imdevan/dotfiles.git
```

### connect zsh

todo: can i use stow for this?
todo: i can move this to a setup script

```
echo 'source ~/dotfiles/config/.zshrc' > ~/.zshrc
```

### homebrew 

Install homebrew (https://brew.sh/)[https://brew.sh/]
https://docs.brew.sh/Installation

### ghostty

https://ghostty.org/download
```
brew install --cask ghostty
```
### theme - oh-my-posh
https://ohmyposh.dev/docs/installation/macos
brew install jandedobbeleer/oh-my-posh/oh-my-posh

### font
brew install --cask font-fira-code-nerd-font


## Editors
------------------------------------------------------------------------

## cursor
https://www.cursor.com/

## vs_code
https://code.visualstudio.com/

disable the Apple press and hold for VSCode and Cursor

```
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

note: I like aerospace but cautious of performance
- possible alternative: raycast

### change native desktop switcher settings 

(mac keyboard > shortcuts)´





# Todo:
------------------------------------------------------------------------

- Move .zshrc to ./config/.zshrc(or consider different name)?
- - is it possible to use STOW for this? 
- - or should I just make the name the same and source it? 

- Add keyboard maestro config exports to dotfiles- 
