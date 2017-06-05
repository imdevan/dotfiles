
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
function force-delete-branches() {
  for i in "$@"; do git branch -D $i; done
}
alias gbd="delete-branches"
alias gbd!="force-delete-branches"
