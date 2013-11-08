#!/bin/bash
source $(dirname $0)/config.sh
XPOS="750"
WIDTH="200"
LINES="7"

playing=$(mpc current)
artist=$(mpc current -f  %artist%)
album=$(mpc current -f  %album%)
track=$(mpc current -f  %title%)
#stats=$(mpc stats)
#playlistcurrent=$(mpc playlist | grep -n "$playing" | cut -d ":" -f 1 | head -n1)
#nextnum=$(( $playlistcurrent + 1 ))
#prevnum=$(( $playlistcurrent - 1 ))
#next=$(mpc playlist | sed -n ""$nextnum"p")
#prev=$(mpc playlist | sed -n ""$prevnum"p")
#art=$(ls ~/.config/ario/covers | grep SMALL | grep $album)
art="/home/neg/.config/ario/covers/$(ls ~/.config/ario/covers | grep SMALL | grep "$(mpc current -f %album%)")"
perc=`mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}'`
 
percbar=`echo -e "$perc" | gdbar -bg $bar_bg -fg $foreground -h 1 -w $WIDTH`

#84x84
feh -x -B black -g +$(($XPOS-84))+$(($YPOS+12)) "$art" &
(echo "^fg($highlight)Music"; echo "^ca(1,/home/neg/bin/dzen/dzen_lyrics.sh) $track^ca()"; echo " ^ca(1,/home/neg/bin/dzen/dzen_artistinfo.sh)^fg()$artist^ca()";echo " ^ca(1,/home/neg/bin/dzen/dzen_albuminfo.sh)^fg()$album^ca()"; echo " "; echo "        ^ca(1, ncmpcpp prev)  ^fg($white0)^i(/home/neg/.dzen/prev.xbm) ^ca()  ^ca(1, ncmpcpp pause) ^i(/home/neg/.dzen/pause.xbm) ^ca()  ^ca(1, ncmpcpp play) ^i(/home/neg/.dzen/play.xbm) ^ca()   ^ca(1, ncmpcpp next) ^i(/home/neg/.dzen/next.xbm) ^ca()"; echo " "; echo $percbar; sleep 15) | dzen2 -fg $foreground -bg $background -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse,hide;button1=exit;button3=exit' & 
sleep 15
killall feh
