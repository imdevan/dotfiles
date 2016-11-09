
function w() {
  python -mwebbrowser http://$1

  # todo 
  # if [-z "$2"]; then
  #   python -mwebbrowser http://$1.com
  # else
  #   python -mwebbrowser http://$1.$2
  # fi
}
