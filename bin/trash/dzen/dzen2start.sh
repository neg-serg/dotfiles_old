#!/bin/zsh
# media/date bar at far right.
while true; do
  echo "^fg(#8c8b8e)$(date '+%Y^fg(#444).^fg()%m^fg(#444).^fg()%d^fg(#007b8c)/^fg(#5f656b)%j ^fg(#a488d9)| ^fg()%H^fg(#444):^fg()%M^fg(#444):^fg()%S') "
  sleep 1
done | dzen2 -dock -u -mv -x '626' -y '0' -h '13' -w '740' -ta 'r' -bg '#161616' -fg '#8c8b8e' -fn '-*-fixed-medium-r-normal-*-10-*-*-*-*-*-*-*' &
# top-center to the right of xmonad's.
while true; do
  echo "^fg(#515056)totalWindows: ^fg()$(lsw|awk ' !x[$0]--'|grep -v "GLiv\|Firefox\| - Downloads"|wc -l) ^fg(#007b8c)| \
^fg()$(cat /proc/loadavg|sed 's/ [0-9]\/.*$//;s/\./'"^fg(#5f656b)"'&'"^fg()"'/g') ^fg(#007b8c)| ^fg()\
$(df -h|grep "sda2\|sda5\|sda3"|awk '{print "^fg(#5f656b)"$4"^fg(#050505)""""|^fg(#444)"$5" "}'|tr -d '\n')"\
"^fg(#007b8c)| ^fg(#515056)^fg()" \
"^fg() ^fg(#a488d9)>""^fg(#007b8c)>""^fg(#444444)>"
  sleep 1
done | dzen2 -dock -u -x '0' -w '496' -y '0' -h '13' -ta 'l' -bg '#161616' -fg '#8c8b8e' -fn '-*-fixed-medium-r-normal-*-10-*-*-*-*-*-*-*' &
