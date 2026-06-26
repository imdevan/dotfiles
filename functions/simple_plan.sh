#!/bin/sh

# Function: simple_plan
# Description: Create simple plan from current dir from template
# Usage: simple_plan [-f]
# Alias: simp

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

# Create alias
alias simp="simple_plan"
