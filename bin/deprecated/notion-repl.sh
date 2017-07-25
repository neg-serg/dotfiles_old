#!/usr/sbin/rlwrap zsh

autoload colors && colors
. ~/.zsh/03-helpers.zsh

builtin printf "$(_zwrap "NotionFlux >>") "
while read x; do
    # if [[ $x =~ '/^\s*([a-zA-Z_0-9]+)\s*=(.*)/' ]]; then
    notionflux -e "${x}"
    # fi
    builtin printf "$(_zwrap "NotionFlux >>") "
done < "${1:-/dev/stdin}"
