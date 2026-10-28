#!/bin/sh

# Function: smoll
# Description: make all imgs in folder small
#   optionally take arg width
#     default width: 420
#   only shrinks images wider than width, keeps aspect ratio
#   pngs and jpgs are converted to webp
#   optionally pass --target, -t or --dir -d
#   default target: new folder "smoll" in calling location
#   default dir: calling location
#
# Usage: smoll [width] [-d|--dir <dir>] [-t|--target <dir>]

function smoll() {
  local width=420
  local dir="."
  local target="./smoll"

  while [ $# -gt 0 ]; do
    case "$1" in
      -d|--dir)    dir="$2"; shift 2 ;;
      -t|--target) target="$2"; shift 2 ;;
      -h|--help)
        echo "Usage: smoll [width] [-d|--dir <dir>] [-t|--target <dir>]"
        return 0 ;;
      *)
        if ! [[ "$1" =~ ^[0-9]+$ ]]; then
          echo "${red}smoll: invalid width '$1'${reset}"
          return 1
        fi
        width="$1"; shift ;;
    esac
  done

  if ! command -v magick >/dev/null 2>&1; then
    echo "${red}smoll: imagemagick (magick) not found${reset}"
    return 1
  fi

  if [ ! -d "$dir" ]; then
    echo "${red}smoll: '$dir' is not a directory${reset}"
    return 1
  fi

  mkdir -p "$target" || return 1

  local count=0 name out
  while IFS= read -r img; do
    name="$(basename "$img")"
    case "$name" in
      *.[pP][nN][gG]|*.[jJ][pP][gG]|*.[jJ][pP][eE][gG]) out="${name%.*}.webp" ;;
      *) out="$name" ;;
    esac
    magick "$img" -auto-orient -resize "${width}x>" "$target/$out" \
      && count=$((count + 1)) \
      || echo "${red}smoll: failed on $img${reset}"
  done < <(find "$dir" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
    -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' -o -iname '*.heic' -o -iname '*.avif' \))

  echo "${green}smoll: ${bold}$count${reset}${green} image(s) -> $target (max width ${width}px)${reset}"
}
