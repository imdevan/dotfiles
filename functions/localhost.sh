# Opens localhost at port
# takes number as port
function localhost() {
	echo "python -m webbrowser http://localhost:$1"
	python -m webbrowser "http://localhost:${1}"
}
alias l="localhost"
# Opening localhost ports
alias l3="l 3000"
alias l4="l 4000"
alias l8="l 8000"
alias l80="l 8080"
