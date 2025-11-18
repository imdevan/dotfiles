# Helpful aliases
#
# Example:
# alias <name>=<string>

# Variables used in file
editor="cursor"

# Navigation
alias ..="cd .."

alias dotfiles="${editor} $dotfile_dir"
alias aliases="${editor} $dotfile_dir/aliases.sh"

## Aliases shortcut
alias a="aliases"
alias dots="~/dotfiles"
alias ra="source ~/dotfiles/aliases.sh"

# Terminal Navigation
alias la="ls -a"                         # List all in directory
alias o="open ./"                        # Open - in finder
alias cpr="cp -rf"                       # Copy recursive
alias rf="rm -rf"                        # Remove recursive
alias refresh="source ~/.zshrc && clear" # Refresh the terminal
alias r="refresh"                        # Refresh shortcut
alias t="touch"                          # Make file
alias ex="exit"                          # Exit terminal

# Dotfile shortcuts
alias halp="cat ~/dotfiles/aliases.sh"
alias dot="cd $dotfile_dir"

alias hotkeys="v ~/dotfiles/docs/keybinds/hotkeys.md"
alias hk="hotkeys"

# Code editors
# alias co="code ."
# alias c="cursor ."
# alias v="nvim"


# NPM
# alias nt="npm test"
# alias ns="npm start"
# alias nee="npm run test:e2e"
# alias nu="npm uninstall"
# alias nrd="npm run dev"
# alias ni="npm install"
# alias naf="npm audit fix"
# alias jc="npx jest --coverage"

# PNPM
# alias pns="pnpm start"
# alias pnd="pnpm dev"
# alias pni="pnpm install"
# alias pnn="pnpm"
# alias pnb="pnpm build"
# alias pnr="pnpm run"

# Yarn
# alias y="yarn"
# alias yb="yarn build"
# alias yys="yarn && yarn start"
# alias yc="yarn clean"
# alias yd="yarn dev"
# alias yr="yarn run"
# alias yrd="yarn run dev"
# alias ys="yarn start"
# alias yd="yarn dev"
# alias yb="yarn build"
# alias ya="yarn add"
# alias yt="yarn test"
# alias yad="yarn add --dev"
# alias yt="yarn test"
# alias yw="yarn web"

