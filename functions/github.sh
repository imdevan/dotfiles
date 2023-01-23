github_account='imdevan'

function git-add-commit() {
    git add . &&
    git commit --no-verify -m "${@}" &&
}
alias gac='git-add-commit'

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push() {
    git add . &&
    git commit -m "${@}" &&
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gap="git-add-push"

# Calls git add, git commit, and git push, no verify
# Takes commit message
function git-add-push-no-verify() {
    git add . &&
    git commit --no-verify -m "${@}" &&
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gapv="git-add-push-no-verify"

# Shortcut to push and set current branch as upstream
function git-push-push() {
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gpp="git-push-push"

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-sparkles() {
    git-add-push "✨ ${@}" 
}
alias gas="git-add-push-with-sparkles"

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-sparkles-no-verify() {
    git add . &&
    git commit --no-verify -m "✨ ${@}" &&
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gasv="git-add-push-with-sparkles-no-verify"
# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-work-in-progress() {
    git-add-push "🚧  ${@}" 
}
alias gaw="git-add-push-with-work-in-progress"

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-work-in-progress-no-verify() {
    git add . &&
    git commit --no-verify -m "🚧  ${@}" &&
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gawv="git-add-push-with-work-in-progress-no-verify"

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-refactor() {
    git-add-push "♻️ ${@}" 
}

alias gar="git-add-push-with-refactor"

# Calls git add, git commit, and git push
# Takes commit message
function git-add-push-with-fix() {
    git-add-push "🚨 ${@}" 
}
alias gaf="git-add-push-with-fix"

# Calls git push and sets the upstream
# Takes commit message
function git-push-upstream() {
    git push --set-upstream origin $(git branch --show-current | tr -d '\n')
}
alias gpu="git-push-upstream"

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
