#!/bin/sh
# Toggle hiding nested git repos (untracked dirs containing a .git) from the files panel.
# Writes them to a marked block in .git/info/exclude (local, never committed); running it
# again removes the block.
#
# usage: toggle-nested-repos.sh

begin="# >>> lazygit: hidden nested repos"
end="# <<< lazygit: hidden nested repos"

cd "$(git rev-parse --show-toplevel)" || exit 1
exclude=$(git rev-parse --git-path info/exclude)
mkdir -p "$(dirname "$exclude")"
touch "$exclude"

if grep -qxF "$begin" "$exclude"; then
  tmp=$(mktemp)
  sed "/^$begin\$/,/^$end\$/d" "$exclude" >"$tmp" && cat "$tmp" >"$exclude"
  rm -f "$tmp"
  echo "nested repos: shown"
  exit 0
fi

# nested repos only ever show up inside untracked dirs
repos=$(git -c core.quotePath=false ls-files --others --directory --exclude-standard |
  grep '/$' |
  while IFS= read -r dir; do
    find "$dir" -name .git -prune -exec dirname {} \;
  done)

if [ -z "$repos" ]; then
  echo "nested repos: none found"
  exit 0
fi

{
  echo "$begin"
  echo "$repos" | sed 's|^|/|; s|$|/|'
  echo "$end"
} >>"$exclude"
echo "nested repos: hidden"
echo "$repos" | sed 's/^/  /'
