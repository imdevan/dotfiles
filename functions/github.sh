github_account='imdevan'

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

# Pulls down pull request from upstream and creates branch
function clone() {
  repo=$1
  if [ -z "$2" ]; then
      org=$2
  else
    org=$github_account
  fi

  git clone git@github.com:${org}/${repo}.git
}
alias gcl="clone"
