# Example aliases
# Note format
# No spaces between name and string
# alias <name>=<string>

# Default editor
editor="code"
projects="~/Documents/Projects/"
aliases_file=$dotfile_dir/aliases.sh
alias a="code ${aliases_file}"

# Restarts shell
# Call after making changes w/o having to restart
alias refresh="clear && exec zsh"
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
    echo "alias ${1}=\"$(pwd)\"" >> $aliases_file
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
alias doot="cd $dotfile_dir"
alias dotfiles="${editor} $dotfile_dir"
alias n="npm start"
alias p="cd ${projects}"

# Created from bookmark or new-alias
alias i="/Users/devanhuapaya/Documents/projects/imdevan.github.io"
alias paddle="/Users/devanhuapaya/Documents/projects/project-whitewater/paddle"
alias c="code ."
alias v="vim ."
alias grc="git rebase --continue"
alias kill="killall node"
alias nt="npm test"
alias gfu="git fetch upstream"
alias m="git checkout master"
alias stash="git stash"
alias ni="npm install"
alias ga="git add ."
alias gcane="commit --amend --no-edit"
alias gcane="git commit --amend --no-edit"
alias clean="rm -rf node_modules && npm install"
alias liquid-docs="open https://shopify.github.io/liquid/tags/control-flow/"
alias diff="git diff"
alias gfp="git fetch && git pull"
alias nbp="/Users/devanhuapaya/Documents/Projects/Native-BioData/native-biodata-portal"
alias yd="yarn dev"
alias yps="yarn prisma:studio"
alias ypr="yarn prisma:migrate:reset"
alias ypr="yarn prisma:migrate:reset"
alias ypg="yarn prisma generate"
alias ypm="yarn prisma:migrate:dev"
alias grd="git rebase development"
alias gcm="git commit -m"
alias dev="gco development"
alias yb="yarn build"
alias isa="acs"
alias es="e sparkles"
