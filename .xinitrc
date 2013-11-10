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
# export LC_CTYPE="en_US.UTF-8" 
# eval $(keychain --eval --agents ssh ~/.ssh/id_rsa)

# [ -z $(pidof mpd) ]                       && mpd 
# [ -z $(pidof mpdscribble) ]               &&  mpdscribble --conf ~/.config/mpdscribble/neg/mpdscribble.conf     &
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
export my_elite_28='-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r'
# export _JAVA_AWT_WM_NONREPARENTING=1 
wmname LG3D
swarp  1600 900
synclient TapButton1=1 HorizTwoFingerScroll=1 VertTwoFingerScroll=1

# sudo mkdir /var/run/lirc/
# sudo touch /var/run/lirc/lircd.pid  
# sudo lircd --driver=alsa_usb --device=hw:S51 
# irexec -d
  
# mouse acceleration
xset m 3/2 6
xset dpms $DPMS_STANDBY $DPMS_SUSPEND $DPMS_OFF

#exec 3>&2 2>/dev/null                                       

#echo 'keycode 58 = 1' >> /usr/local/share/kbd/caps_to_esc
#loadkeys -q /usr/local/share/kbd/caps_to_esc
# export GPG_AGENT_INFO

(( ${QT_XFT} ))      || export QT_XFT=1
(( ${GDK_USE_XFT} )) || export GDK_USE_XFT=1

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

setxkbmap -option keypad:pointerkeys
setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle'
xhost     +localhost

xbindkeys             
xset m 1 1            
xset r rate 200 50    

# hsetroot -full /home/neg/pic/wl/new_desk-light.png
# hsetroot -full /home/neg/pic/wl/96800.jpg
# hsetroot -full /home/neg/pic/wl/blame.png
# hsetroot -full /home/neg/pic/wl/88292728.jpg
# hsetroot -full /home/neg/pic/wl/87577.jpg
# hsetroot -center /home/neg/pic/wl/wallpaper-477302.jpg
hsetroot -center /home/neg/pic/wl/88292728.jpg
# disable trackpad while typing
syndaemon -t -k -i 2 -d 

[ -f $HOME/.Xresources ] && xrdb   -merge $HOME/.Xresources
[ -f $HOME/.Xmodmap ]    && xmodmap       $HOME/.Xmodmap

xset +fp $HOME/.fonts/monobook-font-0.22/pcf
xset +fp $HOME/.fonts/elite 
xset +fp "/usr/share/fonts/local/"
fc-cache

[ -x /usr/bin/dunst ] && dunst &

urxvtd -q -f -o 
${HOME}/bin/urxvt 
amixer -q set Master 0% mute
[ -z $(pidof udiskie) ]     && udiskie &
# [ -z $(pidof transmission-daemon) ] && transmission-daemon
# [ -x /usr/bin/xcape ] && /usr/bin/xcape &
[ ! -x "`which unclutter 2>/dev/null`"  ] ||  unclutter -idle 1 -reset -noevents  &
# [ ! -x "`which parcellite 2>/dev/null`" ] ||  GTK2_RC_FILES=/home/neg/.config/gtk-2.0/gtkrc_parcellite parcellite &
# [ ! -x "`which clipit 2>/dev/null`" ] ||  clipit                          &
[ ! -x "`which clipbored 2>/dev/null`" ] || clipbored
[ ! -x "`which pulseaudio 2>/dev/null`" ] ||  pulseaudio --start

font='-misc-ohsnapu-medium-r-normal--14-101-100-100-c-70-iso10646-1';urxvtcd -fn  $font -name wicd  -e wicd-curses                                &

exec notion
