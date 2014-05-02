# vim: ft=sh smc=80 cc= fdm=marker fen fmr=#<,#>:
#< output
#xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-0 --mode 1920x1080 --pos 1080x528 --rotate normal
#xrandr --output DVI-D-0 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-0 --mode 1920x1080 --rotate left --pos 1080x525 &
# xrandr --output DVI-D-0 --mode 1920x1080 --pos 1080x0 --rotate left --output HDMI-0 --mode 1920x1080 --rotate left --pos 0x0 &

# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
# xrandr --newmode "1600x900_59.90"  118.80  1600 1696 1864 2128  900 901 904 932  -HSync +Vsync
# xrandr --addmode LVDS-0 1600x900_59.90
# xrandr --output LVDS-0 --mode 1600x900_59.90
#>

# export LANG="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"
# export LC_CTYPE="en_US.UTF-8
# eval $(keychain --eval --agents ssh ~/.ssh/id_rsa)

# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto

# {
#   while xrandr --auto; do
#     sleep 5
#   done
# } &
xrandr --dpi 102
export my_elite_28='-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r'
# export _JAVA_AWT_WM_NONREPARENTING=1

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
# synclient TapButton1=1 HorizTwoFingerScroll=1 VertTwoFingerScroll=1
synclient PalmDetect=1

# sudo mkdir /var/run/lirc/
# sudo touch /var/run/lirc/lircd.pid
# sudo lircd --driver=alsa_usb --device=hw:S51
# irexec -d

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

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
# export GTK_IM_MODULE=xim
# export QT_IM_MODULE=xim

setxkbmap -option keypad:pointerkeys
setxkbmap -layout 'us,ru' -variant altgr-intl -option 'grp:alt_shift_toggle' -option ctrl:nocaps 
xhost +localhost

xbindkeys
xset m 1 1
xset r rate 200 50

hsetroot -fill /mnt/home/pic/wl/wallpaper-1767776.jpg
# disable trackpad while typing
syndaemon -t -k -i 2 -d

[ -f ${HOME}/.Xresources ] && xrdb   -merge ${HOME}/.Xresources
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "add mod3 = Caps_Lock"
[ -f ${HOME}/.config/keymaps/.xmodmaprc ] && xmodmap ${HOME}/.config/keymaps/.xmodmaprc

xset +fp $HOME/.fonts
xset +fp $HOME/.fonts/monobook-font-0.22/pcf
xset +fp $HOME/.fonts/elite
xset +fp "/usr/share/fonts/local/"
fc-cache

[ -x /usr/bin/dunst ] && dunst &

urxvtd -q -f -o
${HOME}/bin/urxvt
amixer -q set Master 0% mute
[ -z $(pidof udiskie) ]     && udiskie &
[ ! -x "`which parcellite 2>/dev/null`" ] ||  GTK2_RC_FILES=/home/neg/.config/gtk-2.0/gtkrc_parcellite parcellite &
[ ! -x "`which unclutter 2>/dev/null`"  ] ||  unclutter -idle 1 -reset -noevents &
~/bin/clipd.rb &
~/bin/scripts/email_notifier.py &
exec notion
