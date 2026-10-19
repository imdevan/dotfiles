#!/bin/sh

function agy_window() {
    suffix_window "${1:-agy}" "-a"
}
alias aw="agy_window"

function claude_window() {
    suffix_window "${1:-cl}" "-c"
}
alias cw="claude_window"

function kiro_window() {
    suffix_window "${1:-kl}" "-k"
}
alias kw="kiro_window"


function backend_window() {
    suffix_window "cd app/backend" "-b"
}

alias bw="backend_window"

function expo_window() {
    suffix_window "cd app/expo" "-b"
}
alias ew="expo_window"

function dev_window() {
    suffix_window "bun run dev" "-d"
}
alias dw="dev_window"

function lazy_window() {
    suffix_window "${1:-lg}" "-lg"
}
alias lw="lazy_window"

function cow_window() {
    suffix_window "${1:-cowsay 'hi'}" "cow"
}

alias coww="cow_window"

