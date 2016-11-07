
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

# Clone repository
function clone() {
    # TODO if $1 contains.git -> git clone $1
    # TODO if $1 contains http -> git clone $1.git
    if [ $# -gt 1 ]; then
            git clone https://github.com/$2/$1.git
    else
        git clone https://github.com/imdevan/$1.git
    fi
}
