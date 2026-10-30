#!/bin/sh

# Function: ytdl
# Description: iykyk
# Usage: ytdl link output
function ytdl() {
    two_arg_required "$@" || return 1

    yt-dlp -f mp4 "$1" -o "$2".mp4
}

