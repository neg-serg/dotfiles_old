#!/bin/zsh
windowmanager="${1}"
[[ ${windowmanager} ]] || source ${XDG_CONFIG_HOME}/.windowmanager
export windowmanager

unset TMUX

${SCRIPT_HOME}/systemd_env_forwarding.zsh
gpaste-client start
~/bin/wl rand

[[ -f "${HOME}/.Xresources" ]] && \
    xrdb -load "${HOME}/.Xresources"

pulseaudio --start &

inpath() { [[ -x "$(which "$1" 2>/dev/null)" ]]; }
nexec() { [[ -z $(pidof "$1") ]]; }

source "${XDG_CONFIG_HOME}/xinit/touchpad.zsh"
source "${XDG_CONFIG_HOME}/xinit/keyboard_and_mouse.zsh"
source "${XDG_CONFIG_HOME}/xinit/cursor_swarp.zsh"
source "${XDG_CONFIG_HOME}/xinit/compositing.zsh"
source "${XDG_CONFIG_HOME}/xinit/email.dash"

eval $(gpg-agent --daemon)

[[ -e ${LOG_ENABLED_} ]] && ~/bin/scripts/log_runner

${XDG_CONFIG_HOME}/xinit/wm.zsh
