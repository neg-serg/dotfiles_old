#!/bin/zsh
# xrandr --dpi 102
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
# eval $(keychain --eval --agents ssh ~/.ssh/id_rsa)

export my_elite_28='-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r'

# Fix X window manager name properties to work around java bugs with
# non-reparenting window managers.  This is a different solution from
# the wmname utility provided by suckless, as it is NetWM compatible,
# while wmname sets the value of _NET_SUPPORTING_WM_CHECK to root win.

IRONIC_WM_NAME="LG3D"
NET_WIN=$(xprop -root _NET_SUPPORTING_WM_CHECK | awk -F "# " '{print $2}')

if [[ "$NET_WIN" == 0x* ]]; then
    # xprop cannot reliably set UTF8_STRING, so we replace as string.
    # fortunately, jdk is OK with this, but wm-spec says use UTF8_STRING.
    xprop -id "$NET_WIN" -remove _NET_WM_NAME
    xprop -id "$NET_WIN" -f _NET_WM_NAME 8s -set _NET_WM_NAME "$IRONIC_WM_NAME"
else
    # even if we're not net compatible, do java workaround
    xprop -root -remove _NET_WM_NAME
    xprop -root -f _NET_WM_NAME 8s -set _NET_WM_NAME "$IRONIC_WM_NAME"
fi

wmname LG3D
swarp  1600 900
synclient PalmDetect=1

# mouse acceleration
xset m 3/2 6
# xset dpms 0 0 0
xset dpms $DPMS_STANDBY $DPMS_SUSPEND $DPMS_OFF

#exec 3>&2 2>/dev/null

#echo 'keycode 58 = 1' >> /usr/local/share/kbd/caps_to_esc
#loadkeys -q /usr/local/share/kbd/caps_to_esc
# export GPG_AGENT_INFO

(( ${QT_XFT} ))      || export QT_XFT=1
(( ${GDK_USE_XFT} )) || export GDK_USE_XFT=1

setxkbmap -option keypad:pointerkeys
setxkbmap -layout 'us,ru' -variant altgr-intl -option 'grp:alt_shift_toggle' -option ctrl:nocaps 
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

hsetroot -fill /home/neg/pic/wl/wallpaper-2518591.jpg
# hsetroot -fill /mnt/home/pic/wl/wallpaper-1374496.jpg
# hsetroot -fill /mnt/home/pic/wl/wallpaper-1767776.jpg
# hsetroot -fill /mnt/home/pic/wl/763732248.jpg
# hsetroot -fill /mnt/home/pic/wl/wallpaper-2522969.jpg
# hsetroot -fill /mnt/home/pic/wl/wallpaper-921953.jpg
# disable trackpad while typing
syndaemon -t -k -i 2 -d

[ -f ${HOME}/.Xresources ] && xrdb   -merge ${HOME}/.Xresources
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "add mod3 = Caps_Lock"
[ -f ${HOME}/.config/keymaps/.xmodmaprc ] && xmodmap ${HOME}/.config/keymaps/.xmodmaprc

[ -x /usr/bin/dunst ] && dunst &
(urxvtd -q -f -o && ${HOME}/bin/urxvt)

# amixer -q set Master 0% mute
[ -z $(pidof udiskie) ] && udiskie -q&
# [ ! -x "`which parcellite 2>/dev/null`" ] ||  GTK2_RC_FILES=/home/neg/.config/gtk-2.0/gtkrc_parcellite parcellite &
[ ! -x "`which clipit 2>/dev/null`" ] ||  GTK2_RC_FILES=/home/neg/.config/gtk-2.0/gtkrc_parcellite clipit &
[ ! -x "`which unclutter 2>/dev/null`"  ] ||  unclutter -idle 1 -reset -noevents &
~/bin/clipd.rb &
~/bin/scripts/email_notifier.py &

# export __GL_SYNC_TO_VBLANK=1
# export __GL_SYNC_DISPLAY_DEVICE=DFP-0
# export __VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DFP-0

exec notion
