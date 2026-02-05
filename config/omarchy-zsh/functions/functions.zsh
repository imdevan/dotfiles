# disable omarchy default cd fancy-ness
# Zoxide cd wrapper
# Todo: decide if i want to keep this
# function  zd() {
# if [ $# -eq 0 ]; then
  # builtin cd ~ && return
# elif [ -d "$1" ]; then
  # builtin cd "$1"
# else
  # z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
# fi
# }
# alias cd="zd"

# Open files with xdg-open
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Compression
function compress() {
  tar -czf "${1%/}.tar.gz" "${1%/}"
}

alias decompress="tar -xzf"

# Transcode a video to a good-balance 1080p
transcode-video-1080p() {
  ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}

# Transcode a video to a good-balance 4K
transcode-video-4K() {
  ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}

# Transcode any image to JPG
img2jpg() {
  magick $1 -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to small JPG
img2jpg-small() {
  magick $1 -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
}

# Transcode any image to compressed PNG
img2png() {
  magick "$1" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${1%.*}.png"
}
