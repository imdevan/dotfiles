#!/bin/sh

# Function: list_all
# Description: List all in dir
# Usage: list_all [arguments]
# Alias: la
#
# ... this started as "nu -c 'ls -a'"
# todo: fix nested list behavior

function list_all() {
  local sort="name"
  local reverse="0"
  local show_hidden="0"
  local skip_cd="${LIST_ALL_SKIP_CD:-0}"
  local query=""

  # Sorting flags (precedence: -n wins if multiple are present)
  if has_flag "-m" "$@"; then sort="modified"; fi
  if has_flag "-t" "$@"; then sort="type"; fi
  if has_flag "-s" "$@"; then sort="size"; fi
  if has_flag "-n" "$@"; then sort="name"; fi

  if has_flag "-r" "$@"; then reverse="1"; fi
  if has_flag "-h" "$@"; then show_hidden="1"; fi

  # Capture flags + first two non-flag params
  local -a flag_args=()
  local nf_count=0
  local nf1=""
  local nf2=""
  local arg
  for arg in "$@"; do
    case "$arg" in
      -*) flag_args+=("$arg") ;;
      *)
        nf_count=$((nf_count + 1))
        if [ "$nf_count" -eq 1 ]; then
          nf1="$arg"
        elif [ "$nf_count" -eq 2 ]; then
          nf2="$arg"
        fi
        ;;
    esac
  done

  local warn_ignored_second="0"

  # Directory hop behavior (exactly once; no recursion)
  if [ "$skip_cd" != "1" ] && [ "$nf_count" -ge 1 ] && [ "$nf_count" -le 2 ]; then
    local target_dir=""

    # If there's an exact directory match, prefer it.
    # For 2 non-flag params only: if there's exactly one match and it's a directory, use that.
    target_dir="$(
      LIST_ALL_Q1="$nf1" LIST_ALL_HIDDEN="$show_hidden" nu -n -c '
      let q = ($env.LIST_ALL_Q1? | default "")
      let hidden = (($env.LIST_ALL_HIDDEN? | default "0") | into int) == 1
      let rows = (if $hidden { ls -a } else { ls })

      let exact = ($rows | where type == "dir" and name == $q)
      if ($exact | is-empty) {
        # fallback handled by shell when needed
      } else {
        print $q
      }
    ' 2>/dev/null
    )"

    if [ -z "$target_dir" ] && [ "$nf_count" -eq 2 ]; then
      target_dir="$(
        LIST_ALL_Q1="$nf1" LIST_ALL_HIDDEN="$show_hidden" nu -n -c '
          let q = ($env.LIST_ALL_Q1? | default "")
          let hidden = (($env.LIST_ALL_HIDDEN? | default "0") | into int) == 1
          let rows = (if $hidden { ls -a } else { ls })
          let matches = ($rows | where name =~ $q)
          if ($matches | length) == 1 {
            let it = ($matches | first)
            if $it.type == "dir" { print $it.name }
          }
        ' 2>/dev/null
      )"
    fi

    if [ -n "$target_dir" ] && [ -d "$target_dir" ]; then
      if [ "$nf_count" -eq 1 ]; then
        (cd "$target_dir" && LIST_ALL_SKIP_CD=1 list_all "${flag_args[@]}")
        return $?
      fi

      if [ "$nf_count" -eq 2 ]; then
        (cd "$target_dir" && LIST_ALL_SKIP_CD=1 list_all "${flag_args[@]}" "$nf2")
        return $?
      fi
    fi

    # If two params and no directory hop, show results for the first param
    # and warn that the second was ignored (only when the first param matched >1 rows).
    if [ "$nf_count" -eq 2 ]; then
      local match_count="0"
      match_count="$(
        LIST_ALL_Q1="$nf1" LIST_ALL_HIDDEN="$show_hidden" nu -n -c '
          let q = ($env.LIST_ALL_Q1? | default "")
          let hidden = (($env.LIST_ALL_HIDDEN? | default "0") | into int) == 1
          let rows = (if $hidden { ls -a } else { ls })
          print ($rows | where name =~ $q | length)
        ' 2>/dev/null
      )"

      # Always treat first param as the query; the second is only used when we hop into a directory.
      # If there is more than one result for the first query, warn that the second param was ignored.
      query="$nf1"
      if [ "${match_count:-0}" -gt 1 ] 2>/dev/null; then
        warn_ignored_second="1"
      fi
    fi
  fi

  # Keep everything else functioning the same after stripping flags:
  # remaining args become the filter query.
  if [ -z "$query" ]; then
    query="$(strip_flags "$@")"
  fi

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
        $rows 
        | each {|it|
            let now = (date now)
            let age = ($now - $it.modified)
            let age_color = if $age < 1hr {
              "green_bold"
            } else if $age < 1day {
              "green"
            } else if $age < 1wk {
              "yellow"
            } else if $age < 4wk {
              "red"
            } else {
              "red_dimmed"
            }
            
            let relative_date = ($it.modified | date humanize)
            
            {
              name: (if $it.type == "dir" { 
                $"(ansi blue_bold)($it.name)(ansi reset)" 
              } else { 
                $it.name 
              })
              type: $it.type
              size: $it.size
              modified: $"(ansi ($age_color))($relative_date)(ansi reset)"
            }
          }
        | table -i false
      }
    '

  if [ "$warn_ignored_second" = "1" ]; then
    echo "${red}more than one result '$nf2' ignored${reset}"
  fi
}

# Create alias
alias l="list_all"
alias la="list_all -h"
