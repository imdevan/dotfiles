# Function: join_args
# Description: Join multiple arguments with spaces
# Usage: join_args [arguments]
function join_args() {
  echo "$@" | sed 's/ /+/g'
}

to_snake_case() {
  local input="$*"
  local output=$(echo "$input" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
  echo "$output"
}

