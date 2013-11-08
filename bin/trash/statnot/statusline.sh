#!/bin/bash
# colours: 01:normal 02:white 03:red 04:green 05:yellow 06:blue 07:cyan 08:magenta 09:grey

bat(){
    ac="$(awk 'NR==1 {print +$4}' <(acpi -V))"
    onl="$(grep "on-line" <(acpi -V))"
	if [ -z "$onl" ] && [ "$ac" -gt "15" ]; then
		echo -e "BAT \x07$ac%\x01"
	elif [ -z "$onl" ] && [ "$ac" -le "15" ]; then
		echo -e "BAT \x03$ac%\x01"
	else
		echo -e "AC \x07$ac%\x01"
	fi
}

mem(){
    mem="$(awk '/^-/ {print $3}' <(free -m))"
	echo -e "\x04$mem\x01"
}

   # CPU line courtesy Procyon:https://bbs.archlinux.org/viewtopic.php?pid=874333#p874333
cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
	echo -e "\x05$cpu%\x01"
}

hdd(){
	hd="$(df -P | sort -d | awk '/^\/dev/{s=s (s?" ":"") $5} END {printf "%s", s}')"
	echo -e "\x08$hd\x01"
}

eml(){
	maildirs="$HOME/Mail/*/INBOX/new/"
	ml="$(find $maildirs -type f | wc -l)"
	if [ $ml == 0 ]; then
		echo "0"
	else
		echo -en "\x03$ml\x01"
	fi
}

pac(){
	pup="$(pacman -Qu | wc -l)"
	if [ $pup == 0 ]; then
	    echo "0"
	else
	    echo -en "\x05$pup\x01"
	fi
}

int(){
	host google.com>/dev/null && 
    echo -e "\x06ON\x01" || echo -e "\x03NO\x01"
}

dte(){
	dte="$(date "+%I:%M")"
	echo -e "$dte"
}

if [ $# -eq 0 ]; then
   # Pipe to status bar
    echo -e "[$(bat)] [$(cpu) $(mem)] [$(hdd)] [EML $(eml) PKG $(pac)] [NET $(int)] \x02$(dte)\x01 "
else
    echo -e "\x03[!] \x09$1\x01  $(dte) "
fi
