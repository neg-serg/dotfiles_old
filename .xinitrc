#!/bin/zsh
/usr/bin/start-pulseaudio-x11

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
# eval $(keychain --eval --agents ssh ~/.ssh/id_rsa)

export my_elite_28='-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r'

wmname Sawfish
swarp  1920 1200
synclient PalmDetect=1

# mouse acceleration xset m 3/2 6
# disable mouse acceleration
xset 0 0
# xset dpms 0 0 0
xset dpms $DPMS_STANDBY $DPMS_SUSPEND $DPMS_OFF

setxkbmap -option keypad:pointerkeys
setxkbmap -layout 'us,ru' -variant altgr-intl -option 'grp:alt_shift_toggle' -option ctrl:nocaps 
setxkbmap -layout 'us,ru' -variant altgr-intl -option ctrl:nocaps 

(( ${QT_XFT} ))      || export QT_XFT=1
(( ${GDK_USE_XFT} )) || export GDK_USE_XFT=1

xhost +localhost
xhost +local:

xbindkeys
xset m 1 1
xset r rate 200 50
xset -b 
xset +fp $HOME/.fonts
xset +fp $HOME/.fonts/monobook-font-0.22/pcf
xset +fp $HOME/.fonts/elite
xset +fp "/usr/share/fonts/local/"
xset fp rehash

hsetroot -fill /home/neg/pic/wl/wallpaper-2585952.jpg
syndaemon -t -k -i 2 -d

[ -f ${HOME}/.Xresources ] && xrdb   -merge ${HOME}/.Xresources
[ -f ${HOME}/.config/keymaps/.xmodmaprc ] && xmodmap ${HOME}/.config/keymaps/.xmodmaprc

[ -x /usr/bin/dunst ] && dunst &
(urxvtd -q -f -o && ${HOME}/bin/urxvt)

[ -z $(pidof udiskie) ] && udiskie -q&
[ ! -x "`which unclutter 2>/dev/null`"  ] ||  unclutter -idle 1 -reset -noevents &
gpaste daemon
~/bin/mon/klay_watch &
~/bin/scripts/email_notifier.py &
exec notion
