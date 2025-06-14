source $dotfile_dir/.gitVars
DEFAULT_BRANCH='development'
DEFAULT_ORIGIN='origin'

# Helper function to get the name of a repo
get_repo_name() {
  local url="$1"
  local repo_name

  # Remove .git suffix if present
  url="${url%.git}"

  # Extract the part after the last slash or colon
  repo_name="${url##*/}"
  repo_name="${repo_name##*:}"

  echo "$repo_name"
}

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
    git remote prune upstream
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
  local ORIGIN=${GIT_SSH_URL}/${PWD##*/}.git
  git init
  git add .
  git commit -m ':tada: first commit!'
  git remote add origin ${ORIGIN}
  git push -u origin master
  echo ${green}New Repo Created at $ORIGIN${reset}
}
alias gn='new-repo'

function git-reset() {
  git fetch
  local _BRANCH=${DEFAULT_BRANCH}
  local _ORIGIN=${DEFAULT_ORIGIN}

  if [ -d "$1"]; then
    _BRANCH=$1
    if [ -d "$2"]; then
      _ORIGIN=$2
    fi
  fi

  echo `git reset --hard ${DEFAULT_ORIGIN}/${DEFAULT_BRANCH}`
  git reset --hard ${DEFAULT_ORIGIN}/${DEFAULT_BRANCH}
}
alias gr!="git-reset"

function git-clone() {
  one-arg-required "$@" || return 1

  # TODO: accommodate for ssh
  # Clone the repo
  # if [[ $1 == *"git@"* ]]; then
  #   echo $(git clone ${1})
  #   git clone ${1}
  # else
  #   echo $(git clone ${GIT_SSH_URL}${1}.git)
  #   git clone ${GIT_SSH_URL}${1}.git
  # fi

  # Clone the repo
  git clone "$@"

  # Navigate to the directory
  local repo_name=""

  # If only one argument is passed
  if [ "$#" -eq 1 ]; then
    repo_name=$(get_repo_name ${1})
  # Otherwise use the second argument
  elif [ "$#" -eq 2 ]; then
    repo_name=$(get_repo_name ${2})
  fi

  # Navigate to repo
  cd $repo_name
}
alias gcl="git-clone"
