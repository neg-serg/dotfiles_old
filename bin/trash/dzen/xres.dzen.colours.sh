#!/bin/bash

# read xresource colors to array "xrdb"
xrdb=( $(xrdb -query | grep -P "color[0-9]*:" | sort | cut -f 2-) )

# `sort` doesn't quite sort ascending, it sorts "0, 10, 11, 12, ..., 1, 2, 3, ...", so we need to fix.
# while we're at it, we might as well use proper names.

# define array "color" (actually a hash table)
declare -A color

# need this to get the values from xrdb one by one
index=0

# loop over color names
for name in black brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite red green yellow blue magenta cyan white grey brightred; do
	# assign color value from array xrdb to hash "color"
	color[${name}]=${xrdb[$index]}
	# increase "index" by one, so we get the next color value for the next iteration
	((index++))
done

# Just some display demo from here on...
for name in black brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite red green yellow blue magenta cyan white grey brightred; do
	echo -n "^bg(${color[${name}]}) "
done

echo -n "^bg()"

echo -n "^fg(${color['black']}) black "
echo -n "^fg(${color['red']}) red "
echo -n "^fg(${color['green']}) green "
echo -n "^fg(${color['yellow']}) yellow "
echo -n "^fg(${color['blue']}) blue "
echo -n "^fg(${color['magenta']}) magenta "
echo -n "^fg(${color['cyan']}) cyan "
echo -n "^fg(${color['white']}) white "

echo -n "^fg(${color['grey']}) grey "
echo -n "^fg(${color['brightred']}) brightred "
echo -n "^fg(${color['brightgreen']}) brightgreen "
echo -n "^fg(${color['brightyellow']}) brightyellow "
echo -n "^fg(${color['brightblue']}) brightblue "
echo -n "^fg(${color['brightmagenta']}) brightmagenta "
echo -n "^fg(${color['brightcyan']}) brightcyan "
echo -n "^fg(${color['brightwhite']}) brightwhite "

echo
