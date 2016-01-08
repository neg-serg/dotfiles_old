#!/bin/bash
source ./config.sh
xpos=$[950 + ${xoffset}]
width="400"

url="http://makeitpersonal.co/lyrics?artist=$(mpc current -f %artist% | sed 's/ /%20/g')&title=$(mpc current -f %title% | sed 's/ /%20/g')"
lyrics=$(curl -s "$url" | fold -sw 60)
lyricslines=$(curl -s "$url" | fold -sw 60 | wc -l)
lines=$[${lyricslines} + 3]

[[ ${lines} -gt 60 ]] && lines=60

(echo "^fg(${hi})Music Info "; echo "^fg(${hi}) Lyrics"; echo "${lyrics}"; echo " "; sleep 15) | dzen2 -fg ${fg} -bg ${bg} -fn "${font}" -x ${xpos} -y ${ypos} -w ${width} -l ${lines} -e 'onstart=uncollapse,hide;button1=exit;button3=exit;button4=scrollup;button5=scrolldown;'
