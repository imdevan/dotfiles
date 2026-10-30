# Hide and show hiddenfiles (Mac only)
# Function to show or hide files
# Takes either a YES or NO as argument
function show_hidden_files () {
    defaults write com.apple.finder AppleShowAllFiles $1
    killall Finder /System/Library/CoreServices/Finder.app
}

# Show / hide hidden files via alias
alias showfiles="show_hidden_files YES"
alias hidefiles="show_hidden_files NO"

# Lazy version of above
alias sf="showfiles"
alias hf="hidefiles"
