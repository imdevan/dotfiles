source $dotfile_dir/.gitVars
DEFAULT_BRANCH='staging'
DEFAULT_ORIGIN='origin'

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push() {
    git add . &&
    git commit -m "${@}" &&
    git push
}
alias gap="git-add-push"

# Pulls down pull request from upstream and creates branch
function pull-request() {
    git fetch upstream pull/${1}/head:pr-${1} &&
    git checkout pr-${1} &&
    git remote prune upstream;
}
alias pr="pull-request"

function delete-branches() {
  for i in "$@"; do git branch -d $i; done
}
alias gbd="delete-branches"

function force-delete-branches() {
  for i in "$@"; do git branch -D $i; done
}
alias gbd!="force-delete-branches"

function new-repo() {
  ORIGIN=${GIT_SSH_URL}/${PWD##*/}.git
  git init
  git add .
  git commit -m ':tada: first commit!'
  git remote add origin ${ORIGIN}
  git push -u origin master
  echo ${green}New Repo Created at $ORIGIN${reset}
}
alias gn='new-repo'

function git-reset(){
  git fetch
  _BRANCH=${DEFAULT_BRANCH}
  _ORIGIN=${DEFAULT_ORIGIN}
  
  if [ -d "$1"]; then 
      _BRANCH=$1
      if [ -d "$2"]; then 
        _ORIGIN=$2
      fi
  fi

  echo `git reset --hard ${_ORIGIN}/${_BRANCH}`
  git reset --hard ${_ORIGIN}/${_BRANCH}
}
alias gr!="git-reset"

function git-clone(){
  echo `git clone ${GIT_SSH_URL}${1}.git`
  git clone ${GIT_SSH_URL}${1}.git
}

alias gcl="git-clone"