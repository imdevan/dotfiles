# File system
if command -v eza &> /dev/null; then
  alias ols='eza -lh --group-directories-first --icons=auto'
  alias olsa='ls -a'
  alias olt='eza --tree --level=2 --long --icons --git'
  alias olta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# Directories
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'

# Tools
# alias d='docker'
# alias r='rails'
# alias g='git'
# alias gcm='git commit -m'
# alias gcam='git commit -a -m'
# alias gcad='git commit -a --amend'
# alias c='opencode'
