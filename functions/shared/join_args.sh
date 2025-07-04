# Function: join_arguments
# Description: Join multiple arguments with spaces
# Usage: join_arguments [arguments]
function join_arguments() {
    echo "$@" | sed 's/ /+/g'
}