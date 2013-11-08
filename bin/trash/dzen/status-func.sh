read _ _ S_WIDTH S_HEIGHT _ <<< "$(xprop -root | sed '/_NET_WORKAREA(CARDINAL)/ {s/[^0-9 ]//g;q} ; d')"

# Default values
################

# status

BG='#303030'
FG='#aaa'
FONT='Envy Code R-9'

# status popup

SP_BG='#222'
SP_FG='#aaa'
SP_FONT_PIXELSIZE=16
SP_FONT="-xos4-terminus-medium-r-normal-*-14-*-*-*-c-*-iso10646-1"

SP_LINE_HEIGHT=$((SP_FONT_PIXELSIZE+4))

SP_LINES=${SP_LINES:-20}
SP_TW=${SP_TW:-80}

SP_WIDTH=$(((SP_TW)*(SP_FONT_PIXELSIZE/2+1)))
SP_HEIGHT=$((SP_LINE_HEIGHT*(SP_LINES+1)))
SP_X=$((S_WIDTH-SP_WIDTH))
SP_Y=$((S_HEIGHT-SP_HEIGHT))

# Functions
###########

print_status_title () {
	echo "^fg(#303030)^r(${SP_WIDTH}x${SP_LINE_HEIGHT})^p(_LEFT)^p(+1;+1)^fg(#000)^bg(#303030)$1^p(_LEFT)^ib(1)^fg(#f00)$1^fg()^bg()"
}

used_color () {
	# used_color v [max] [color_max] [min]
	local v=$1
	local max=${2:-100}
	[[ "$v" -gt "$max" ]] && v=$max
	# 176 = aa
	local color_max=${3:-176}
	local min=${4:-0}
	[[ "$v" -lt "$min" ]] && v=$min
	local c
	printf -v c "%02x" $((color_max-(v-min)*color_max/(max-min)))
	printf -v color "#%02x$c$c" $color_max
}
