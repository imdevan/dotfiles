# Calls git add, git commit, and git push
# Takes commit message
function referesh_facebook_link() {
    curl `https://developers.facebook.com/tools/lint/?url=${1}&format=json`
}
alias rfl="referesh_facebook_link"

