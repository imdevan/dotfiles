#!/usr/bin/env zsh

# Script: simple_plan
# Description: Create simple plan from current dir from template
# Usage: simple_plan [-f]
#
# possibly small go cli
# Alias: simp

source "$HOME/.functions/shared/has_flag.sh"

function simple_plan() {
    mkdir -p plan
    if has_flag "-f" "$@"; then
        :
    elif [ -f plan/simple.md ]; then
        nvim plan/simple.md
        return
    fi
    cat > plan/simple.md <<'EOF'
# Goal
 
[ goal ]

# Context

[ context ]

# Features

[ features ]

# Open Questions

[ questions ]

EOF
    nvim -c 'call feedkeys("/[\<CR>va[c", "n")' plan/simple.md
}

simple_plan "$@"
