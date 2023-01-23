
# Add yarn types of module
function yarn-add-type() {
    var1="@types\/$1"
    echo "$var1"
    yarn add --dev $var1
}
alias yat="yarn-add-type"
