#!/usr/bin/env zsh

# Script: icon-gen
# Description: generate icon from svg images for ios and android
# Type: script
# Usage: icon-gen <logo.svg|png> [--ios] [--android] [-f]
#   --ios      only generate the iOS icon
#   --android  only generate the Play Store icon
#   -f         overwrite existing icons
#   ICON_BG=<color> background used to flatten the iOS icon (default: white)
# Alias: icon-gen
#
# Outputs next to the logo:
#   <name>-ios-1024.png      1024x1024, RGB, no alpha, square (Xcode makes the smaller sizes)
#   <name>-android-512.png   512x512, 32-bit RGBA PNG, < 1 MB (Google Play store listing)

source "$HOME/.functions/shared/has_flag.sh"
source "$HOME/.functions/shared/validators.sh"
source "$HOME/.functions/shared/colors.sh"


# Render the logo centred on a transparent square canvas of the given size.
# SVGs are rasterised at high density so they stay sharp after resizing.
render_square() {
  local logo="$1" size="$2"
  shift 2
  local density=()
  [[ "${logo:l}" == *.svg ]] && density=(-density 1200)

  magick -background none "${density[@]}" "$logo" \
    -resize "${size}x${size}" \
    -gravity center -extent "${size}x${size}" \
    "$@"
}

gen_ios() {
  local logo="$1" out="$2"
  # Flatten onto a solid background, drop alpha, force 8-bit RGB (PNG24).
  render_square "$logo" 1024 \
    -background "${ICON_BG:-white}" -alpha remove -alpha off \
    -colorspace sRGB -type TrueColor \
    "PNG24:$out"
}

gen_android() {
  local logo="$1" out="$2"
  # Keep transparency, force 32-bit RGBA.
  render_square "$logo" 512 -colorspace sRGB -strip "PNG32:$out"

  local bytes=$(stat -c %s "$out")
  if ((bytes > 1024 * 1024)); then
    echo "${red}Warning: $out is $((bytes / 1024)) KB (Play Store max 1 MB)${reset}"
  fi
}

main() {
  # Drop flags so only positional args remain (zsh filter keeps paths with spaces intact).
  local args=("${(@)@:#-*}")
  one_arg_required "${args[@]}" || {
    echo "Usage: icon-gen <logo.svg|png> [--ios] [--android] [-f]"
    return 1
  }

  local logo="${args[1]}"
  if [[ ! -f "$logo" ]]; then
    echo "${red}Error: file not found: $logo${reset}"
    return 1
  fi

  if ! command -v magick >/dev/null; then
    echo "${red}Error: imagemagick (magick) not installed${reset}"
    return 1
  fi

  # With neither platform flag, generate both.
  local do_ios=1 do_android=1
  if has_flag "--ios" "$@" || has_flag "--android" "$@"; then
    has_flag "--ios" "$@" || do_ios=0
    has_flag "--android" "$@" || do_android=0
  fi

  local base="${logo:r}"
  local -A outputs
  ((do_ios)) && outputs[ios]="${base}-ios-1024.png"
  ((do_android)) && outputs[android]="${base}-android-512.png"

  local platform out
  for platform out in "${(@kv)outputs}"; do
    if [[ -e "$out" ]] && ! has_flag "-f" "$@"; then
      echo "${red}Skipping $out (exists, use -f to overwrite)${reset}"
      continue
    fi
    "gen_$platform" "$logo" "$out" || return 1
    echo "${green}✓${reset} $out ($(magick identify -format '%wx%h %[channels]' "$out"))"
  done
}

main "$@"
