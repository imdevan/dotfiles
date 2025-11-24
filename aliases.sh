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
alias restart="sudo shutdown -r now"
alias sdown="sudo shutdown -h now"
alias dot="cd $dotfile_dir"

# Terminal Navigation
alias la="ls -a" # List all in directory
alias lsa="ls -a"
alias o="open ./"  # Open - in finder
alias cpr="cp -rf" # Copy recursive
alias cf="cp -rf"
alias rf="rm -rf" # Remove recursive
alias t="touch"   # Make file
alias ex="exit"   # Exit terminal
alias bb="cd -"   # Go back to last dirctory

# Home Brew
alias bri="brew install"
alias bric="brew install --cask"
alias brui="brew uninstall"
alias brs="brew services"
alias brup="brew upgrade"

# Sketchybar
alias rs="brew services restart sketchybar"
alias sr="brew services restart sketchybar"
alias sst="brew services stop sketchybar"
alias ss="brew services stop sketchybar"
alias ss="brew services start sketchybar"

# Bun
alias bi="bun install"
alias bs="bun start"
alias bd="bun dev"
alias bb="bun build"
alias bu="bun uninstall"
alias bgen="bun generate:client"
alias bbis="bun build:ios:sim"
alias bbas="bun build:android:sim"
alias brd="bun run dev"
alias bsc="bs --clear"
alias clean="rf node_modules && bun install"

# Expo
alias eab="eas build --platform ios --profile development --local"
alias ze="z ./app/expo"
alias bil="eas build --platform ios --profile development --local"

# Docker
alias dcd="docker compose down"
alias dcu="docker compose up"
alias dcw="docker compose watch"

alias cs="colima start"
alias csd="cs && dcw"

alias ved="deactivate"
alias vdcw="ve && dcw"
alias vcd="ve && cs && dcw"
alias dlb="docker logs backend-backend-1"
alias vcd="ve && cs && dcw"
alias count="v /Users/devy/Documents/Projects/playground/scripts/userStylesCount.js"
alias cgen="scripts/generate-client.sh"

# Code editors
alias co="code ."
alias c="cursor ."
alias v="nvim"
alias k="kiro ./"

# Bookmarks
alias d="dotfiles"
alias p="cd ~/Documents/Projects/"
alias play="cd ~/Documents/Projects/playground"

# Open in Vim
alias hk="v ~/dotfiles/docs/keybinds/hotkeys.md"
alias vpf="v ~/dotfiles/docs/possible-future.md"
alias vz="v ~/dotfiles/config/stow/zsh/.zshrc"
alias va="v ~/dotfiles/aliases.sh"
alias vc="v ~/Library/Application\ Support/com.mitchellh.ghostty/config"
alias aero="v ~/.aerospace.toml"
alias vs="v ~/dotfiles/setup.md"
alias vpf="v ~/dotfiles/possible-future.md"
alias vd="v ~/dotfiles"
alias vt="v ~/dotfiles/config/stow/tmux/.tmux.conf"
alias vs="v ~/dotfiles/config/stow/sketchybar/.config/sketchybar"
alias vn="v ~/dotfiles/config/stow/nvim/.config/nvim"
alias vb="v ~/dotfiles/config/stow/borders/.config/borders/bordersrc"
alias val="v ~/dotfiles/config/stow/alacritty/.alacritty.toml"
# alias vf="" now handled by function_utils/vim_function
alias fv="fzf --bind 'enter:become(nvim {})'" # fzf file search then open in nvim
alias vq="v ~/dotfiles/config/stow/qutebrowser/.qutebrowser/config.py"
alias vg="v /Users/devy/dotfiles/functions/github.sh"
alias vto="v /Users/devy/Documents/Projects/project-ignite-go-fast/todo.md"
alias vnk="v ~/dotfiles/config/stow/nvim/.config/nvim/lua/config/keymaps.lua"
alias vk="v ~/dotfiles/config/stow/kitty/.config/kitty/kitty.conf"
alias vw="v ~/dotfiles/config/stow/wezterm/.wezterm.lua"
alias vsk="v ~/dotfiles/config/stow/skhd/.config/skhd/skhdrc"

# Git
# Overhead
alias lg="lazygit"
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
alias gca="git commit --amend"
alias fp="git push --set-upstream origin master" # First push
alias gro="git remote add origin"
alias ma="gco main"
alias gcob="gco -b"
# TODO: write pr as a dynamic function
alias pr="open https://github.com/imdevan/react-native-dropdown-picker/compare/main...imdevan:react-native-dropdown-picker:main"

# Branch shortcuts
alias s="git checkout staging"
alias staging="gco staging"
# alias m="git checkout master"
alias mast="gco master"

# Quick pushes
alias wip="gap ':construction:'"
alias gcat="gap ':octocat:'"

# NPM
alias nt="npm test"
alias ns="npm start"
alias nee="npm run test:e2e"
alias nu="npm uninstall"
alias nrd="npm run dev"
alias ni="npm install"
alias naf="npm audit fix"
alias jc="npx jest --coverage"
alias nd="npm run dev"
alias nb="npm run build"
alias nw="npm run web"
alias nrl="npm run lint"
alias ninrw="ni && nrw"
alias nid="npm i --save-dev"
alias nrc="npm run clean"
alias nrp="npm run prettier"
alias nrw="npm run web"
alias nis="npm install -S"
# Particularly lazy npm scripts
alias nnrw="nclean && nrw"
alias nclean="rf node_modules && rm package-lock.json && ni"

# PNPM
alias pns="pnpm start"
alias pnd="pnpm dev"
alias pni="pnpm install"
alias pnn="pnpm"
alias pnb="pnpm build"
alias pnr="pnpm run"

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
alias clean="rm -rf node_modules && yarn"

# Google docs
alias doc="python3 -mwebbrowser https://docs.google.com/create" # New google doc
alias docs="python3 -mwebbrowser http://docs.google.com"        # Main docs folder

# Python
alias create-ve="python -m venv .venv"
alias cve="create-ve"
alias ve="source .venv/bin/activate"
alias py="python3"
alias pi="pip install -r requirements.txt"
alias py="python3.11"
alias pym="py monitor.py"
alias cve="py -m venv .venv"
alias pim="pi; py"
alias pim="pi; pym"
alias pym="py src/monitor.py"
alias jcs="cd ~/Documents/Projects/playground/just-checking-scripts"
alias pi="pip install -r requirements.txt"
alias py="python3.11"
alias pym="py monitor.py"
alias cve="py -m venv .venv"
alias pim="pi; pym"
alias uvs="uv sync"
alias ved="deactivate"
alias ba="bun add"

# Simple http.server
alias s="python3 -m http.server"

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
alias ved="deactivate"
alias dlb="docker logs backend-backend-1"
alias cols="colima start"
# Particularly lazy python + docker scripts
alias vdcw="ve && dcw"
alias vcd="ve && cs && dcw"
alias vcd="ve && cs && dcw"
alias mdr="make docker.run"

# Grep
alias gre="grep -rl"
alias rge='rg --files | sk --preview="bat {} --color=always" --bind "enter:execute(nvim {})"'

# Tmux
alias t="tmux"
alias tks="tmux kill-server"
alias ta="tmux attach -t"
alias tms="tmux source-file ~/.tmux.conf"
# alias tmr="tmux rename-window -t"
alias tls="tmux list-sessions"
alias tt="tmux attach -t 0" # add after ta alias
alias tka="tmux kill-session -a"
alias tkse="tmux kill-session -t"
alias t4="ta 420"

# Qutebrowser
alias qb="qutebrowser"
alias lhqb="qb localhost:3000"
alias q1="qb localhost:8081"

# Create app scripts
alias turb="npx create-turbo@latest"
alias igni="npx ignite-cli@latest new "
alias ct3="bun create t3-app@latest"

# fast API scripts
alias cgen="scripts/generate-client.sh"
alias vdc="bve && dcw"
alias vdc="z backend && ve && dcw"
alias zb="z ./app/backend"
alias bve="z backend && ve"
alias bve="z backend && ve && .."

# golang scripts
alias gr="go run main.go"
alias gmt="go mod tidy"

# Misc.
alias ge="gemini"
alias pt="python google_photo_transfer.py"
alias ppt="rf output2 && pt -d ./tests2 -o ./output2"
alias count="v /Users/devy/Documents/Projects/playground/scripts/userStylesCount.js"
alias gcrndp="gcl https://github.com/imdevan/react-native-dropdown-picker.git"
alias au="grem add upstream https://github.com/imdevan/react-native-dropdown-picker.git"
alias asdf="cowsay 'hang in there!'" # use incase of frustration
alias weather="curl http://wttr.in/Seattle"

# Bookmarks
alias fsft="cd ~/Documents/Projects/playground/full-stack-fastapi-template"
alias db="cd ~/Documents/Projects/dance-buddy"
alias nvim-config="cd ~/.config/nvim"
alias np="cd ~/.config/nvim/lua"
alias np="cd ~/.config/nvim/lua/plugins"
alias play="cd /Users/devy/Documents/Projects/playground"
alias portfolio="cd ~/Documents/Projects/portfolio"
alias pp="cd ~/Documents/Projects/portfolio"
alias go-tests="cd ~/Documents/Projects/playground/go-tests"
alias exgo="cd ~/Documents/Projects/playground/exgo"
alias pyt="cd ~/Documents/Projects/playground/python-tests"
alias ief2="cd ~/Documents/Projects/ignite-expo-fast-2"
alias pief="cd ~/Documents/Projects/project-ignite-go-fast"
alias ief="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast"
alias iefe="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/expo"
alias iefb="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/backend"
alias eief="cd ~/Documents/Projects/project-ignite-go-fast/ignite-expo-fast/expo"
alias devy="cd ~/Documents/Projects/project-ignite-go-fast/devy"
alias de="cd ~/Documents/Projects/project-ignite-go-fast/devy"
alias pypo="cd ~/Documents/Projects/project-ignite-go-fast/pypo"
alias epy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/expo"
alias bpy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/backend"
alias epy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/app/expo"
alias bpy="cd ~/Documents/Projects/project-ignite-go-fast/pypo/app/backend"
alias dance="cd ~/Documents/Projects/dance-partner"
alias dpa="cd ~/Documents/Projects/dance-partner/dance-partner-app"
alias bdpa="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/backend"
alias edp="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/expo"
alias bdp="cd ~/Documents/Projects/dance-partner/dance-partner-app/app/backend"
alias rndp="cd ~/Documents/Projects/playground/react-native-dropdown-picker"
alias rndp="cd ~/Documents/Projects/playground/react-native-dropdown/react-native-dropdown-picker"
alias rndp2="cd ~/Documents/Projects/playground/react-native-dropdown/rndp2"
alias rndp3="cd ~/Documents/Projects/playground/react-native-dropdown/rndp3"
alias rndpe="cd ~/Documents/Projects/playground/react-native-dropdown/react-native-dropdown-picker/examples"
alias sketch="cd ~/dotfiles/config/stow/sketchybar/.config/sketchybar"
alias pres="cd ~/Documents/Projects/playground/presentation/dotfiles-for-web-developers-presentaiton"

# Jankyborder
# :open https://github.com/FelixKratz/JankyBorders/wiki/Man-Page
alias jbr="brew services stop borders &&  brew services start borders"
alias jbs="brew services start borders"
alias jbo="brew services stop borders"

# New
alias wea="weather"
alias qblh="qb http://localhost:8081"
alias pdot="cd ~/Documents/Projects/playground/presentation/dotfiles-for-web-developers-presentaiton"
alias skr="skhd --restart-services"
alias sks="skhd --stop-service"
alias skr="skhd --restart-service"
alias rskr="r  /tmp/skhd_devy.log && skr &&  v  /tmp/skhd_devy.log"
alias skst="skhd --start-service"
