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
alias gitdot="${editor} $dotfile_dir/functions/github.sh"
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
alias ypsp="dotenv -e .env.production.local -- yarn prisma:studio"
alias ypr="yarn prisma:migrate:reset"
alias yprp="dotenv -e .env.production.local -- yarn prisma:migrate:reset"
alias ypg="yarn prisma generate"
alias ypm="yarn prisma:migrate:dev"
alias grd="git rebase development"
alias gcm="git commit -m"
alias gcmv="git commit --no-verify -m"
alias yb="yarn build"
alias isa="acs"
alias es="e sparkles"
alias the-works="yarn && ypg && ypr"
alias dev="gco development && gfp"
alias devo="gco develop && gfp"
alias tw="the-works"
alias grd="git rebase development"
alias nbpvd="/Users/devanhuapaya/Documents/Projects/Native-BioData/native-biodata-portal-vercel-deployment"
alias grud="git fetch upstream && git rebase upstream/development && git push"
alias prod="dotenv -e .env.production.local -- "
alias gcob="gco -b"
alias bt="yarn test:unit --bail && yarn lint && yarn build"
alias cpbranch="git branch --show-current | tr -d '\n' | pbcopy"
alias ypf="yarn prisma format"
alias spike="/Users/devanhuapaya/Documents/Projects/spike"
alias yt="yarn test:unit --bail"
alias ypcp="yarn plop component partial"
alias yte="yarn test:e2e"
alias rnb="/Users/devanhuapaya/Documents/Projects/react-nextjs-boilerplate"
alias ypcc="yarn plop component common"
alias seed="yarn prisma db seed"
alias gps="gpsup"
alias gconf="code /Users/devanhuapaya/dotfiles/functions/github.sh"
alias add-type="yarn add --dev @types/${@}"
alias grb="git rebase origin development"
alias grb="git rebase development"
alias yr="yarn remove"
alias ypmr="yarn prisma:migrate:reset"
alias ydb="yarn docker:db"
alias yad="yarn add --dev"
alias mgh="/Users/devanhuapaya/Documents/Projects/MGH"
alias gpa="/Users/devanhuapaya/Documents/Projects/MGH/Game-Pack-App/Game_Pack\ Unity\ App/DigitalCognition"
alias gs="git stash"
alias ns="npm start"
alias nis="npm i -s"
alias mghs="/Users/devanhuapaya/Documents/Projects/MGH/GamePack_DBsync/mgh-server"
alias mghs="/Users/devanhuapaya/Documents/Projects/MGH/GamePack_DBsync/mgh-server"
alias mghdbs="/Users/devanhuapaya/Documents/Projects/MGH/GamePack_DBsync"
alias dc="docker-compose"
alias dcd="docker-compose down -v"
alias dcu=""
alias dcu="docker-compose up -v"
alias dcu="docker-compose up"
alias dcdu="docker-compose down -v && docker-compose up"
alias nrs="npm run serve"
alias gip="/Users/devanhuapaya/Documents/Projects/genui-intranet-profiles"
alias nb="npm run build"
alias test="/Users/devanhuapaya/Documents/Projects/genui-intranet-profiles"
