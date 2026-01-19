#!/bin/sh

# Function: list_all
# Description: List all in dir
# Usage: list_all [arguments]
# Alias: la

function list_all() {
  local sort="name"
  local reverse="0"
  local show_hidden="0"

  # Sorting flags (precedence: -n wins if multiple are present)
  if has_flag "-m" "$@"; then sort="modified"; fi
  if has_flag "-t" "$@"; then sort="type"; fi
  if has_flag "-s" "$@"; then sort="size"; fi
  if has_flag "-n" "$@"; then sort="name"; fi

  if has_flag "-r" "$@"; then reverse="1"; fi
  if has_flag "-h" "$@"; then show_hidden="1"; fi

  # Keep everything else functioning the same after stripping flags:
  # remaining args become the filter query.
  local query
  query="$(strip_flags "$@")"

  LIST_ALL_QUERY="$query" \
  LIST_ALL_SORT="$sort" \
  LIST_ALL_REVERSE="$reverse" \
  LIST_ALL_HIDDEN="$show_hidden" \
    nu -c '
      let q = ($env.LIST_ALL_QUERY? | default "")
      let s = ($env.LIST_ALL_SORT? | default "name")
      let rflag = (($env.LIST_ALL_REVERSE? | default "0") | into int) == 1
      let hidden = (($env.LIST_ALL_HIDDEN? | default "0") | into int) == 1
      let default_rev = match $s { "modified" => true, "size" => true, _ => false }
      let rev = ($default_rev != $rflag) # xor

      let rows = (if $hidden { ls -a } else { ls })
      let rows = if $q != "" { $rows | where name =~ $q } else { $rows }

      let rows = match $s {
        "modified" => ($rows | sort-by modified)
        "size" => ($rows | sort-by size)
        "type" => (
          (
            $rows
            | each {|it| $it | insert kind (if $it.type == "dir" { 0 } else { 1 }) }
            | sort-by kind name --ignore-case --natural
            | reject kind
          )

          # TODO: sort by type (dir/file) then file mimetype.
          # Likely approach (slow): for files, compute mime via `^file --mime-type -b $it.name`
          # and `sort-by kind mime name`.
        )
        _ => ($rows | sort-by name --ignore-case --natural)
      }

      let rows = ($rows | if $rev { reverse } else { $in })
      if ($rows | is-empty) {
        ["🧙🏼‍♂️ nothing here"] | table -i false
      } else {
        $rows | table -i false
      }
    '
}

# Create alias
alias l="list_all"
alias la="list_all -h"
