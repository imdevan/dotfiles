#!/bin/sh

# Function: docker_exec_it
# Description: Go into docker container
# Usage: docker_exec_it [arguments]
# Alias: dei

function docker_exec_it() {
    docker exec -it $1 /bin/bash
}

# Create alias
alias dei="docker_exec_it"
