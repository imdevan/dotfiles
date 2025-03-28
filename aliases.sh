# Example aliases
# Note format
# No spaces between name and string
# alias <name>=<string>

# Default editor
editor="code"
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.zshrc && clear"
# alias r="refresh"

# Google docs
alias doc="python -mwebbrowser https://docs.google.com/create" # New google doc
alias docs="python -mwebbrowser http://docs.google.com"        # Main docs folder

# Git
alias conflicts="git diff --name-only --diff-filter=U"          # Does not push
alias no-edit="git commit --amend --no-edit"                    # Does not push
alias last="git log -1"                                         # Show last change
alias rebase="git fetch upstream && git rebase upstream/master" # Fetch and rebase
alias gcane!="git add -A && git commit --amend --no-edit && git push -f"

# Editors
alias cu="cursor ."
alias c="code ."
alias v="vim ."

# Open dotfiles
alias dotfiles="${editor} $dotfile_dir"
alias d="dotfiles"
alias dots="~/dotfiles"
alias aliases="${editor} $aliases_file"
alias dot="cd $dotfile_dir"
alias p="cd ${work}"
alias halp="cat ~/dotfiles/aliases.sh"
alias a="aliases"

# Created from bookmark or new-alias
alias v="vim ."
alias grc="git rebase --continue"
alias nt="npm test"
alias gfu="git fetch upstream"
alias m="git checkout master"
alias stash="git stash"
alias ga="git add ."
alias gcane="commit --amend --no-edit"
alias gcane="git commit --amend --no-edit"
alias clean="rm -rf node_modules && yarn"
alias liquid-docs="open https://shopify.github.io/liquid/tags/control-flow/"
alias diff="git diff"
alias p="cd ~/Documents/Projects/"
alias gco="git checkout"
alias gcof="git checkout --"
alias grem="git remote"
alias gp="git push"
alias gl="git log -1"
alias yb="yarn build"
alias rf="rm -rf"
alias yys="yarn && yarn start"
alias yc="yarn clean"
alias e="cd ~/Documents/Projects/evan-client"
alias ns="npm start"
alias es="cd ~/Documents/Projects/evan-server"
alias ea="e && a"
alias conflicts="git diff --name-only --diff-filter=U"
alias yd="yarn dev"
alias gf="git fetch"
alias gcc="gcof ./src/config/axios.js"
alias gb="git branch"
alias staging="gco staging"
alias gac="git add . && git commit -m"
alias gs="git stash"
alias gfp="git fetch && git pull"
alias yr="yarn run"
alias yrw="export ENVIRONMENT=windows&&sails lift"
alias wip="gap ':construction:'"
alias ddac="cd ~/Documents/Projects/dallas-design-and-code-slides"
alias mk="mkdir ${2} && cd ${2}"
alias ea="cd ~/Documents/Projects/mk/electron-app"
alias gm="git merge -m ':octocat:'"
alias bsw="cd ~/Documents/Projects/bisonstudio-v2.0"
alias rm!="rm -rf"
alias grs="git rebase origin/staging"
alias gd="git diff"
alias gcat="gap ':octocat:'"
alias undo="git reset HEAD~1"
alias rs="cd ~/Documents/Projects/React-Wordpress-Starter-Kit"
alias sparkles="git add . && git commit -m ':sparkles: ' && git push"
alias s="git checkout staging"
alias r!="rm -rf"
alias build="yarn build"
alias cpr="cp -rf"
alias s="python -m http.server"
alias la="ls -a"
alias y="yarn"
alias yrd="yarn run dev"
alias status="git status"
alias rmr="rm -rf"
alias ys="yarn start"
alias gcm="git commit -m"
alias yd="yarn dev"
alias yb="yarn build"
alias ya="yarn add"
alias t="touch"
alias yt="yarn test"
alias yad="yarn add --dev"
alias nd="npm run dev"
alias nb="npm run build"
alias grm="git rebase main"
alias nw="npm run web"
alias jc="npx jest --coverage"
alias nee="npm run test:e2e"
alias yt="yarn test"
alias yw="yarn web"
alias w="yarn web"
alias e2="yarn test:e2e"
alias xx="cd /Users/devin/Documents/Projects/expo-expo"
alias gr="git checkout ."
alias clone="git clone"
alias yl="yarn lint"
alias pp="cd /Users/devin/Documents/Projects/portfolio\ v5"
alias con="cd /Users/devin/Documents/Projects/conmigo"
alias ynb="yarn next:build"
alias yn="yarn next"
alias ap="cd /Users/devin/Documents/Projects/conmigo2/packages/app"
alias aapi="cd /Users/devin/Documents/Projects/conmigo2/packages/api"
alias adb="cd /Users/devin/Documents/Projects/conmigo2/packages/db"
alias yg="yarn db:generate"
alias yp="yarn db:push"
