# Color variables
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
teal=`tput setaf 6`
orange=`tput setaf 9`
purple=`tput setaf 12`
pink=`tput setaf 13`
bold=`tput bold`
reset=`tput sgr0`

function colors () {
    echo "black: #292420,
white: white,
blue: #50C0E1,
green: #2BB7A3,
red: #E95353,
salmon: #F77F79,
light-gray: #f5f5f5,
gray: #a5a5a5,
dark-gray: #444444,
seafoam: #2BB7A3,
purple: #A087D2"
}
# e.g.
# echo "${green}${bold}test ${reset}text"
# Will show test in bold green and text in the default console font
