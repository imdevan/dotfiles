#!/bin/sh

# Function: yx
# Description: strip all params but v= from youtube url then pass to yt-dlp -x
# Usage: yx [arguments]
# Alias: y

function yx() {
  local input
  if [ $# -eq 0 ]; then
    # No args: read URL from clipboard (avoids shell & parsing issue)
    if command -v xclip &>/dev/null; then
      input=$(xclip -selection clipboard)
    elif command -v xsel &>/dev/null; then
      input=$(xsel --clipboard)
    elif command -v wl-paste &>/dev/null; then
      input=$(wl-paste)
    else
      echo "yx: provide a URL/ID, or install xclip, xsel, or wl-paste for clipboard support" >&2
      return 1
    fi
    set -- "$input"
  fi

  local args=()
  for arg in "$@"; do
    local video_id=""
    if echo "$arg" | grep -qE 'youtube\.com.*[?&]v='; then
      # Full youtube.com URL — extract v= param
      video_id=$(echo "$arg" | sed -n 's/.*[?&]v=\([^&]*\).*/\1/p')
    elif echo "$arg" | grep -qE 'youtu\.be/'; then
      # Short youtu.be/VIDEO_ID URL
      video_id=$(echo "$arg" | sed -n 's|.*youtu\.be/\([^?&]*\).*|\1|p')
    elif echo "$arg" | grep -qE '^[A-Za-z0-9_-]{11}$'; then
      # Bare 11-char video ID
      video_id="$arg"
    fi

    if [ -n "$video_id" ]; then
      args+=("https://www.youtube.com/watch?v=${video_id}")
    else
      args+=("$arg")
    fi
  done
  yt-dlp -x "${args[@]}"
}

