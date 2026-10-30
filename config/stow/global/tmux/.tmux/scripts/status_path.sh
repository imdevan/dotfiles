#!/bin/sh

# Format a path for tmux statusline.
# - Transforms:
#   - Replace $HOME prefix with "~"
#   - Apply prefix aliases (edit the mapping below)
# - If the result is longer than max chars, abbreviate parent directories
#   to the first character of each "word" (separators: "-", "_", " ").
# - If still too long, abbreviate the current directory too (only its first word).
#
# Usage:
#   status_path.sh "<path>" [max_chars] [preserve_separators]
#
# preserve_separators:
# - false (default): treat -, _, and spaces as boundaries but do NOT keep them
# - true: keep separators when abbreviating (e.g. "dance-partner" -> "d-p")

path="${1:-}"
max_chars="${2:-32}"
preserve_separators="${3:-}"

if [ -n "${STATUS_PATH_PRESERVE_SEPARATORS:-}" ]; then
  preserve_separators="$STATUS_PATH_PRESERVE_SEPARATORS"
fi

if [ -z "$preserve_separators" ]; then
  preserve_separators="false"
fi

case "$(printf "%s" "$preserve_separators" | tr '[:upper:]' '[:lower:]')" in
1 | true | yes | y | on) keep_seps=1 ;;
*) keep_seps=0 ;;
esac

if [ -z "$path" ]; then
  exit 0
fi

# Existing transforms (kept).
if [ -n "${HOME:-}" ]; then
  case "$path" in
  "$HOME") path="~" ;;
  "$HOME"/*) path="~/${path#"$HOME"/}" ;;
  esac
fi

# Prefix aliases (first match wins). Edit these.
# Format: prefix -> replacement
# - If replacement is empty, the prefix is removed (and any separating "/").
apply_alias() {
  _prefix="$1"
  _repl="$2"

  case "$path" in
  "$_prefix")
    path="$_repl"
    ;;
  "$_prefix"/*)
    _rest="${path#$_prefix/}"
    if [ -n "$_repl" ]; then
      path="$_repl/$_rest"
    else
      path="$_rest"
    fi
    ;;
  esac
}

apply_alias "~/Documents/Projects" "P"
apply_alias "~/Documents/obsidian_notes" "O"
apply_alias "~/dotfiles" "dots"

printf "%s" "$path" | awk -v max="$max_chars" -v keep_seps="$keep_seps" '
function parent_abbr(s,   i,c,out,in_word) {
  # Handle dotfiles: if string starts with dot, include dot + first letter (.config -> .c)
  if (substr(s, 1, 1) == "." && length(s) > 1) {
    return "." substr(s, 2, 1)
  }
  
  # Abbreviate to the unique first characters of each "word" within this
  # directory component.
  # Word boundaries:
  # - separators: -, _, space
  # - camelCase humps: aB, 2B, or acronym boundary like HTTPServer (S)
  out = ""
  in_word = 0
  prev = ""
  for (i = 1; i <= length(s); i++) {
    c = substr(s, i, 1)
    nxt = (i < length(s)) ? substr(s, i + 1, 1) : ""

    if (c == "-" || c == "_" || c == " ") {
      if (keep_seps) out = out c
      in_word = 0
      prev = c
      continue
    }

    if (!in_word) {
      out = out c
      in_word = 1
      prev = c
      continue
    }

    camel = ((c ~ /[A-Z]/ && prev ~ /[a-z0-9]/) || (c ~ /[A-Z]/ && prev ~ /[A-Z]/ && nxt ~ /[a-z]/))

    if (camel) out = out c
    prev = c
  }
  return out
}

function current_abbr_fit(s, limit,   i,c,nxt,prev,cur,k,camel_boundary,need,save,out) {
  # Abbreviate the current directory component just enough to fit `limit`.
  # - Treat -, _, space AND camelCase humps as word boundaries.
  # - Always preserve explicit separators (-, _, space) in output.
  # - Abbreviate words from left to right (including the last word if needed).

  if (limit < 1) limit = 1
  if (length(s) <= limit) return s

  # Split into words + separators (sep may be "" for camelCase boundaries).
  k = 0
  cur = ""
  prev = ""

  for (i = 1; i <= length(s); i++) {
    c = substr(s, i, 1)
    nxt = (i < length(s)) ? substr(s, i + 1, 1) : ""

    if (c == "-" || c == "_" || c == " ") {
      if (cur != "") {
        k++
        w[k] = cur
        sep[k] = c
        cur = ""
      } else if (k > 0) {
        # Multiple separators in a row; preserve them.
        sep[k] = sep[k] c
      }
      prev = c
      continue
    }

    camel_boundary = (cur != "" && ((c ~ /[A-Z]/ && prev ~ /[a-z0-9]/) || (c ~ /[A-Z]/ && prev ~ /[A-Z]/ && nxt ~ /[a-z]/)))
    if (camel_boundary) {
      k++
      w[k] = cur
      sep[k] = ""
      cur = c
      prev = c
      continue
    }

    cur = cur c
    prev = c
  }

  if (cur != "") {
    k++
    w[k] = cur
    sep[k] = ""
  }

  need = length(s) - limit
  for (i = 1; i <= k && need > 0; i++) {
    save = length(w[i]) - 1
    if (save > 0) { abbr[i] = 1; need -= save } else { abbr[i] = 0 }
  }
  for (; i <= k; i++) abbr[i] = 0

  out = ""
  for (i = 1; i <= k; i++) {
    out = out (abbr[i] ? substr(w[i], 1, 1) : w[i])
    if (i < k) out = out sep[i]
  }

  return out
}

{
  p = $0
  if (p == "" || p == "~") { print p; next }
  if (max == "" || max < 1) max = 24

  if (length(p) <= max) { print p; next }

  prefix = ""
  rest = p
  if (substr(p, 1, 2) == "~/") { prefix = "~/"; rest = substr(p, 3) }
  else if (substr(p, 1, 1) == "/") { prefix = "/"; rest = substr(p, 2) }

  n = split(rest, comps, "/")
  if (n <= 1) { print p; next }

  # Abbreviate parent directories whenever the full path is too long.
  for (i = 1; i < n; i++) comps[i] = parent_abbr(comps[i])

  # Compute how much space the current directory component has.
  base_len = length(prefix) + (n - 1) # slashes between comps
  for (i = 1; i < n; i++) base_len += length(comps[i])

  avail = max - base_len
  comps[n] = current_abbr_fit(comps[n], avail)

  out = prefix comps[1]
  for (i = 2; i <= n; i++) out = out "/" comps[i]

  print out
}
'