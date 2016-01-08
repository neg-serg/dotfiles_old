#!/bin/bash

bg="#000000"
fg="#666666"
hi="#aaaabb"

#XPOS=$(xdotool getmouselocation | awk -F " " '{print $1}' | cut -d ":" -f 2)
ypos="11"
height="12"
xoffset=554
if [[ -z $(xrandr | grep " connected" | grep 'VGA') ]]; then
	xoffset="0"
fi

font="PragmataPro for Powerline:style=bold:size=10"
white0="#775759"

bar_bg="#1f1f1f" bar_fg="#d17b49"
notify="#d17b49" warning="#d17b49"
