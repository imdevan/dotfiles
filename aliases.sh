# Example aliases
# Note format
# No spaces between name and string
# alias <name>=<string>

# Default editor
editor="atom"
projects="~/Documents/projects/"
aliases_file=$dotfile_dir/aliases.sh

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="source ~/.zshrc && clear"
alias r="refresh"

# Function to create new aliases
function new-alias() {
  echo "# Created from new-alias" >> $aliases_file
  echo "alias ${1}=\"${2}\"" >> $aliases_file
  echo "${green}alias ${1}=\"${2}\" ${purple} created!"
  refresh
}
alias na="new-alias"

# Bookmark position
function bookmark() {
  echo "# Created from bookmark" >> $aliases_file
  echo "alias ${1}=\"$(pwd)\"" >> $aliases_file
  echo "${green}alias ${1}=\"$(pwd)\" ${purple} created!"
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
alias reset="git fetch upstream && git reset --hard upstream/master" # Fetch and rebase
alias gcane="git commit --amend --no-edit"
alias gcane!="git add -A && git commit --amend --no-edit && git push -f"
alias delete="git for-each-ref --format=\"%(refname:short)\" refs/heads/$1\* | xargs git branch -D"

# System
alias off="sudo shutdown -h now"    # Shutdown
alias sleep="pmset sleepnow"        # Sleep

# Open dotfiles
alias dotfiles="${editor} $dotfile_dir"
alias n="npm start"
alias p="cd ${projects}"

alias serve="python -m SimpleHTTPServer"
# Created from bookmark or new-alias
alias i="cd ~/Documents/projects/imdevan.github.io"
alias a="atom ."
alias v="vim ."
alias grc="git rebase --continue"
alias kill="killall node"
alias nt="npm test"
alias gfu="git fetch upstream"
alias m="git checkout master"
alias stash="git stash"
alias ni="npm install"
alias ga="git add ."
alias clean="rm -rf node_modules && npm install"
alias liquid-docs="open https://shopify.github.io/liquid/tags/control-flow/"
alias diff="git diff"
alias rf="rm -rf"
alias gs="git stash"
alias gb="git branch"
alias d="gulp deploy"
alias dep="gulp deploy"
alias gd="git branch -D"
alias k="killall node"
alias doot="cd $dotfile_dir"
alias grem="git remote"
alias sf="git add . && git commit -m 👋  && git stash"
alias gsf="git add . && git commit -m 👋  && git stash"
alias nis="npm i --save"

alias nrd="npm run dev"
alias babun="cd /media/devan/OS/Users/huapa/.babun/cygwin/home"
