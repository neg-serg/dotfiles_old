#!/bin/zsh
# font='fixed'
font='-misc-ohsnapu-medium-r-normal--14-101-100-100-c-70-iso10646-1'
[ ! -x "`which pulseaudio 2>/dev/null`" ] ||  pulseaudio --start                  
[ -z $(pidof mpd) ]                       && mpd ~/.mpdconf
[ -z $(pidof mpdscribble) ]               && mpdscribble
urxvtcd -fn $font -fb $font -fi $font -name mpd-pad -e ncmpcpp -c ~/.ncmpcpp/mini_conf &
