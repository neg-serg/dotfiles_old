#!/bin/zsh
unset TMUX

local pic_wl_=${HOME}/pic/wl

. ~/.zsh/03-exports.zsh
${SCRIPT_HOME}/systemd_env_forwarding.zsh

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
    #xinput set-prop "Primax Kensington Eagle Trackball" "Evdev Middle Button Emulation" 0
fi

xset m 0 0 # disable mouse acceleration
xset dpms ${DPMS_STANDBY} ${DPMS_SUSPEND} ${DPMS_OFF}

setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -variant altgr-intl \
    -option 'grp:alt_shift_toggle' \
    -option ctrl:nocaps \
    -option 'terminate:ctrl_alt_bksp'

xhost +localhost +local: +si:localuser:$(id -un)
xset -b r rate 250 50 m 1 1 b off

hsetroot -fill ${pic_wl_}/kosmos_planeta_svet_noch_nebo_94442_2400x1350.jpg &

[[ -f ~/.Xresources ]] && \
    xrdb -load ~/.Xresources
[[ -f ${XDG_CONFIG_HOME}/keymaps/xmodmaprc ]] && \
    xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc

nexec dunst && dunst &
(urxvtd -q -f -o && ${HOME}/bin/urxvt) &

nexec udiskie && udiskie -q &
inpath unclutter && unclutter --fork --timeout 1 &
sudo pkill compton && \
    compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
nexec klay_watch && ~/bin/mon/klay_watch &
${SCRIPT_HOME}/email_notifier.py &

nexec stalonetray && \
    stalonetray -c ${XDG_CONFIG_HOME}/stalonetrayrc &

rm -f "${SXHKD_FIFO}" && mkfifo "${SXHKD_FIFO}" && \
    nexec sxhkd && sxhkd -s "${SXHKD_FIFO}" &

systemctl --user restart gpaste
exec notion 2>> /tmp/notionerr$$ 2>&1
