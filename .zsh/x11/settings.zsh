export _JAVA_AWT_WM_NONREPARENTING=1 
export GPG_AGENT_INFO
(( ${+QT_XFT} ))      || export QT_XFT=1
(( ${+GDK_USE_XFT} )) || export GDK_USE_XFT=1
# export VDPAU_NVIDIA_NO_OVERLAY=1
# nvidia-settings -a GlyphCache=1
# nvidia-settings -a InitialPixmapPlacement=2
export my_elite_28='-elite-laptop-bold-r-normal--28-280-72-72-c-140-koi8-r'

# setxkbmap -option terminate:ctrl_alt_bksp
# setxkbmap se -variant progqwerty \
#   || setxkbmap se -variant nodeadkeys
xset m 3/2 6
xset dpms $DPMS_STANDBY $DPMS_SUSPEND $DPMS_OFF

synclient TapButton1=1 HorizTwoFingerScroll=1 VertTwoFingerScroll=1

GTK_IM_MODULE=xim
QT_IM_MODULE=xim
