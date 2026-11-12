#!/usr/bin/env zsh

# Script: compress
# Description: tar + gzip a file or directory into <name>.tar.gz
# Usage: compress <path>

function compress() {
  tar -czf "${1%/}.tar.gz" "${1%/}"
}

compress "$@"
