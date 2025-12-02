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
  one_arg_required "$@" || return 1

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

  # Process the repo URL (first argument)
  local repo_url="${1}"
  
  # Strip query parameters and hash fragments from the URL
  repo_url="${repo_url%%#*}"  # Remove everything from # onwards
  repo_url="${repo_url%%\?*}"  # Remove everything from ? onwards
  
  # If repo URL starts with "https://github.com" and doesn't end in ".git", add ".git"
  if [[ "$repo_url" == https://github.com* ]] && [[ "$repo_url" != *.git ]]; then
    repo_url="${repo_url}.git"
  fi

  # Navigate to the directory
  local repo_name=""

  # If only one argument is passed, use the URL and extract repo name from it
  if [ "$#" -eq 1 ]; then
    git clone "$repo_url"
    repo_name=$(get_repo_name "$repo_url")
  # Otherwise use the first arg as repo URL and second arg as directory name
  elif [ "$#" -eq 2 ]; then
    git clone "$repo_url" "${2}"
    repo_name="${2}"
  fi

  # Navigate to repo
  cd $repo_name
}
alias gcl="git_clone"

# Shows changed files (name only)
function git_changes() {
  # Print out changes in a nice format
  local changes=$(git ls-files -m)
  local additions=$(git ls-files -o --exclude-standard)
  
  if [ -z "$changes" ] && [ -z "$additions" ]; then
    echo "\n${green}No changes${reset} 🥳\n"
    return 0
  fi

  if [ -n "$changes" ]; then
    echo ""
    echo "Changes:"
    echo "--------------------------------"
    echo "${yellow}$changes${reset}"
    echo "--------------------------------"
  fi

  if [ -n "$additions" ]; then
    echo ""
    echo "Untracked:"
    echo "--------------------------------"
    echo "${green}$additions${reset}"
    echo "--------------------------------"
  fi
}
alias gch="git_changes"
alias changes="git_changes"

# function to lazily add commit and push 
function lazy_push() {
  # Check if argument is provided
  if [ -z "$1" ]; then
    echo "Usage: lazy_push <file_path>"
    echo "Example: lazy_push 'config/stow/aerospace/*'"
    return 1
  fi

  # Generate commit message based on file path
  local file_path="$1"
  local commit_message=""
  local fomatted_commit_message="" 

  # Remove trailing slash if present
  file_path=$(echo "$file_path" | sed 's/\/$//')
  # echo 'file path after removing trailing slash: ' $file_path
  # Remove trailing asterisks if present
  file_path=$(echo "$file_path" | sed 's/\*$//')
  # echo 'file path after removing asterisks: ' $file_path
  
  # Split the path into parts using parameter expansion
  path_parts=(${(s:/:)file_path})
  
  # echo 'path parts: ' ${path_parts[@]}
  
  # Get the last part (file or folder name)
  local last_part="${path_parts[-1]}"
  # echo 'last part: ' $last_part
  
  # Get the first part (first folder)
  local first_part="${path_parts[1]}"
  # echo 'first part: ' $first_part
  
  # Remove file extension from last part if it's a file
  last_part=$(echo "$last_part" | sed 's/\.[^.]*$//')
  # echo 'last part after removing file extension: ' $last_part
  
  # Generate commit message
  if [[ ${#path_parts[@]} -eq 1 ]]; then
    # Single file/folder
    commit_message="${last_part}"
  else
    # Multiple parts: "{last_part} {first_part}"
    commit_message="${last_part} ${first_part}"
  fi

  # Check if second argument is provided and modify commit message accordingly
  if [[ -n "$2" && ("$2" == "a" || "$2" == "add") ]]; then
    fomatted_commit_message="${blue}add ${reset}${commit_message#update }"
    commit_message="add ${commit_message#update }"
  elif [[ -n "$2" && ("$2" == "aa") ]]; then
    fomatted_commit_message="${blue}add ${reset}${commit_message#update }"
    commit_message="add ${commit_message#update }"

    # Remove trailing 's' from commit message if present
    fomatted_commit_message=$(echo "$fomatted_commit_message" | sed 's/s$//')
    commit_message=$(echo "$commit_message" | sed 's/s$//')
  elif [[ -n "$2" && ("$2" == "s" || "$2" == "sub" || "$2" == "subtract") ]]; then
    fomatted_commit_message="${red}remove ${reset}${commit_message#update }"
    commit_message="remove ${commit_message#update }"
  elif [[ -n "$2" ]]; then
    fomatted_commit_message="$2"
    commit_message="$2"
  else
    fomatted_commit_message="${yellow} update ${reset} ${commit_message#update }"
    commit_message="update ${commit_message#update }"
  fi


  # todo: probably a good candidate for go commander style cli tool to add flags  
  #  such that if -s or similar is passed it will remove the s from the "last_part" 
  #  before generating a a message

  # Add, commit, and push
  git add $1 &&
  git commit -m $commit_message &&
  git push 

  # Print out commit message
  echo " \n"
  echo "${green}Lazy pushed 🎉${reset}"
  echo "${orange}commit message: ${reset}${fomatted_commit_message}${reset}"
  echo " \n"
}
alias lgap="lazy_push"

# Function: lcs
# Description: Super lazy git management for stow files
# Usage: lcs [arguments]
# Alias: l
function lazy_push_config_stow() {
    lazy_push config/stow/$1
}
# alias lcs="lazy_push_config_stow"
alias clgap="lazy_push_config_stow"

# Function: push current branch
function push_current_branch() {
  # Ensure we're in a git repo
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git repository" >&2
    return 1
  fi

  # Get the current branch name
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)

  # Ensure we actually got a branch name
  if [ -z "$branch" ]; then
    echo "Unable to determine branch name" >&2
    return 1
  fi

  echo "Pushing branch '$branch' to origin..."
  git push --set-upstream origin "$branch"
}
alias pcb="push_current_branch"

# Function: checkout_and_set_upstream
# Description: checkout branch and push to upstream branch with the same name
# Usage: checkout_and_set_upstream feature-branch-name
function checkout_and_set_upstream () {
  git checkout -b "$1"

  git push --set-upstream upstream "$1"
}

alias casu="checkout_and_set_upstream"

