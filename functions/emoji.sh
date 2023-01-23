# Get emoji
function emoji() {
    echo ${emoji[${@}]} |tr '\n' ' ' | pbcopy
    echo $emoji[${@}] copied! 
}
alias e='emoji'