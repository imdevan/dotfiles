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

# Function to create new aliases
function new-alias() {
    echo "alias ${1}=\"${2}\"" >> $aliases_file
    refresh
}
alias na="new-alias"

# Bookmark position
function bookmark() {
    echo "${green}alias ${1}=\"$(pwd)\" ${purple} created!"
    echo "alias ${1}=\"cd $(pwd)\"" >> $aliases_file
    refresh
}
alias b="bookmark"


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
