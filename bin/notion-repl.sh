#!/usr/sbin/rlwrap zsh

printf "[lua >>] "
while read x; do
    # if [[ $x =~ '/^\s*([a-zA-Z_0-9]+)\s*=(.*)/' ]]; then
    notionflux -e "${x}"
    # fi
    printf "[lua >>] "
done < "${1:-/dev/stdin}"
