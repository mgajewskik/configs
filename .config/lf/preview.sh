#!/bin/zsh

bat \
    --force-colorization \
    --paging=never \
    --style=changes \
    --theme "ansi" \
    --terminal-width $(($2 - 3)) "$1"
