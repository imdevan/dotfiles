#!/bin/sh

# Function: nu_alias
# Description: Execute nu alias
# Usage: nu_alias [alias] [args]
# Alias: nua

function nu_alias() {
    if [ -z "$1" ]; then
        echo "Usage: nu_alias <alias> [args]"
        return 1
    fi
    
    # Remove function name from args
    local alias_name="$1"
    shift
    
    # Execute the alias in nu shell with -c flag and pass remaining args
    nu --login -c "$alias_name $*"
}

# Create alias
# alias nua="nu_alias"

alias nua="nu --login -c"
