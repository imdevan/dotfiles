# Example aliases
# Note format
# No spaces between name and string
# alias <name>=<string>

# Default editor
editor="atom"
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.bashrc && clear"
alias r="refresh"

<<<<<<< HEAD
=======
# Function to create new aliases
function new-alias() {
    echo "alias ${1}=\"${2}\"" >> $aliases_file
    refresh
}
alias na="new-alias"

# Bookmark position
function bookmark() {
  if [ -z "$1" ]; then
    echo 'No name provided'
  else
    echo "${green}alias ${1}=\"cd '$(pwd)'\" ${purple} created!"
    echo "alias ${1}=\"cd '$(pwd)'\"" >> $aliases_file
  fi
}
alias b="bookmark"

# Warning position
function warning() {
  if [ -z "$1" ]; then
    echo 'No name provided'
  else
    echo "${green}Warning: ${purple}${1}${green} created!"
    echo "echo ${1}" >> $aliases_file
  fi
}
alias w="warning"

>>>>>>> b23b7a1366b4c866c96d22237d354b4763a7da28

# Google docs
alias doc="python -mwebbrowser https://docs.google.com/create" # New google doc
alias docs="python -mwebbrowser http://docs.google.com"        # Main docs folder

# Git
alias conflicts="git diff --name-only --diff-filter=U"          # Does not push
alias no-edit="git commit --amend --no-edit"                    # Does not push
alias last="git log -1"                                         # Show last change
alias rebase="git fetch upstream && git rebase upstream/master" # Fetch and rebase
alias gcane!="git add -A && git commit --amend --no-edit && git push -f"

# System
alias off="sudo shutdown -h now"    # Shutdown
alias sleep="pmset sleepnow"        # Sleep

# Open dotfiles
alias dotfiles="${editor} $dotfile_dir"
alias dot="cd $dotfile_dir"
alias n="npm start"
alias p="cd ${work}"

# Created from bookmark or new-alias
alias a="atom ."
alias v="vim ."
alias grc="git rebase --continue"
alias nt="npm test"
alias gfu="git fetch upstream"
alias gcl="git clone"
alias m="git checkout master"
alias stash="git stash"
alias ni="npm install"
alias ga="git add ."
alias gcane="commit --amend --no-edit"
alias gcane="git commit --amend --no-edit"
alias clean="rm -rf node_modules && npm install"
alias liquid-docs="open https://shopify.github.io/liquid/tags/control-flow/"
alias diff="git diff"
alias p="cd ~/Documents/Projects/"
alias xyz="cd ~/Documents/Projects/xyz"
alias xyzb="cd ~/Documents/Projects/fisterra-backend"
alias ys="yarn start"
alias gco="git checkout"
alias gcof="git checkout --"
alias grem="git remote"
alias gp="git push"
alias gl="git log -1"
alias yb="yarn build"
alias ya="yarn add"
alias rf="rm -rf"
alias gr!="git reset --hard origin/master"
alias yys="yarn && yarn start"
alias yc="yarn clean"
alias halp="cat ~/dotfiles/aliases.sh"
alias e="cd /c/Users/huapa/Documents/Projects/evan-client"
alias ns="npm start"
alias es="cd /c/Users/huapa/Documents/Projects/evan-server"
alias ea="e && a"
alias conflicts="git diff --name-only --diff-filter=U"
alias yd="yarn dev"
alias gf="git fetch"
alias gcc="gcof ./src/config/axios.js"
alias gb="git branch"
alias staging="gco staging"
alias gac="git add . && git commit -m"
alias gs="git stash"
alias gr!="git reset --hard"
alias gfp="git fetch && git pull"
alias yr="yarn run"
alias sl="export ENVIRONMENT=windows&&sails lift"
alias yrw="export ENVIRONMENT=windows&&sails lift"
alias wip="gap ':construction:'"
alias ddac="cd /c/Users/huapa/Documents/Projects/dallas-design-and-code-slides"
alias mk="mkdir ${2} && cd ${2}"
alias ea="cd /c/Users/huapa/Documents/Projects/mk/electron-app"
alias gm="git merge -m ':octocat:'"
alias bsw="cd /c/Users/huapa/Documents/Projects/bisonstudio-v2.0"
alias rm!="rm -rf"
alias grs="git rebase origin/staging"
alias gd="git diff"
alias gcat="gap ":octocat:""
alias undo="git reset HEAD~1"
alias rs="cd /c/Users/huapa/Documents/Projects/React-Wordpress-Starter-Kit"
alias sparkles="git add . && git commit -m ':sparkles: ' && git push"
alias rws="cd /c/Users/huapa/Documents/Projects/React-Wordpress-Starter-Kit"
alias s="git checkout staging"
alias n="npm"
alias r!="rm -rf"
alias build="npm run build"
alias cpr="cp -rf"
alias crb="cordova run browser"
alias s="python -m http.server"
alias la="ls -a"
alias y="yarn"
alias cpa="cordova platform add"
alias cpab="cordova add platform browser"
alias cpab="cordova platform add browser"
alias c="cordova"
alias ba="build && android"
alias and="cd ./cordova && cordova run android && cd .."
alias ec="cd /c/Users/huapa/Documents/Projects/evan-client/cordova"
alias ba="yr cordova-build && and"
alias cra="cordova run android"
alias yrc="yarn run cordova-build"
alias ba="yrc && and"
alias copy="rm -rf ./cordova/www/* && cp -rf ./build/* ./cordova/www"
alias static="-p"
alias static="static -p 8000"
alias grs="grunt serve"
alias bs="build && cd build && static && .."
alias h="heroku"
alias hl="heroku logs --tail --app bison-studio-web"
alias co="code ./"
alias ycb="yarn run cordova-build"
alias cpr="cordova platforms rm"
alias cpa="cordova platforms add"
alias grs="git rebase origin/staging"
alias t="cd /c/Users/huapa/Documents/Projects/tilde"
alias yrd="yarn run dev"
alias sl="sails lift"
alias d="cd ~/dotfiles"
alias yrd="yarn run devan-start"
alias status="git status"
alias mvwww="rm -rf ./cordova/www/* && cp -rf ./build/* ./cordova/www"
alias w="rm -rf ./cordova/www/* && cp -rf ./build/* ./cordova/www"
alias yrw="ENVIRONMENT=development DATABASE_ENVIRONMENT=windows sails lift"
alias yrwk="KEEP_DB=true ENVIRONMENT=development DATABASE_ENVIRONMENT=windows sails lift"
alias waffle="start https://waffle.io/GooberLLC/evan-project"
alias sl="cd /c/Users/huapa/Documents/Projects/Speakeasy-landing"
alias rsl="cross-env KEEP_DB=true sails lift"
alias dotfiles="co ~/dotfiles"
alias ec="cd /c/Users/huapa/Documents/Projects/evan-client"
alias ec="cd /c/Users/huapa/Documents/Projects/evan-client/cordova"
alias e="cd /c/Users/Devan/Documents/Projects/evan-client"
alias rws="cd /c/Users/Devan/Documents/Projects/React-Wordpress-Starter-Kit"
alias rws="cd '/c/Users/Devan/Documents/Projects/React-Wordpress-Starter-Kit'"
alias rws="cd '/c/Users/Devan/Documents/Projects/React-Wordpress-Starter-Kit'"
alias es="cd '/c/Users/Devan/Documents/Projects/evan-server'"
alias gcg="git config --global"
alias cpaa="cordova platforms add android"
alias log="git log"
alias sl="KEEP_DB=true sails lift"
alias cs="yarn run cordova-staging-build"
alias cb="yarn run cordova-production-build"
alias rmr="rm -rf"
alias nrsr="npm run start-renderer-dev"
alias nrsm="npm run start-main-dev"
alias ni!="ni && npm i axios && npm rbuild-node-sass"
alias ysr="yarn run start-renderer-dev"
alias ysm="yarn run start-main-dev"
