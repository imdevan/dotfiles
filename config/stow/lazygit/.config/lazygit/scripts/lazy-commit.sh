#!/bin/sh
# Stage and commit a single file with a generated message, like the nvim
# <leader>ga / <leader>gA utils (nvim/lua/utils/keymaps/git.lua).
#
# usage: lazy-commit.sh [--nested] <path>
#   "<verb> <name>"           e.g. "update github"
#   "<verb> <name> <parent>"  (--nested) e.g. utils/github.lua -> "update github util"
# verb is add (not in HEAD), delete (gone from worktree) or update.

nested=0
if [ "$1" = "--nested" ]; then
  nested=1
  shift
fi

file="$1"
if [ -z "$file" ]; then
  echo "usage: lazy-commit.sh [--nested] <path>" >&2
  exit 1
fi

if [ -d "$file" ]; then
  echo "lazy-commit: '$file' is a directory, select a file" >&2
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
name="${name%.*}"
[ -z "$name" ] && name=$(basename "$file") # dotfiles like .zshrc

msg="$verb $name"
if [ "$nested" -eq 1 ]; then
  parent=$(basename "$(dirname "$file")" | sed 's/s$//')
  [ "$parent" != "." ] && msg="$parent $msg"
fi

git add -A -- "$file" || exit 1
git commit -m "$msg" -- "$file"
