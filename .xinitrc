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

(urxvtd -q -f -o && ${BIN_HOME}/urxvt) &

source ${XDG_CONFIG_HOME}/xinit/touchpad.zsh
source ${XDG_CONFIG_HOME}/xinit/keyboard_and_mouse.zsh
source ${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh
source ${XDG_CONFIG_HOME}/xinit/compositing.zsh

nexec dunst && dunst &
nexec udiskie && udiskie -q &

${SCRIPT_HOME}/email_notifier.py --body &

systemctl --user restart gpaste &

eval $(gpg-agent --daemon)

[[ -e ${LOG_ENABLED_} ]] && ~/bin/scripts/log_runner
~/bin/pass_notifyd &
disown

X11_WM="notion" PANELS="dzen" source ${XDG_CONFIG_HOME}/xinit/wm.zsh
