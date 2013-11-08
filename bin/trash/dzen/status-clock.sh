#!/bin/bash

SP_LINES=8
SP_TW=66

source status-func.sh

{
# print_status_title 'Calendar'
day=$(date +%d)
day=${day#0}
# cal -3s | sed 's/\(.\{21\}.*\) '$day' \(.*.\{21\}\)/\1 ^fg(#a00)'$day'^fg() \2/;s/^/ /'
$@
echo '^uncollapse()'
} |
dzen2 \
	-bg $SP_BG -fg $SP_FG \
	-fn "$SP_FONT" -h $SP_LINE_HEIGHT \
	-x $SP_X -y $SP_Y \
	-w $SP_WIDTH -l $SP_LINES \
	-ta left \
	-e 'leaveslave=exit;button3=exit;button4=scrollup;button5=scrolldown' \
	-p
