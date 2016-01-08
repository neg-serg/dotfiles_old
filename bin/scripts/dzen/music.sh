#!/bin/bash
source ./config.sh
xpos=$((1180 + ${xoffset}))
width="380"
lines="8"

playing=$(mpc current)
artist=$(mpc current -f  %artist%)
album=$(mpc current -f  %album%)
track=$(mpc current -f  %title%)
date=$(mpc current -f  %date%)
#stats=$(mpc stats)
#playlistcurrent=$(mpc playlist | grep -n "$playing" | cut -d ":" -f 1 | head -n1)
#nextnum=$(( $playlistcurrent + 1 ))
#prevnum=$(( $playlistcurrent - 1 ))
#next=$(mpc playlist | sed -n ""$nextnum"p")
#prev=$(mpc playlist | sed -n ""$prevnum"p")
#art=$(ls ~/.config/ario/covers | grep SMALL | grep $album)
art="${HOME}/.config/ario/covers/$(ls ~/.config/ario/covers | grep -v SMALL | grep "$(mpc current -f %album% | sed 's/:/ /g')")"
perc=$(mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}')
percbar=$(echo -e "${perc}" | gdbar -bg ${bar_bg} -fg ${foreground} -h 1 -w $[${width}-20])

feh -x -B black -^ "" -g 108x108+$[${xpos}-108]+$[$ypos+12] -Z "${art}" &
(echo "^fg(${hi})Music"; echo "       ";echo "^ca(1,${HOME}/bin/scripts/dzen/dzen_lyrics.sh)  Track:  ^fg(${hi})${track}^ca()"; echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_artistinfo.sh)^fg()  Artist: ^fg(${hi})${artist}^ca()";echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_albuminfo.sh)^fg()  Album:  ^fg(${hi})${album}^ca()"; echo "^ca(1,/home/sunn/.xmonad/scripts/dzen_lyrics.sh)  Year:   ^fg(${hi})${date}^ca()"; echo "  ${percbar}"; echo "      ^ca(1, ncmpcpp prev)  ^fg(${white0})^i(/home/sunn/.xmonad/dzen2/prev.xbm) ^ca()  ^ca(1, ncmpcpp pause) ^i(/home/sunn/.xmonad/dzen2/pause.xbm) ^ca()  ^ca(1, ncmpcpp play) ^i(/home/sunn/.xmonad/dzen2/play.xbm) ^ca()   ^ca(1, ncmpcpp next) ^i(/home/sunn/.xmonad/dzen2/next.xbm) ^ca()"; echo " "; sleep 15) | dzen2 -fg ${fg} -bg ${bg} -fn "${font}" -x ${xpos} -y ${ypos} -w ${width} -l ${lines} -e 'onstart=uncollapse,hide;button1=exit;button3=exit' & 
sleep 15
killall feh
