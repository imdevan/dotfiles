#!/bin/zsh
kill $(ps -eo pid,%mem --sort=-%mem | awk 'NR==2{print $1}')
kill $(ps -eo pid,%cpu --sort=-%cpu | awk 'NR==2{print $1}')
