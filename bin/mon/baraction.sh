#!/bin/bash

# Output a one-line meter with overlapping bars. Good for values that tend to stack.
# Usage: print_meter left right total_len blank_char [(len char) (len char) ...]
# Ex:	$ print_meter [ ] 10 _ 8 X 2 b 5 =
#		[bb===XXX__]
# A "character" may be multiple chars long, but it will only count as one.
# Apply color shell escapes to make pretty bars and impress women.
function print_meter() {
	# Mandatory shit
	left_end="${1-[}"; shift
	right_end="${1-]}"; shift
	total_len=${1-10}; shift
	blank_char="${1- }"; shift

	# Loop over bars to establish a sorted order
	declare -a indices
	while [ -n "$1" ]; do
		len=$1
		char="$2"
		shift 2
		indices[$len]=$char
	done

	echo -ne "$left_end"
	count=0

	# Print bars, shortest first
	for i in ${!indices[@]}; do
		for ((; count < i; count++)); do
			echo -ne "${indices[$i]}"
		done
	done

	# Pad with blanks
	for ((; count < total_len; count++)); do
		echo -ne "$blank_char"
	done

	echo -ne "$right_end"
}

function volume_level() {
	local scale=$1 # Maximum value to report, scale output up to this level.
	local volume

	volume=$(amixer get Master | tail -n1 | grep -o '[[:digit:]]\+%]')
	volume=${volume%\%]} # Percentage, 0..100
	volume=$(( $volume * $scale / 100 ))
	echo -ne $volume
}

function volume_muted() {
	# Return 0 on mute.
	amixer get Master | tail -n1 | grep 'off' &> /dev/null
	return $?
} 

function volume_print_meter() {
	#r="\033[0;1;31m"
	#g="\033[0;1;32m"
	#n="\033[0;0;0m"
	left_end='[vol '
	right_end=']'
	on_muted='m'
	off_muted=' '
	on_unmuted='='
	off_unmuted=' '
	scale=10
	level=$(volume_level $scale)
		
	if volume_muted; then
		on_char="$on_muted"
		off_char="$off_muted"
		left_end="$r$left_end"
		right_end="$right_end$n"
	else
		on_char="$on_unmuted"
		off_char="$off_unmuted"
		left_end="$g$left_end"
		right_end="$right_end$n"
	fi

	print_meter "$left_end" "$right_end" $scale "$off_char" $level "$on_char" 
}

function battery_print_meter() {
	#r="\033[0;1;31m"
	#g="\033[0;1;32m"
	#n="\033[0;0;0m"
	left_end='[bat '
	right_end=']'
	on_charge='+'
	off_charge=' '
	on_discharge='-'
	off_discharge=' '
	scale=10

	# Probably not very portable. Consider checking for mains power separately.
	. /sys/class/power_supply/BAT0/uevent # Conveniently in shell-readable format.

	max=$POWER_SUPPLY_CHARGE_FULL
	now=$POWER_SUPPLY_CHARGE_NOW
	level=$(( $now * $scale / $max ))

	if [ "$POWER_SUPPLY_STATUS" = "Discharging" ]; then
		on_char="$on_discharge"
		off_char="$off_discharge"
		left_end="$r$left_end"
		right_end="$right_end$n"
	else
		on_char="$on_charge"
		off_char="$off_charge"
		left_end="$g$left_end"
		right_end="$right_end$n"
	fi

	print_meter "$left_end" "$right_end" $scale "$off_char" $level "$on_char"  
}

function ram_print_meter() {
	#r="\033[0;1;31m"
	#g="\033[0;1;32m"
	#y="\033[0;1;33m"
	#n="\033[0;0;0m"
	width=10
	left='[ram '
	right=']'
	blank="$g $n"
	used_char="$y+$n"
	realused_char="$r=$n"

	total=$(grep MemTotal /proc/meminfo | grep -o "[[:digit:]]*")
	free=$(grep MemFree /proc/meminfo | grep -o "[[:digit:]]*")
	buffers=$(grep Buffers /proc/meminfo | grep -o "[[:digit:]]*")
	cached=$(grep ^Cached /proc/meminfo | grep -o "[[:digit:]]*")

	used=$(( $total - $free ))
	realused=$(( $used - $buffers - $cached ))

	uc=$(( $used * $width / $total ))
	ruc=$(( $realused * $width / $total ))

	print_meter "$left" "$right" $width "$blank" $uc "$used_char" $ruc "$realused_char"
}

function coretemp_print() {
	#n="\033[0;0;0m" # normal/plaintext
	#g="\033[0;1;32m" # ok
	#y="\033[0;1;33m" # hot
	#r="\033[0;1;31m" # try to turn it down a bit
	#crit="\033[1;5;31m" # turn it off fucking now

	ok=67
	hot=71
	thegogglestheydonothing=78 # Hardware-defined crit is 90, I'm not that adventurous.

	temp=$(( $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))

	if [ $temp -lt $ok ]; then color="$g";
	elif [ $temp -lt $hot ]; then color="$y";
	elif [ $temp -lt $thegogglestheydonothing ]; then color="$r";
	else color="$crit"; fi

	echo -ne "${color}TEMP $temp$n"
}

function allstatus_print() {
	# Intended for 100 char width
	vol=$(volume_print_meter)
	bat=$(battery_print_meter)
	ram=$(ram_print_meter)
	temp=$(coretemp_print)
	echo -ne "$vol $bat $ram $temp"
}

case "$1" in
	volume)
		volume_print_meter
	;;
	battery)
		battery_print_meter
	;;
	ram)
		ram_print_meter
	;;
	temp)
		coretemp_print
	;;
	*)
		while true; do
			allstatus_print
			echo
			sleep 2
		done
	;;
esac
