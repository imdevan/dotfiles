#!/bin/sh

# Function: scripts
# Description: Show available scripts in package.json
# Usage: scripts [arguments]
# Alias: sc

function scripts() {
    if [ -f "package.json" ]; then
        echo "\nScripts:"
        echo "----------------------------------------"
        cat package.json | jq -r '.scripts | to_entries[] | "\(.key)\t\(.value)"' | while IFS=$'\t' read -r key value; do
            printf "  ${blue}%-12s${yellow}%-20s${reset}\n" "$key" "$value"
        done
        echo "----------------------------------------"
    elif [ -f "justfile" ] || [ -f "Justfile" ]; then
        local jfile
        jfile=$([ -f "justfile" ] && echo "justfile" || echo "Justfile")
        echo "\nScripts:"
        echo "----------------------------------------"
        awk '
            # recipe header: starts with identifier then ":" not followed by "="
            /^[a-zA-Z_-][a-zA-Z0-9_-]*:[^=]/ || /^[a-zA-Z_-][a-zA-Z0-9_-]*:$/ {
                if (name != "" && cmd == "" && fallback != "")
                    printf "  \033[34m%-12s\033[33m%-20s\033[0m\n", name, fallback
                name = $0; sub(/:.*/, "", name)
                cmd = ""; fallback = ""
                next
            }
            name != "" && /^[[:space:]]/ {
                line = $0; sub(/^[[:space:]]+/, "", line)
                if (substr(line, 1, 1) == "@") {
                    stripped = substr(line, 2); sub(/^[[:space:]]*/, "", stripped)
                    if (fallback == "") fallback = stripped
                } else if (cmd == "") {
                    cmd = line
                    printf "  \033[34m%-12s\033[33m%-20s\033[0m\n", name, cmd
                }
            }
            END {
                if (name != "" && cmd == "" && fallback != "")
                    printf "  \033[34m%-12s\033[33m%-20s\033[0m\n", name, fallback
            }
        ' "$jfile"
        echo "----------------------------------------"
    else
        echo "${red}Error: package.json or justfile not found${reset}"
        return 1
    fi
}

# Create alias
alias sc="scripts"
