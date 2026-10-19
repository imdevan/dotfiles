function nodep () {
  local str=$*
  echo "$str"
  node -p "$str"
}
alias np='nodep'