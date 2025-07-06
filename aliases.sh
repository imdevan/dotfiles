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
alias c="code ."
alias cu="cursor ."
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

# Branch shortcuts
alias s="git checkout staging"
alias staging="gco staging"
alias m="git checkout master"

# Quick pushes
alias wip="gap ':construction:'"
alias gcat="gap ':octocat:'"

# Ghostty
alias gho="ghostty"
alias gk="ghostty +list-keybinds"
alias gkk="v ~/dotfiles/docs/keybinds/ghostty.md"

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
alias fd="fastapi dev app/main.py"

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

# New
alias fsft="cd ~/Documents/Projects/playground/full-stack-fastapi-template"
alias db="cd ~/Documents/Projects/dance-buddy"
alias bil="eas build --platform ios --profile development --local"
alias yib="yarn build:ios:dev"
alias asdf="igni"
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
alias notes="cd ~/Documents"
alias notes="cd ~/Documents/Notes"
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
alias ld="lazydocker"
