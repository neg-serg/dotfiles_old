#!/bin/zsh
unset TMUX
. ~/.zsh/03-exports.zsh

${SCRIPT_HOME}/systemd_env_forwarding.zsh
${SCRIPT_HOME}/set_wallpaper

[[ -f ${HOME}/.Xresources ]] && \
    xrdb -load ${HOME}/.Xresources

pulseaudio --start &
wmname Sawfish

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

source ${XDG_CONFIG_HOME}/xinit/touchpad.zsh
source ${XDG_CONFIG_HOME}/xinit/keyboard_and_mouse.zsh
source ${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh

nexec dunst && dunst &
(urxvtd -q -f -o && ${BIN_HOME}/urxvt) &

nexec udiskie && udiskie -q &
nexec compton || sudo pkill compton
compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
${SCRIPT_HOME}/email_notifier.py --body &

source ${XDG_CONFIG_HOME}/xinit/hotkeys.zsh

systemctl --user restart gpaste &

eval $(gpg-agent --daemon)

[[ -e ${LOG_ENABLED_} ]] && ~/bin/scripts/log_runner
~/bin/pass_notifyd &
~/bin/scripts/mpd-notification &

cat /tmp/ws_out.txt &
~/bin/scripts/panels
disown

exec notion 2>> ~/tmp/notionerr$$ 2>&1
