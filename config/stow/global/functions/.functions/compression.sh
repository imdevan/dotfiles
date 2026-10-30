#!/bin/sh

# Function: compression
# Description: tar wrappers

function compress() {
  tar -czf "${1%/}.tar.gz" "${1%/}"
}

alias decompress="tar -xzf"

