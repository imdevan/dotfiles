# Helper function to determine if a bash function contains a flag
has_flag() {
  local flag="$1"
  shift

  for arg in "$@"; do
    if [ "$arg" = "$flag" ]; then
      return 0 # found
    fi
  done

  return 1 # not found
}

# Helper function to strip flags from args
strip_flags() {
  local result=()

  for arg in "$@"; do
    if [[ "$arg" != -* ]]; then
      result+=("$arg")
    fi
  done

  echo "${result[@]}"
}
