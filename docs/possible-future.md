# Possible Future

> “...Things that yet may be”
>         - Galadriel

## Top priorities

- [ ] use variables for git hub, files, and other psersonal variablizable information

## Things to figure out

- Open file in vim from InsertVSCodeFork
- How to move file to a directory and have it update file references; like vs code
- tmux double stack all left side status bar layout
- move homebrew config to stow?
- how can I make this a one line install?
- should I convert my alaises + alias_utils into a go-commander app?https://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.htmlhttps://wezterm.org/config/appearance.html
- the notch https://notes.alinpanaitiu.com/Fullscreen-apps-above-the-MacBook-notch
- install https://github.com/FelixKratz/dotfiles/blob/master/.install.sh
- https://dooit-org.github.io/dooit/extra/dooit_extras.html
- Slow whitespace typing on nvim 
- Slightly slow zsh load times kkkkkk
- how can i integrate nushell features where needed? 
- swtich to fish as default? 


## Things to check out

- https://github.com/NvChad/NvChad
- https://github.com/twpayne/chezmoi or nix
- https://github.com/holman/dotfiles/tree/master
- https://github.com/gh0stzk/dotfiles
- https://github.com/paulirish/dotfiles
- https://github.com/PatrickJS/awesome-cursorrules
- https://pastebin.com/wLX4cZu6
- https://terminaltrove.com/explore/
- tldr
- configure ls to eza https://github.com/eza-community/eza
- yazi
- jq for json viewing and querying https://jqlang.org/
- espanso https://espanso.org/

## things to change

- Auto suggestions form lsp offten add things i may not want to 
  - when going to a new line? -> could map shift enter to next line in inert mode...
    or enter defaults to newline and shift enter accepts change
- jb color
- sketchybar show tmux status info  ... hide tmux window in terminal
- finish ark skip macro
- tmux status: 
  - swap left and right side or add both to left
  - implement location to truncate all parent folder names
    - e.g. dance-partner/dance-partner-app/app/expo -> dp/dpa/a/expo
    - maybe even a more dynamic solution based on length

### Considerations of tools to add

- [ ] consider adding marta config (e.g. <https://github.com/agenttank/dotfiles_macos/blob/main/marta/conf.marco>)
- [ ] consider using just <https://github.com/casey/just> for non-js projects
- [ ] janky borders <https://github.com/FelixKratz/JankyBorders>
- [ ] hammerspoon for scripting <https://www.hammerspoon.org/>
- [ ] eza <https://github.com/eza-community/eza>
- [ ] nix package manager / nixos
- [ ] nu shell <https://github.com/nushell/nushell> has some nice navigation features
- [ ] yazi <https://github.com/sxyazi/yazi>
- [ ] zed <https://zed.dev/q>
- [ ] indent blank line colors <https://github.com/lukas-reineke/indent-blankline.nvim>
- [ ] nvim better function folding <https://github.com/kevinhwang91/nvim-ufo>
- [ ] <https://github.com/koekeishiya/skhd>
- [ ] <https://github.com/nvbn/thefuck>
- [ ] https://github.com/tmux-plugins/tmux-yank
- [ ] tmux open https://github.com/tmux-plugins/tmux-open
- [ ] tmux copycat https://github.com/tmux-plugins/tmux-copycat
- [ ] - with search => could solve the ghostty "no search" issue
- [x] consider switching to alacritty eventually - landed on wezterm
- [ ] presentations in terminal https://github.com/museslabs/kyma
- [ ] nnn https://github.com/jarun/nnn
- [ ] starship https://starship.rs/
- [ ] https://github.com/jj-vcs/jj
- [ ] lulu https://formulae.brew.sh/cask/lulu#default
- [ ] wireguard-go
- [ ] shell check for scripts
- [ ] squall https://terminaltrove.com/squall/


### Additional dotfile insipiration

Check his bash_profile setup and .macos
<https://github.com/mathiasbynens/dotfiles/tree/main>
<https://github.com/Kyuuhachi/worzel.nvim/blob/main/lua/worzel.lua>

### Zsh plugins

zsh vi mode
<https://github.com/jeffreytse/zsh-vi-mode>
Did it, love it

zoxide
<https://github.com/z-shell/zsh-zoxide>
Did it, like it

printc - could replace vars/colors
<https://github.com/philFernandez/printc>

cluster of plugins to consider
<https://github.com/zshzoo/zshzoo>

syntax-highlighting
<https://github.com/zsh-users/zsh-syntax-highlighting>

zsh-autosuggestions
<https://github.com/zsh-users/zsh-autosuggestions>

zsh-bat
<https://github.com/fdellwing/zsh-bat>

plugin manager
<https://github.com/zpm-zsh/zpm>
another plugin manager
<https://github.com/marlonrichert/zsh-snap>

mac utils
<https://github.com/unixorn/tumult.plugin.zsh>

git utils
<https://github.com/unixorn/git-extra-commands>

zplug - wish more plugins supported this
<https://github.com/zplug/zplug>

you-should-use <https://github.com/MichaelAquilina/zsh-you-should-use>

keybinds
<https://github.com/marlonrichert/zsh-edit>

silly hacker quotes
<https://github.com/oldratlee/hacker-quotes>

copilot - im sus on the costing of api usage vs gpt in browser
<https://github.com/Myzel394/zsh-copilot>

additional plugins
<https://github.com/unixorn/awesome-zsh-plugins>

### Dotfiles to consider

<https://github.com/simonsmith/dotfiles/blob/master/scripts/macos.sh>

- note one that allows you to tab through mac menus

<https://github.com/z0rc/dotfiles>

<https://github.com/bradp/dotfiles>

<https://github.com/LucasLarson/dotfiles>

<https://github.com/unixorn/zsh-quickstart-kit>

### Aerospace improvements

Read: <https://nikitabobko.github.io/AeroSpace/goodies>

Replace status bar
<https://github.com/FelixKratz/SketchyBar>
<https://felixkratz.github.io/SketchyBar/features>

Integrate with SketchyBar

Integrate jankyboarders <https://nikitabobko.github.io/AeroSpace/goodness#highlight-focused-windows-with-colored-borders>

#### tomls to read

<https://github.com/simonsmith/dotfiles/blob/master/dots/aerospace.toml>

<https://github.com/simonsmith/dotfiles/blob/master/dots/aerospace.toml>

## Terminal Possible

<https://github.com/alacritty/alacritty>

<https://github.com/sxyazi/yazi>

fun animations to add 
https://github.com/toolleeo/awesome-cli-apps-in-a-csv#animation

## Nvim improvements

<https://github.com/gbprod/yanky.nvim>

write plugin to randomize header images

- did it, love it

-- other snacks considerations: <https://github.com/zvrkSam/nvim-dotfiles/blob/main/lua/plugins/snacks-noice.lua#52>

Wez term 
- parallax https://wezterm.org/config/lua/config/background.html#parallax-example

enable yanky
<https://www.lazyvim.org/extras/coding/yanky>

markdown rendering improvements
- probably just disable the ui stuff (hiding brackets and comments)
- http://www.lazyvim.org/extras/lang/markdown

## tmux improvements

tmux inspiration: <https://github.com/catppuccin/tmux/discussions/317>

- currently the "current folder" status on the right can get really big and eat the left side on smaller widths

## desktop improvements

jankyborders
<https://github.com/FelixKratz/JankyBorders>

## Other people's dotfiles to be inspired by

<https://github.com/nik-rev/dotfiles/tree/main/>
