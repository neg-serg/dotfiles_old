#exec 3>&2 2>/dev/null                                       

# sudo mkdir /var/run/lirc/
# sudo touch /var/run/lirc/lircd.pid  
# sudo lircd --driver=alsa_usb --device=hw:S51 
# irexec -d

# systemd --user &
[ -z $(pidof mpd) ]         && mpd
[ -z $(pidof mpdscribble) ] && mpdscribble
[ -z $(pidof udiskie) ]     && udiskie &
[ -z $(pidof transmission-daemon) ] && transmission-daemon -w $HOME/torrent/data --paused
# [ -x /usr/bin/xcape ] && /usr/bin/xcape &
wmname LG3D
swarp  1600 900

#xset fp $(echo "$HOME/.fonts
                #$HOME/.fonts/elite
                #$HOME/.fonts/monobook-font-0.22/pcf
                #/usr/share/fonts/{TTF,artwiz-fonts,local,misc}" | perl -pe 's/[\n\s]+//g')
#fc-cache

#GTK2_RC_FILES="${HOME}/.themes/Zukitwo-Resonance/gtk-2.0/gtkrc" /usr/bin/firefox $@

if [ $(ps aux | grep -c zsh) -lt 5 ]; then
  setsid urxvt -name MainTerminal -e zsh -c \
    "xmodmap -e 'clear Lock' \
             -e 'keycode 0x42 = Escape' \
     exec zsh"
else
  xmodmap -verbose -e 'clear Lock'
  xmodmap -verbose -e 'keycode 0x42 = Escape'
fi

#urxvtc -fn xft:terminus -title "mutt" -name "mutt" -e mutt && urxvtc -fn $font -name ranger -e ranger ) & ;;

setxkbmap -option keypad:pointerkeys
setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle'
xhost     +localhost

xbindkeys             
xset m 1 1            
xset r rate 200 50    
#kbdd                   
#kdlaunch              
# keynav                &
# disable trackpad while typing
syndaemon -t -k -i 2 -d 

[ -f $HOME/.Xresources ] && xrdb   -merge $HOME/.Xresources
[ -f $HOME/.Xmodmap ]    && xmodmap       $HOME/.Xmodmap
                                                          
xset +fp $HOME/.fonts/monobook-font-0.22/pcf
xset +fp $HOME/.fonts/elite 
xset +fp "/usr/share/fonts/local/"
fc-cache

#remind -z -k"$HOME/.dzen/notify/notify_add.sh %s" $HOME/.reminders &
[ -x /usr/bin/dunst ] && dunst &

mv $HOME/Downloads/* $HOME/dw && rm -r $HOME/Desktop $HOME/Downloads $HOME/gtk-3.0 $HOME/intel
# font='fixed'
font='-misc-ohsnapu-medium-r-normal--14-101-100-100-c-70-iso10646-1'

urxvtd -q -f -o 
$HOME/bin/urxvt 
amixer -q set Master 0% mute
[ ! -x "`which unclutter 2>/dev/null`"  ] ||  unclutter -idle 1 -reset -noevents  &
[ ! -x "`which pulseaudio 2>/dev/null`" ] ||  pulseaudio                          &
[ ! -x "`which parcellite 2>/dev/null`" ] || parcellite                           &

#stalonetray -geometry 1x1 &
# urxvtcd -fn xft:terminus:pixelsize=14 -name weechat-curses -e weechat-curses &
# urxvtcd -fn  $font -name mixer -e alsamixer  -g                              &
# urxvtcd -fn $font -fb $font -fi $font -name mixer -e pulseaudio-mixer-cli.py &
urxvtcd -fn  $font -name wicd  -e wicd-curses                                &
# urxvtcd -fn xft:terminus -title "mutt" -name "mutt" -e mutt                  &
# urxvtcd -fn $my_elite_28 -name ranger -e ranger                              &

## http://wiki.archlinux.org/index.php/Touchpad_Synaptics
#syndaemon -t -k -i 2 -d &
#synclient HorizTwoFingerScroll=1 TapButton2=3 TapButton3=2


#WM="exec notion"

#while true; do "${WM}"
#  gxmessage 'Do you really want to quit?' \
#            -buttons 'Yes:0,No:1' -center \
#            -default 'No' -timeout 30 \
#  && break
#done
#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &


urxvt -fn $font -fb $font -fi $font -name mpd-pad -e ncmpcpp -c ~/.ncmpcpp/mini_conf &
#---------------- [new] ------------------
#xfce4-power-manager &
