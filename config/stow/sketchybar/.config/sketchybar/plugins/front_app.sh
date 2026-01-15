#!/bin/sh
# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
#
# SUBSTITUTES=""

SUBSTITUTES="
chrome=🦄
arc=🌈
qutebrowser=🐶
wezterm=👾
code=🧑🏻‍💻
kiro=👻
cursor=🐁
keyboard=
karabiner=🧗🏻‍♀️
system=⚙️
streamlabs=🎬
messages=🤗
whatsapp=🙌🏼
kitty=😸
finder=👀
antigravity=🛸
simulator=📱
"

lower() {
  printf '%s' "$1" | tr 'A-Z' 'a-z'
}

substitute() {
  name_lc="$(lower "$1")"
  found=false
  result=""

  # read $SUBSTITUTES in the current shell
  while IFS= read -r line; do
    # skip empty lines or comments
    case "$line" in
    '' | \#*) continue ;;
    esac

    key="${line%%=*}"
    val="${line#*=}"

    # lowercase key for case-insensitive matching
    key_lc="$(lower "$key")"

    case "$name_lc" in
    *"$key_lc"*)
      result="$val"
      # result="$name_lc $val"
      found=true
      break
      ;;
    esac
  done <<EOF
$SUBSTITUTES
EOF

  if [ "$found" = true ]; then
    printf '%s' "$result"
  else
    printf '%s' "$name_lc"
  fi
}

if [ "$SENDER" = "front_app_switched" ]; then
  label="$(substitute "$INFO")"

  sketchybar --set "$NAME" label="$label"
  # sketchybar --set "$NAME" label="$INFO"
fi
