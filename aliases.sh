# Helpful aliases
#
# Example:
# alias <name>=<string>

# Variables used in file
editor="cursor"

# Navigation
alias ..="cd .."

alias dotfiles="${editor} $dotfile_dir"
alias aliases="${editor} $dotfile_dir/aliases.sh"

## Aliases shortcut
alias a="aliases"
alias dots="~/dotfiles"
alias ra="source ~/dotfiles/aliases.sh"

# Terminal Navigation
alias la="ls -a"                         # List all in directory
alias o="open ./"                        # Open - in finder
alias cpr="cp -rf"                       # Copy recursive
alias rf="rm -rf"                        # Remove recursive
alias refresh="source ~/.zshrc && clear" # Refresh the terminal
alias r="refresh"                        # Refresh shortcut
alias t="touch"                          # Make file
alias ex="exit"                          # Exit terminal

# Home Brew
alias bri="brew install"
alias bric="brew install --cask"
alias brui="brew uninstall"

# Bun
alias bi="bun install"
alias bs="bun start"
alias bd="bun dev"
alias bb="bun build"
alias bu="bun uninstall"
alias bgen="bun generate:client"
alias bbis="bun build:ios:sim"
alias bbas="bun build:android:sim"

# Dotfile shortcuts
alias halp="cat ~/dotfiles/aliases.sh"
alias dot="cd $dotfile_dir"

alias hotkeys="v ~/dotfiles/docs/keybinds/hotkeys.md"
alias hk="hotkeys"
alias vz="v ~/dotfiles/config/stow/zsh/.zshrc"

# Docker
alias dcd="docker compose down"
alias dcu="docker compose up"
alias dcw="docker compose watch"

# Code editors
alias co="code ."
alias c="cursor ."
alias v="nvim"

# Bookmarks
alias d="dotfiles"
alias p="cd ~/Documents/Projects/"
alias play="cd ~/Documents/Projects/playground"

# Git

# Overhead
alias gco="git checkout"     # Git checkout
alias gcof="git checkout --" # Checkout file
alias conflicts="git diff --name-only --diff-filter=U"
alias no-edit="git commit --amend --no-edit"                             # Does not push
alias last="git log -1"                                                  # Show last change
alias rebase="git fetch upstream && git rebase upstream/master"          # Fetch and rebase
alias gcane!="git add -A && git commit --amend --no-edit && git push -f" # Git commit ammend no edit and force push
alias grc="git rebase --continue"
alias gfu="git fetch upstream"
alias stash="git stash"
alias ga="git add ."
alias gcane="git commit --amend --no-edit"
alias diff="git diff"
alias grem="git remote"
alias gp="git push"
alias gl="git log -1"
alias conflicts="git diff --name-only --diff-filter=U"
alias gf="git fetch"
alias gb="git branch"
alias gac="git add . && git commit -m"
alias gs="git stash"
alias gfp="git fetch && git pull"
alias gm="git merge -m ':octocat:'"
alias grs="git rebase origin/staging"
alias gd="git diff"
alias undo="git reset HEAD~1"
alias sparkles="git add . && git commit -m ':sparkles: ' && git push"
alias status="git status"
alias gcm="git commit -m"
alias grm="git rebase main"
alias gr="git checkout ." # Reset a file
alias clone="git clone"
alias gc="git clone" # Calls native git clone
alias cl="git_clone" # Calls git_clone function (clone and cd)
alias gra="git remote add"
alias gclean="git checkout . && git clean -f"
alias gdno="git diff --name-only"
alias gpu="git push upstream"
alias gppu="git push --set-upstream upstream"
alias mas="gco master"

# Branch shortcuts
alias s="git checkout staging"
alias staging="gco staging"
# alias m="git checkout master"

# Quick pushes
alias wip="gap ':construction:'"
alias gcat="gap ':octocat:'"

# Ghostty
# alias gho="ghostty"
# alias gk="ghostty +list-keybinds"
# alias gkk="v ~/dotfiles/docs/keybinds/ghostty.md"

# NPM
alias nt="npm test"
alias ns="npm start"
alias nd="npm run dev"
alias nb="npm run build"
alias nw="npm run web"
alias nee="npm run test:e2e"
alias nu="npm uninstall"
alias nrd="npm run dev"
alias ni="npm install"
alias naf="npm audit fix"
alias jc="npx jest --coverage"

# PNPM
alias pns="pnpm start"
alias pnd="pnpm dev"
alias pni="pnpm install"
alias pnn="pnpm"
alias pnb="pnpm build"
alias pnr="pnpm run"

# Google docs
alias doc="python3 -mwebbrowser https://docs.google.com/create" # New google doc
alias docs="python3 -mwebbrowser http://docs.google.com"        # Main docs folder

# Simple http.server
alias s="python3 -m http.server"

# Python
alias create-ve="python -m venv .venv"
alias cve="create-ve"
alias ve="source .venv/bin/activate"
alias py="python3"

# FastAPI
# alias fd="fastapi dev app/main.py"

# Clean Modules (and run yarn)
alias clean="rm -rf node_modules && yarn"

# Yarn
alias y="yarn"
alias yb="yarn build"
alias yys="yarn && yarn start"
alias yc="yarn clean"
alias yd="yarn dev"
alias yr="yarn run"
alias yrd="yarn run dev"
alias ys="yarn start"
alias yd="yarn dev"
alias yb="yarn build"
alias ya="yarn add"
alias yt="yarn test"
alias yad="yarn add --dev"
alias yt="yarn test"
alias yw="yarn web"
alias e2="yarn test:e2e"
alias yl="yarn lint"
alias yn="yarn next"
alias ynb="yarn next:build"
alias yg="yarn db:generate"
alias yp="yarn db:push"
alias yfd="yarn functions:deploy"
alias ydr="yarn db:reset"
alias yfs="yarn functions:serve"
alias ydp="yarn db:push"
alias yad="yarn add -D"
alias ydg="yarn db:generate"
alias ytg="yarn test grep"
alias yi="yarn install"

# Zsh web_search
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
alias goo="web_search google"
alias eco="web_search ecosia"
alias gith="web_search github"

# Docker
alias ld="lazydocker"
alias dl="docker logs"
alias dli="docker ps --format 'table {{.ID}}	{{.Names}}	{{.Status}}'"
alias dlv="docker ps --format 'table {{.ID}}	{{.Names}}	{{.Status}}' | nvim"

# New
alias fsft="cd ~/Documents/Projects/playground/full-stack-fastapi-template"
alias db="cd ~/Documents/Projects/dance-buddy"
alias bil="eas build --platform ios --profile development --local"
alias yib="yarn build:ios:dev"
alias asdf="cowsay 'hang in there!'"
alias va="v ~/dotfiles/aliases.sh"
alias pi="pip install -r requirements.txt"
alias py="python3.11"
alias bb="cd -"
alias pym="py monitor.py"
alias cve="py -m venv .venv"
alias pim="pi; py"
alias pim="pi; pym"
alias pym="py src/monitor.py"
alias jcs="cd ~/Documents/Projects/playground/just-checking-scripts"
alias vc="v ~/Library/Application\ Support/com.mitchellh.ghostty/config"
alias nvim-config="cd ~/.config/nvim"
alias np="cd ~/.config/nvim/lua"
alias np="cd ~/.config/nvim/lua/plugins"
alias aero="v .aerospace.toml"
alias aero="v ~/.config/aero.toml"
alias aero="nvim ~.config/aerospace.toml"
alias aero="v ~/.config/aerospace.toml"
alias aero="v ~/.aerospace.toml"
alias sto="stow -t ~/"
alias ez="exec zsh"
alias play="cd /Users/devy/Documents/Projects/playground"
alias vs="v ~/dotfiles/setup.md"
alias gaa="git add"
alias lg="lazygit"
alias portfolio="cd ~/Documents/Projects/portfolio"
alias pp="cd ~/Documents/Projects/portfolio"
alias eac="encore app create"
alias vpf="v ~/dotfiles/possible-future.md"
alias brs="brew services"
alias enc="encore"
alias find_string="Grep in directory"
alias gre="grep -rl"
alias encr="encore app run"
alias encr="encore run"
alias vd="v ~/dotfiles"
alias turb="npx create-turbo@latest"
alias igni="npx ignite-cli@latest new "
alias brd="bun run dev"
alias tks="tmux kill-server"
alias ta="tmux attach -t"
alias rs="brew services restart sketchybar"
alias go-tests="cd ~/Documents/Projects/playground/go-tests"
alias vt="v ~/dotfiles/config/stow/tmux/.tmux.conf"
alias tms="tmux source-file ~/.tmux.conf"
# alias tmr="tmux rename-window -t"
alias lsa="ls -a"
alias exgo="cd ~/Documents/Projects/playground/exgo"
alias vs="v ~/dotfiles/config/stow/sketchybar/.config/sketchybar"
alias vl="v ~/dotfiles/config/stow/nvim/.config/nvim/"
alias sr="brew services restart sketchybar"
alias sst="brew services stop sketchybar"
alias ss="brew services stop sketchybar"
alias ss="brew services start sketchybar"
alias gr="go run main.go"
alias cols="colima start"
alias tls="tmux list-sessions"
alias fv="fzf --bind 'enter:become(nvim {})'"
alias nv="cd ~/dotfiles/config/stow/nvim/.config"
alias nv="v ~/dotfiles/config/stow/nvim/.config/nvim"
alias gmt="go mod tidy"
alias tt="tmux attach -t 0"                                                          # add after ta alias
alias nvim-defauts="v .local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua" # Open nvim keymap defaults in nvim
alias nvd="v .local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua"          # Open nvim keymap defaults in nvim
alias mdr="make docker.run"
alias fp="git push --set-upstream origin master" # First push
alias gro="git remote add origin"
alias bve="z backend && ve"
alias bve="z backend && ve && .."
alias pyt="cd ~/Documents/Projects/playground/python-tests"
alias gc="scripts/generate-client.sh"
alias eab="eas build --platform ios --profile development --local"
alias cf="cp -rf"
alias clean="rf node_modules && bun install"
alias vdc="bve && dcw"
alias vdc="z backend && ve && dcw"
alias mast="gco master"
alias ze="z ./app/expo"
alias ief2="cd ~/Documents/Projects/ignite-expo-fast-2"
alias bsc="bs --clear"
alias sdown="sudo shutdown -h now"
alias cs="colima start"
alias pief="cd ~/Documents/Projects/project-ignite-go-fast"
alias ief="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast"
alias iefe="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/expo"
alias uvs="uv sync"
alias zb="z ./app/backend"
alias ved="deactivate"
alias t="tmux"
alias vto="v /Users/devy/Documents/Projects/project-ignite-go-fast/todo.md"
alias ba="bun add"
alias iefb="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/backend"
alias vg="v /Users/devy/dotfiles/functions/github.sh"
# alias vf="v ~/dotfiles/functions"
alias eief="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/expo"
alias devy="cd ~/Documents/Projects/project-ignite-go-fast/devy"
alias de="cd ~/Documents/Projects/project-ignite-go-fast/devy"
alias pypo="cd ~/Documents/Projects/project-ignite-go-fast/pypo"
alias epy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/expo"
alias bpy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/backend"
alias epy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/app/expo"
alias bpy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/app/backend"
alias restart="sudo shutdown -r now"
alias dance="cd ~/Documents/Projects/dance-partner"
alias dpa="cd ~/Documents/Projects/dance-partner/dance-partner-app"
alias bdpa="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/backend"
alias edp="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/expo"
alias bdp="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/backend"
alias csd="cs && dcw"
alias pt="python google_photo_transfer.py"
alias ppt="rf output2 && pt -d ./tests2 -o ./output2"
alias tka="tmux kill-session -a"
alias rndp="cd ~/Documents/Projects/playground/react-native-dropdown-picker"
alias nrw="npm run web"
alias nclean="rf node_modules && rm package-lock.json && ni"
alias au="grem add upstream https://github.com/imdevan/react-native-dropdown-picker.git"
alias rndp="cd ~/Documents/Projects/playground/react-native-dropdown/react-native-dropdown-picker"
alias nnrw="nclean && nrw"
alias ma="gco main"
alias nis="npm install -S"
alias gcob="gco -b"
alias pr="open https://github.com/imdevan/react-native-dropdown-picker/compare/main...imdevan:react-native-dropdown-picker:main"
alias rndp2="cd ~/Documents/Projects/playground/react-native-dropdown/rndp2"
alias nrl="npm run lint"
alias ninrw="ni && nrw"
alias nid="npm i --save-dev"
alias nrc="npm run clean"
alias gcrndp="gcl https://github.com/imdevan/react-native-dropdown-picker.git"
alias nrp="npm run prettier"
alias fd="gfp && nrd"
alias k="kiro ./"
alias fs="~/dotfiles/functions"
alias rndp3="cd ~/Documents/Projects/playground/react-native-dropdown/rndp3"
alias ved="deactivate"
alias vdcw="ve && dcw"
alias rndpe="cd ~/Documents/Projects/playground/react-native-dropdown/react-native-dropdown-picker/examples"
alias count="v /Users/devy/Documents/Projects/playground/scripts/userStylesCount.js"
