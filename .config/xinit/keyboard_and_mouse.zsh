setxkbmap \
    -option keypad:pointerkeys \
    -layout 'us,ru' \
    -option 'grp:alt_shift_toggle' \
    -variant altgr-intl \
    -option ctrl:nocaps

xhost +localhost +local: +si:localuser:$(id -un)
xset m 0 0 # disable mouse acceleration
xset -b r rate 250 50 m 1 1 b off

[[ -f ${XDG_CONFIG_HOME}/keymaps/xmodmaprc ]] && \
    xmodmap ${XDG_CONFIG_HOME}/keymaps/xmodmaprc

inpath unclutter && unclutter --fork --timeout 1 &

nexec ${BIN_HOME}/mon/klay_watch && ${BIN_HOME}/mon/klay_watch &
