#!/bin/zsh
unset TMUX

systemctl --user import-environment DISPLAY
pulseaudio --start &
wmname Sawfish

local width_x11=`xrandr -q | grep Screen | awk '{ print $8 }'`
local height_x11=`xrandr -q | grep Screen | awk '{ print $10 }' | awk -F"," '{ print $1 }'`
swarp ${width_x11} ${height_x11}

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

synclient PalmDetect=1
syndaemon -t -k -i 2 -d

xset m 0 0 # disable mouse acceleration
xset dpms ${DPMS_STANDBY} ${DPMS_SUSPEND} ${DPMS_OFF}

setxkbmap -option keypad:pointerkeys -layout 'us,ru' \
    -variant altgr-intl -option 'grp:alt_shift_toggle' -option ctrl:nocaps 

xhost +localhost +local:

xbindkeys -n &
xset -b r rate 200 50 m 1 1

# zsh ~/.local/wallpaper.sh &
hsetroot -fill ${HOME}/pic/wl/blame-green-1920x1080.png

[[ -f ${HOME}/.Xresources ]] && xrdb -merge ${HOME}/.Xresources
[[ -f ${HOME}/.config/keymaps/xmodmaprc ]] && xmodmap ${HOME}/.config/keymaps/xmodmaprc

nexec && dunst &
(urxvtd -q -f -o && ${HOME}/bin/urxvt) &

nexec udiskie && udiskie -q &
inpath unclutter && unclutter --fork --timeout 1 &
gpaste daemon
nexec klay_watch && ~/bin/mon/klay_watch &
~/bin/scripts/email_notifier.py &
compton -b --config ~/.config/compton/compton.conf
exec notion 2>> /tmp/notionerr$$ 2>&1
