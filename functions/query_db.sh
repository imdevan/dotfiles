#!/bin/sh

# Function: query_db
# Description: Query nushell db
# Usage: query_db [arguments]
# Alias: qd

function query_db() {
  # Flags:
  # -d "<db_path>": sqlite db path (default: ./app.db)
  # -c "<col1 col2|col1,col2>": select columns
  # -x "<col1 col2|col1,col2>": exclude columns

  # Read flag values (supports: -c value, -x value)
  get_flag_value() {
    local flag="$1"
    shift
    local prev=""
    local _arg
    for _arg in "$@"; do
      if [ "$prev" = "$flag" ]; then
        echo "$_arg"
        return 0
      fi
      prev="$_arg"
    done
    return 1
  }

  local cols=""
  local exclude=""
  local db=""

  if has_flag "-d" "$@"; then
    db="$(get_flag_value "-d" "$@")"
  fi

  if has_flag "-c" "$@"; then
    cols="$(get_flag_value "-c" "$@")"
  fi

  if has_flag "-x" "$@"; then
    exclude="$(get_flag_value "-x" "$@")"
  fi

  # Positional args (strip flags + their values)
  local -a pos=()
  local skip_next="0"
  local _arg
  for _arg in "$@"; do
    if [ "$skip_next" = "1" ]; then
      skip_next="0"
      continue
    fi

    if [ "$_arg" = "-d" ] || [ "$_arg" = "-c" ] || [ "$_arg" = "-x" ]; then
      skip_next="1"
      continue
    fi

    case "$_arg" in
      -*) ;; # ignore other flags
      *) pos+=("$_arg") ;;
    esac
  done

  if [ "${#pos[@]}" -eq 0 ]; then
    echo "usage: query_db <table> [sql_or_clause] [-d db] [-c cols] [-x cols]" >&2
    return 1
  fi

  # Normalize positional args to $1/$2/$3 for portability (zsh vs bash arrays).
  set -- "${pos[@]}"

  local table="$1"
  shift
  # Remaining args (if any) become the SQL/clause (usually passed quoted).
  local clause="$*"

  if [ -z "$db" ]; then
    db="${QUERY_DB_DB:-app.db}"
  fi

  if [ -z "$table" ]; then
    echo "query_db: missing table name" >&2
    return 1
  fi

  local sql=""
  if [ -z "$clause" ]; then
    sql="select * from \"$table\""
  else
    case "$clause" in
      [Ss][Ee][Ll][Ee][Cc][Tt]*|[Ww][Ii][Tt][Hh]*|[Pp][Rr][Aa][Gg][Mm][Aa]*)
        sql="$clause"
        ;;
      *)
        sql="select * from \"$table\" $clause"
        ;;
    esac
  fi

  case "$sql" in
    *";") ;;
    *) sql="$sql;" ;;
  esac

  QUERY_DB_DB="$db" \
  QUERY_DB_SQL="$sql" \
  QUERY_DB_TABLE="$table" \
  QUERY_DB_COLS="$cols" \
  QUERY_DB_EXCLUDE="$exclude" \
    nu -n -c '
      let db = ($env.QUERY_DB_DB? | default "app.db")
      let sql = ($env.QUERY_DB_SQL? | default "")
      let table_name = ($env.QUERY_DB_TABLE? | default "")
      let cols_raw = ($env.QUERY_DB_COLS? | default "" | str trim)
      let excl_raw = ($env.QUERY_DB_EXCLUDE? | default "" | str trim)

      let cols = if $cols_raw == "" { [] } else { $cols_raw | str replace -a "," " " | split words }
      let excl = if $excl_raw == "" { [] } else { $excl_raw | str replace -a "," " " | split words }

      let rows = (open $db | query db $sql)
      let rows = if ($cols | is-empty) { $rows } else { $rows | select -o ...$cols }
      let rows = if ($excl | is-empty) { $rows } else { $rows | reject -o ...$excl }

      if ($rows | is-empty) {
        # Render an "empty table" but keep headers visible.
        # Nu prints "empty list" for empty tables, so we build a single blank row
        # from the table schema (or from -c/-x), render it, then remove the row.

        let schema_cols = if $table_name == "" {
          []
        } else {
          let pragma = ("PRAGMA table_info(" + $table_name + ")")
          (open $db | query db $pragma | get name)
        }

        let cols_final = if ($cols | is-empty) { $schema_cols } else { $cols }
        let cols_final = if ($excl | is-empty) { $cols_final } else { $cols_final | where {|c| not ($c in $excl) } }

        if ($cols_final | is-empty) {
          ["🧙🏼‍♂️ empty list"] | table -i false
        } else {
          let rec = ($cols_final | reduce -f {} {|c, acc| $acc | upsert $c "" })
          let rendered = ([$rec] | table -i false)
          let ls = ($rendered | lines)
          if ($ls | length) >= 5 {
            $ls | reject 3 | str join (char nl)
          } else {
            $rendered
          }
        }
      } else {
        $rows | table -i false
      }
    '
}

# Create alias
alias qd="query_db"
