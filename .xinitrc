#!/bin/zsh
unset TMUX
systemctl --user import-environment DISPLAY
pulseaudio --start &
wmname Sawfish

local width_x11=$(xrandr -q |awk '/Screen/{print $8}')
local height_x11=$(xrandr -q | awk '/Screen/{print $10}' | awk -F"," '{print $1}')
swarp ${width_x11} ${height_x11}

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

# configure touchpad
if egrep -iq 'touchpad' /proc/bus/input/devices; then
    synclient PalmDetect=1
    synclient VertEdgeScroll=0 &
    synclient TapButton1=1 &
    synclient HorizTwoFingerScroll=1 &
    syndaemon -t -k -i 2 -d
    syndaemon -i 0.8 -d &
fi

xset m 0 0 # disable mouse acceleration
xset dpms ${DPMS_STANDBY} ${DPMS_SUSPEND} ${DPMS_OFF}

setxkbmap -option keypad:pointerkeys -layout 'us,ru' -variant altgr-intl \
    -option 'grp:alt_shift_toggle' -option ctrl:nocaps \
    -option 'terminate:ctrl_alt_bksp'
#   -option 'compose:lctrl-altgr'

xhost +localhost +local:
xhost +si:localuser:$(id -un)
xhost +si:localuser:xdm

for WID in $(xwininfo -root -tree | \
    sed '/"plasma-desktop": ("Plasma" "Plasma")/!d; s/^  *\([^ ]*\) .*/\1/g'); do
   xprop -id ${WID} -remove _KDE_NET_WM_SHADOW
done

xbindkeys -n &
xset -b r rate 250 50 m 1 1 b off

# zsh ~/.local/wallpaper.sh &
hsetroot -fill ${HOME}/pic/wl/64738416.jpg

[[ -f ${HOME}/.Xresources ]] && xrdb -merge ${HOME}/.Xresources
[[ -f ${XDG_CONFIG_HOME}/keymaps/xmodmaprc ]] && xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc

nexec dunst && dunst &
(urxvtd -q -f -o && ${HOME}/bin/urxvt) &

nexec udiskie && udiskie -q &
inpath unclutter && unclutter --fork --timeout 1 &
compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf
nexec klay_watch && ~/bin/mon/klay_watch &
~/bin/scripts/email_notifier.py &
nexec stalonetray && stalonetray &

systemctl --user import-environment DISPLAY XAUTHORITY
if which dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

export SXHKD_FIFO=/tmp/sxhkd_fifo
rm -f "${SXHKD_FIFO}" && mkfifo "${SXHKD_FIFO}" && \
    nexec sxhkd && sxhkd -t 10 -s "${SXHKD_FIFO}" &

exec notion 2>> /tmp/notionerr$$ 2>&1
