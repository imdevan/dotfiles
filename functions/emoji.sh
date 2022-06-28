# Get emoji
function e() {
    echo ${emoji[${@}]} |tr '\n' ' ' | pbcopy
    echo $emoji[${@}] copied! 
}