# source $dotfile_dir/.gitVars
DEFAULT_BRANCH='development'
DEFAULT_ORIGIN='origin'

# Helper function to get the name of a repo
get_repo_name() {
  one_arg_required "$@" || return 1

  # Get the URL 
  local url="$1"
  local repo_name

  # Remove .git suffix if present
  url="${url%.git}"

  # Extract the part after the last slash or colon
  repo_name="${url##*/}"
  repo_name="${repo_name##*:}"

  echo "$repo_name"
}

# Calls git add, and git commit
function git_add_commit() {
  one_arg_required "$@" || return 1
  git add ${2:-"."} &&
  git commit -m "${1}"
}
alias gac="git_add_commit"

# Calls git add, git commit, and git push
# Takes commit message
function git_add_push() {
  git_add_commit "$@" &&
  git push
}
alias gap="git_add_push"

# Pulls down pull request from upstream and creates branch
function pull_request() {
  git fetch upstream pull/${1}/head:pr-${1} &&
    git checkout pr-${1} &&
    git remote prune upstream
}
alias pr="pull_request"

function delete_branches() {
  for i in "$@"; do git branch -d $i; done
}
alias gbd="delete_branches"

function force_delete_branches() {
  for i in "$@"; do git branch -D $i; done
}
alias gbd!="force_delete_branches"

function new_repo() {
  local ORIGIN=${GIT_SSH_URL}/${PWD##*/}.git
  git init
  git add .
  git commit -m ':tada: first commit!'
  git remote add origin ${ORIGIN}
  git push -u origin master
  echo ${green}New Repo Created at $ORIGIN${reset}
}
alias gn='new_repo'

function git_reset() {
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
alias gr!="git_reset"

function git_clone() {
  one_arg_required "$@" || return 1

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
alias gcl="git_clone"

# Shows changed files (name only)
function git_changes() {
  # Print out changes in a nice format
  echo "Changes:"
  echo "--------------------------------"
  echo "${orange}$(git diff --name-only)${reset}"
  echo "--------------------------------"
}
alias gch="git_changes"
alias changes="git_changes"