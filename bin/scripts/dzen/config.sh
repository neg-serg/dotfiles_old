#!/bin/bash

background="#000000"
foreground="#666666"
highlight="#aaaabb"

#XPOS=$(xdotool getmouselocation | awk -F " " '{print $1}' | cut -d ":" -f 2)
YPOS="11"
HEIGHT="12"
XOFFSET=554
if [[ -z `xrandr | grep " connected" | grep 'VGA'` ]]; then
	XOFFSET="0"
fi

FONT="PragmataPro for Powerline:style=bold:size=10"
white0="#775759"

bar_bg="#1f1f1f"
bar_fg="#d17b49"
notify="#d17b49"
warning="#d17b49"
