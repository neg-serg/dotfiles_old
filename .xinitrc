#!/bin/zsh
unset TMUX

. ~/.zsh/03-exports.zsh
${SCRIPT_HOME}/systemd_env_forwarding.zsh

hsetroot -fill \
${HOME}/pic/wl/wallhaven-334682.jpg

pulseaudio --start &
wmname Sawfish

local width_x11=$(xrandr -q |awk '/Screen/{print $8}')
local height_x11=$(xrandr -q | awk '/Screen/{print $10}' | awk -F"," '{print $1}')
swarp ${width_x11} ${height_x11}

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

if egrep -iq 'touchpad' /proc/bus/input/devices; then
    synclient PalmDetect=1
    synclient VertEdgeScroll=0 &
    synclient TapButton1=1 &
    synclient HorizTwoFingerScroll=1 &
    syndaemon -t -k -i 2 -d
    syndaemon -i 0.8 -d &
fi

setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -variant altgr-intl \
    -option ctrl:nocaps

xhost +localhost +local: +si:localuser:$(id -un)
xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50 m 1 1 b off

[[ -f ${HOME}/.Xresources ]] && \
    xrdb -load ${HOME}/.Xresources
[[ -f ${XDG_CONFIG_HOME}/keymaps/xmodmaprc ]] && \
    xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc

nexec dunst && dunst &
(urxvtd -q -f -o && ${BIN_HOME}/urxvt) &

nexec udiskie && udiskie -q &
inpath unclutter && unclutter --fork --timeout 1 &
nexec compton || sudo pkill compton
compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
nexec klay_watch && ${BIN_HOME}/mon/klay_watch &
${SCRIPT_HOME}/email_notifier.py --body &

rm -f "${SXHKD_FIFO}" && mkfifo "${SXHKD_FIFO}" && \
    nexec sxhkd && sxhkd -s "${SXHKD_FIFO}" &

systemctl --user restart gpaste

eval $(gpg-agent --daemon)

~/bin/bar_notifyd &
~/bin/scripts/get_logs

exec notion 2>> ~/tmp/notionerr$$ 2>&1
