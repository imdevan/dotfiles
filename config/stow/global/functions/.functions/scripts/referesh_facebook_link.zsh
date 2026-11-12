#!/usr/bin/env zsh

# Script: referesh_facebook_link
# Description: Refresh the facebook link preview for a url
# Usage: referesh_facebook_link <url>
# Alias: rfl

function referesh_facebook_link() {
    curl `https://developers.facebook.com/tools/lint/?url=${1}&format=json`
}

referesh_facebook_link "$@"
