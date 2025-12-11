#!/bin/sh

# Function: docker_utils
# Description: Docker utility functions
# Usage: docker_utils [arguments]
# Alias: du

# fuzzy search for container 
function docker_fuzzy_search() {
  one_arg_required "$@" || return 1
  
  local search_term="$1"
  local containers
  local match
  
  # Get all running container names
  containers=$(docker ps --format '{{.Names}}' 2>/dev/null)
  
  if [ -z "$containers" ]; then
    echo "${red}Error: No running containers found${reset}" >&2
    return 1
  fi
  
  # Try exact match (case-insensitive)
  match=$(echo "$containers" | grep -i "^${search_term}$" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # Try starts with match (case-insensitive)
  match=$(echo "$containers" | grep -i "^${search_term}" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # Try contains match (case-insensitive)
  match=$(echo "$containers" | grep -i "${search_term}" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # No match found
  echo "${red}Error: No container found matching '${search_term}'${reset}" >&2
  return 1
}

# fuzzy search for container (all containers, including stopped)
function docker_fuzzy_search_all() {
  one_arg_required "$@" || return 1
  
  local search_term="$1"
  local containers
  local match
  
  # Get all container names (running and stopped)
  containers=$(docker ps -a --format '{{.Names}}' 2>/dev/null)
  
  if [ -z "$containers" ]; then
    echo "${red}Error: No containers found${reset}" >&2
    return 1
  fi
  
  # Try exact match (case-insensitive)
  match=$(echo "$containers" | grep -i "^${search_term}$" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # Try starts with match (case-insensitive)
  match=$(echo "$containers" | grep -i "^${search_term}" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # Try contains match (case-insensitive)
  match=$(echo "$containers" | grep -i "${search_term}" | head -n 1)
  if [ -n "$match" ]; then
    echo "$match"
    return 0
  fi
  
  # No match found
  echo "${red}Error: No container found matching '${search_term}'${reset}" >&2
  return 1
}

function docker_sh() {
  local container=$(docker_fuzzy_search "$@")

  docker exec -it $container /bin/sh
}

alias dsh="docker_sh"

function docker_files() {
  local container=$(docker_fuzzy_search "$1")

  docker exec $container ls -la $2
}

alias df="docker_files"

function docker_logs_copy() {
  local container=$(docker_fuzzy_search_all "$1") || return 1
  echo "${blue}container:${container}"
  shift
  docker logs "$@" "$container" 2>&1 | pbcopy
  echo "${green}logs copied!${reset}"
}

alias dlc="docker_logs_copy"

function docker_logs_vim() {
  local container=$(docker_fuzzy_search_all "$1") || return 1
  echo "${blue}container:${container}"
  shift
  
  # Create logs directory if it doesn't exist
  local log_dir="$HOME/.logs/docker"
  mkdir -p "$log_dir"
  
  # Generate filename with container name, date, and time
  local timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  local log_file="$log_dir/${container}-${timestamp}.log"
  
  # Write logs to file
  docker logs "$@" "$container" > "$log_file" 2>&1
  
  echo "log file created: $log_file"

  # Open in nvim
  nvim "$log_file"
}

alias dlv="docker_logs_vim"
