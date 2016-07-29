#!/bin/zsh

function main(){
    font="Pragmata Pro for Powerline bold 12"
    mon_width_=$(xrandr -q |awk '/Screen/{print $8}')
    gap_="70"
    rofi_='rofi -font "${font}" -yoffset -22 -location 6 -width $((${mon_width_} - ${gap_})) -lines 10 -dmenu -p "[>>]"'
    artist_=$( mpc ls | eval ${rofi_})

    [[ ${artist_} == "" ]] && exit 1

    album_=$( echo -e "Play All\n$( mpc ls "${artist_}" )" | eval ${rofi_})
    if [[ ${album_} == "" ]]; then
        exit 1
    else
        if [[ ${album_} == "Play All" ]]; then
            mpc add "${artist_}"
        else
            mpc add "${album_}"
        fi
        mpc play
    fi

    exit 0
}

main "$@"

exit 0
