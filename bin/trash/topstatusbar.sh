#!/bin/bash
# Author: nnoell <nnoell3@gmail.com>
# Depends: dzen2-xft-xpm-xinerama-svn && conky
# Desc: dzen2 bar for XMonad, ran within xmonad.hs via spawnPipe

#Layout
BAR_H=9
BIGBAR_W=65
WIDTH_L=910
WIDTH_R=456 #WIDTH_L + WIDTH_R = 1366
HEIGHT=12
X_POS_L=0
X_POS_R=$WIDTH_L
Y_POS=2

#Colors and font
CRIT="#66ff66"
CRIT2="#9c0b42"
BAR_FG="#0148d4"
BAR_BG="#363636"
DZEN_FG="#9d9d9d"
DZEN_FG2="#444444"
DZEN_BG="#020202"
DZEN_BG2="#101010"
COLOR_SEP=$DZEN_FG2
FONT="-*-montecarlo-medium-r-normal-*-11-*-*-*-*-*-*-*"
ICONPATH="${HOME}/.icons/xbm_icons/subtle/"

#Conky
CONKYFILE="${HOME}/.config/conky/conkyrc"
IFS='|'
INTERVAL=1
CPUTemp=0
GPUTemp=0
CPULoad0=0
CPULoad1=0
CPULoad2=0
CPULoad3=0
MpdInfo=0
MpdRandom="Off"
MpdRepeat="Off"

#clickable areas
VOL_TOGGLE_CMD="sh ${HOME}/bin/voldzen.sh t"
VOL_UP_CMD="sh ${HOME}/bin/voldzen.sh +"
VOL_DOWN_CMD="sh ${HOME}/bin/voldzen.sh -"
DROP_START_CMD="dropbox start"
DROP_STOP_CMD="dropbox stop"
MPD_REP_CMD="mpc -h 127.0.0.1 repeat"
MPD_RAND_CMD="mpc -h 127.0.0.1 random"
MPD_TOGGLE_CMD="ncmpcpp toggle"
MPD_STOP_CMD="ncmpcpp stop"
MPD_NEXT_CMD="ncmpcpp next"
MPD_PREV_CMD="ncmpcpp prev"
CAL_CMD="sh ${HOME}/bin/dzencal.sh"

textBox() {
	echo -n "^fg("$3")^i("$ICONPATH"boxleft.xbm)^bg("$3")^fg("$2")"$1"^bg()^fg("$3")^i("$ICONPATH"boxright.xbm)^fg()"
}

printVolInfo() {
	local Perc=$(amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d '[]%')
	local Mute=$(amixer get Master | grep "Mono:" | awk '{print $6}')
	if [[ $Mute == "[off]" ]]; then
		textBox "^ca(1,$VOL_TOGGLE_CMD)^ca(4,$VOL_UP_CMD)^ca(5,$VOL_DOWN_CMD)VOLUME ^fg()${Perc}%^ca()^ca()^ca()" "" ${CRIT2}
	else
		textBox "^ca(1,$VOL_TOGGLE_CMD)^ca(4,$VOL_UP_CMD)^ca(5,$VOL_DOWN_CMD)VOLUME ^fg(${CRIT2})${Perc}%^ca()^ca()^ca()" ${DZEN_FG2} ${DZEN_BG2}
	fi
	return
}

printCPUInfo() {
	[[ $CPULoad0 -gt 70 ]] && CPULoad0="^fg($CRIT)$CPULoad0^fg()"
	[[ $CPULoad1 -gt 70 ]] && CPULoad1="^fg($CRIT)$CPULoad1^fg()"
	[[ $CPULoad2 -gt 70 ]] && CPULoad2="^fg($CRIT)$CPULoad2^fg()"
	[[ $CPULoad3 -gt 70 ]] && CPULoad3="^fg($CRIT)$CPULoad3^fg()"
	textBox "CPU ^fg($BAR_FG)${CPULoad0}%^fg($DZEN_FG2)/^fg($BAR_FG)${CPULoad1}%^fg($DZEN_FG2)/^fg($BAR_FG)${CPULoad2}%^fg($DZEN_FG2)/^fg($BAR_FG)${CPULoad3}%" ${DZEN_FG2} ${DZEN_BG2}
	return
}

printTempInfo() {
	local CPUTemp0=$(acpi --thermal  | grep "0:" | awk '{print substr($4,0,2)}')
	local CPUTemp1=$(acpi --thermal  | grep "1:" | awk '{print substr($4,0,2)}')
	[[ $CPUTemp0 -gt 70 ]] && CPUTemp0="^fg($CRIT)$CPUTemp0^fg()"
	[[ $CPUTemp1 -gt 70 ]] && CPUTemp1="^fg($CRIT)$CPUTemp1^fg()"
	textBox "TEMP ^fg($BAR_FG)${CPUTemp0}°^fg($DZEN_FG2)/^fg($BAR_FG)${CPUTemp1}°" ${DZEN_FG2} ${DZEN_BG2}
	return
}

printMemInfo() {
	[[ $MemPerc -gt 70 ]] && CPUTemp="^fg($CRIT)$MemPerc^fg()"
	textBox "MEM ^fg($BAR_FG)${MemPerc}%" ${DZEN_FG2} ${DZEN_BG2}
	return
}

printDropBoxInfo() {
	if [[ $(ps -A | grep -c dropbox) == "0" ]]; then
		textBox "^ca(1,$DROP_START_CMD)DROPBOX ^fg()Off^ca()" ${DZEN_FG2} ${DZEN_BG2}
	else
		textBox "^ca(1,$DROP_STOP_CMD)DROPBOX ^fg($CRIT)On^ca()" ${DZEN_FG2} ${DZEN_BG2}
	fi
	return
}

printMpdInfo() {
	if [[ $(ps -A | grep -c mpd) == "0" ]]; then
		textBox "^ca(1,mpd)MPD^ca() ^fg()Off" ${DZEN_FG2} ${DZEN_BG2}
	else
		[[ $MpdRepeat == "On" ]] && MpdRepeat="^fg($CRIT)$MpdRepeat^fg()"
		[[ $MpdRandom == "On" ]] && MpdRandom="^fg($CRIT)$MpdRandom^fg()"
		textBox "^ca(1,$MPD_REP_CMD)REPEAT^ca() ^fg()$MpdRepeat" ${DZEN_FG2} ${DZEN_BG2}
		textBox "^ca(1,$MPD_RAND_CMD)RANDOM^ca() ^fg()$MpdRandom" ${DZEN_FG2} ${DZEN_BG2}
		textBox "^ca(1,$MPD_TOGGLE_CMD)^ca(3,$MPD_STOP_CMD)^ca(4,$MPD_NEXT_CMD)^ca(5,$MPD_PREV_CMD)MPD $MpdInfo^ca()^ca()^ca()^ca()" ${DZEN_FG2} ${DZEN_BG2}
	fi
	return
}

printDateInfo() {
	textBox "^ca(1,$CAL_CMD)^fg()$(date '+%Y^fg(#444).^fg()%m^fg(#444).^fg()%d^fg(#444)/^fg(#9c0b42)%a ^fg()%H^fg(#444):^fg()%M^fg(#444):^fg()%S')^ca()" ${DZEN_FG2} ${DZEN_BG2}
	return
}

printLeft() {
	while true; do
		read CPULoad0 CPULoad1 CPULoad2 CPULoad3 CPUFreq MemUsed MemPerc MpdInfo MpdRandom MpdRepeat
		printVolInfo
		printDropBoxInfo
		printMpdInfo
		echo
	done
	return
}

printRight() {
	while true; do
		read CPULoad0 CPULoad1 CPULoad2 CPULoad3 CPUFreq MemUsed MemPerc MpdInfo MpdRandom MpdRepeat
		printCPUInfo
		printMemInfo
		printTempInfo
		printDateInfo
		echo
	done
	return
}

#Print all and pipe into dzen
conky -c $CONKYFILE -u $INTERVAL | printLeft | dzen2 -x $X_POS_L -y $Y_POS -w $WIDTH_L -h $HEIGHT -fn $FONT -ta 'l' -bg $DZEN_BG -fg $DZEN_FG -p -e 'onstart=lower' &
conky -c $CONKYFILE -u $INTERVAL | printRight | dzen2 -x $X_POS_R -y $Y_POS -w $WIDTH_R -h $HEIGHT -fn $FONT -ta 'r' -bg $DZEN_BG -fg $DZEN_FG -p -e 'onstart=lower'
