#!/bin/sh
# Stage and commit a single file or directory with a generated message, like the nvim
# <leader>ga / <leader>gA utils (nvim/lua/utils/keymaps/git.lua).
#
# usage: lazy-commit.sh [--nested] <path>   (file or directory)
#   "<verb> <name>"           e.g. "update github"
#   "<verb> <name> <parent>"  (--nested) e.g. utils/github.lua -> "update github util"
# verb is add (not in HEAD), delete (gone from worktree) or update.

nested=0
if [ "$1" = "--nested" ]; then
  nested=1
  shift
fi

file="${1%/}"
if [ -z "$file" ]; then
  echo "usage: lazy-commit.sh [--nested] <path>" >&2
  exit 1
fi

if ! git cat-file -e "HEAD:$file" 2>/dev/null; then
  verb="add"
elif [ ! -e "$file" ]; then
  verb="delete"
else
  verb="update"
fi

name=$(basename "$file")
# keep dir names like conf.d intact (also when the dir was deleted)
if [ ! -d "$file" ] && [ "$(git cat-file -t "HEAD:$file" 2>/dev/null)" != "tree" ]; then
  name="${name%.*}"
fi
[ -z "$name" ] && name=$(basename "$file") # dotfiles like .zshrc

msg="$verb $name"
if [ "$nested" -eq 1 ]; then
  parent=$(basename "$(dirname "$file")" | sed 's/s$//')
  [ "$parent" != "." ] && msg="$verb $parent $name"
fi

# skip add when a deletion is already staged (e.g. after undo), git add would
# fail on the unmatched pathspec; commit -- <path> still picks it up
if [ -e "$file" ] || git ls-files --error-unmatch -- "$file" >/dev/null 2>&1; then
  git add -A -- "$file" || exit 1
fi
git commit -m "$msg" -- "$file"
