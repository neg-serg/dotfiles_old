#!/bin/zsh

icon="$(readlink -f $(dirname $0)/lock.png)"
tmpbg="$(readlink -f $(dirname $0)/lol.png)"

function circle_converter(){
    local file_ext="${1##*.}"
    convert "$1" \
        \( +clone -threshold -1 -negate -fill white -draw "circle 300,280 256,0" \) \
        -alpha off -compose copy_opacity -composite ${1%%file_ext}.gif
}

function i3lock_setup_params(){
    B='#00000000'  # blank
    C='#00000070'  # clear ish
    D='#0e3066cc'  # default
    T='#ffffffee'  # text
    W='#e02772bb'  # wrong
    I='#b5bd2dbb'  # input
    V='#ffffffbb'  # verifying

    i3lock_params=(
        --image=${tmpbg}
        --insidecolor=${B}
        --ringcolor=${D}
        --linecolor=${B}
        --separatorcolor=${B}
        --insidevercolor=${C}
        --ringvercolor=${D}
        --insidewrongcolor=${C}
        --ringwrongcolor=${W}
        --textcolor=${T}
        --timecolor=${T}
        --datecolor=${T}
        --keyhlcolor=${I}
        --bshlcolor=${W}
    )
}

function i3lock_add_clock(){
    i3lock_params+=(
        --clock
        --indicator
        --timestr="%H:%M:%S"
        --datestr="%A, %m %Y"
    )
}

function main(){
    i3lock_setup_params
    (( $# )) && { icon=$1; }
    scrot "${tmpbg}"
    case $1 in
        p*) convert "${tmpbg}" -scale 10% -scale 1000% "${tmpbg}";;
        *) convert "${tmpbg}" -blur 0x6 "${tmpbg}";;
    esac
    convert "${tmpbg}" "$icon" -gravity center -composite -matte "${tmpbg}"
    i3lock "${i3lock_params[@]}"
}

main "$@"
