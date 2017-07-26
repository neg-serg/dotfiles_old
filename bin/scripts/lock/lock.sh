#!/usr/bin/env bash

icon='/one/dev/src/hyperbeast/Scripts/lock.png'
tmpbg='/one/dev/src/hyperbeast/Scripts/lol.png'

(( $# )) && { icon=$1; }

scrot "${tmpbg}"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
# convert "${tmpbg}" -blur 0x6 "${tmpbg}"
convert "${tmpbg}" "$icon" -gravity center -composite -matte "${tmpbg}"

B='#00000000'  # blank
C='#00000070'  # clear ish
D='#0e3066cc'  # default
T='#ffffffee'  # text
W='#e02772bb'  # wrong
I='#b5bd2dbb'  # input
V='#ffffffbb'  # verifying

i3lock                \
--image=${tmpbg}        \
\
--insidecolor=${B}      \
--ringcolor=${D}        \
--linecolor=${B}        \
--separatorcolor=${B}   \
\
--insidevercolor=${C}   \
--ringvercolor=${D}     \
\
--insidewrongcolor=${C} \
--ringwrongcolor=$W   \
\
--textcolor=${T}        \
--timecolor=${T}        \
--datecolor=${T}        \
--keyhlcolor=${I}       \
--bshlcolor=${W}        \
#\
#--screen 0            \
#--blur 5              \
#--clock               \
#--indicator           \
#--timestr="%H:%M:%S"  \
#--datestr="%A, %m %Y" \
