#!/usr/bin/env bash

# Capture visible section of current pane and pipe to clipboard
copy_cmd=""

if command -v pbcopy &>/dev/null; then
  copy_cmd="pbcopy"
elif command -v wl-copy &>/dev/null && wl-copy <<< "" &>/dev/null; then
  copy_cmd="wl-copy"
elif command -v xclip &>/dev/null; then
  copy_cmd="xclip -selection clipboard"
elif command -v xsel &>/dev/null; then
  copy_cmd="xsel --clipboard --input"
elif command -v clip.exe &>/dev/null; then
  copy_cmd="clip.exe"
fi

if [[ -n "$copy_cmd" ]]; then
  if tmux capture-pane -p | eval "$copy_cmd"; then
    tmux display-message "Copied visible pane to clipboard"
  else
    tmux display-message "Failed to copy visible pane to clipboard"
  fi
else
  tmux display-message "No supported clipboard tool found"
fi
