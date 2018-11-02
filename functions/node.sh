function nodep () {
  str=$*
  echo "$str"
  node -p "$str"
}
alias np='nodep'