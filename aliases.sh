# Example aliases
# No spaces between name and string
# alias <name>=<string>

# Restart shell
# Call after making changes w/o having to restart
alias refresh="source ~/.zshrc && clear"
alias r="refresh"

# Goto dotfiles
alias dotfiles="cd ~/.dotfiles"

# Git
alias conflicts="git diff --name-only --diff-filter=U"          # Does not push
alias rebase="git fetch upstream && git rebase upstream/master" # Fetch and rebase
alias last="git log -1"                                         # Show last change

# System
alias off="sudo shutdown -h now"    # Shutdown
alias sleep="pmset sleepnow"        # Sleep
