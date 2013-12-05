#! /bin/zsh
local START_COLOR=0
local END_COLOR=255
local LINE_LENGTH=16
local i=$START_COLOR
local only_block=0
[ $# -gt 0 ] && [ $@ = '-b' ] && only_block=1
printf '\n'
while [ $i -le $END_COLOR ]; do
    if [ $only_block -eq 1 ] ; then printf "\033[38;5;${i}m%s" '█'; else printf "\033[38;5;${i}m%s%03u" '■' $i;fi
    [ $(((i - START_COLOR + 1) % LINE_LENGTH)) -eq 0 -a $i -gt $START_COLOR ] && printf '\n'
    i=$((i + 1))
done
printf '\033[0m\n\n'
