#!/bin/zsh

icon="$(readlink -f $(dirname $0)/lock.png)"
tmpbg="/tmp/lock_shot.png"

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

function take_shot(){
    case $1 in
        maim) magick convert "${tmpbg%%.png}.xwd" "${tmpbg}" ;;
        xdw) xwd -root -silent -out "${tmpbg%%.png}.xwd" ;;
        *) scrot "${tmpbg}" ;;
    esac
}

function make_blur(){
    case $1 in
        p*) magick convert "${tmpbg}" -scale 10% -scale 1000% "${tmpbg}";;
        *) magick convert "${tmpbg}" -blur 0x6 "${tmpbg}";;
    esac
}

function make_composition(){
    magick convert "${tmpbg}" "${icon}" -gravity center -composite -matte "${tmpbg}"
}

function main(){
    i3lock_setup_params
    (( $# )) && { icon=$1; shift }

    case $1 in
        imagemagick)
            take_shot
            make_blur
            make_composition ;;
        *)
            # gblur
            # histeq
            # negate
            # vignette

            hue_val=3
            resolution_=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
            ffmpeg -f x11grab -video_size "${resolution_}" -y -i ${DISPLAY} -i ${icon} \
                -filter_complex "boxblur=5,hue=s=${hue_val},overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
                -vframes 1 "${tmpbg}" 2> /dev/null
    esac

    i3lock "${i3lock_params[@]}"
    rm -f "${tmpbg}"
}

main "$@"
