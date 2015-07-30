#/bin/bash

FG='#dcdcdc'
BG='#333333'

font1="Inconsolata:size=11"

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

next_month=`date --date='+1 month' +'%m %Y'`
prev_month=`date --date='-1 month' +'%m %Y'`

day_year=$(date +'%j')
week_year=$(date +'%V')

cal_p_m=`cal $prev_month | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#875f87)^bg(#222222) \1 /"`
cal_c_m=`cal | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#f0f0f0)^bg(#875f87) \1 /;
s/(^|[ ])($TODAY)($|[ ])/\1^bg(#875f87)^fg(#222222)\2^fg(#6c6c6c)^bg(#222222)\3/"`
cal_n_m=`cal $next_month | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#875f87)^bg(#222222) \1 /"`

(
echo "
^fg(#e2abd4)^fn(Inconsolata:bold:size=11)Time & Date
"
echo "$cal_p_m
"
echo "$cal_c_m
"
echo "$cal_n_m
"
# current month, hilight header and today
echo "Current day of the year: $day_year"
echo "Current week of the year: $week_year"
echo ""

) | dzen2 -p -x 347 -y 28 -w 235 -bg $BG -fg $FG -l 33 -sa c -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1