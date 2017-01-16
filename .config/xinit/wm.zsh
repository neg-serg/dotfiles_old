#!/bin/zsh

function notion_run(){
    if [[ -e "${PANELS}" ]]; then
        "${SCRIPT_HOME}/panels"
    fi
    source ${XDG_CONFIG_HOME}/xinit/hotkeys.zsh

    (urxvtd -q -f -o && ${BIN_HOME}/urxvt) &

    cat /tmp/ws_out.txt &
    ~/bin/scripts/panels

    exec notion 2>> ~/tmp/${X11_WM}err$$ 2>&1
}

function windowchef_run() {
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec windowchef 2>> ~/tmp/${X11_WM}err$$ 2>&1
}

function herbstluftwm_run() {
    herbstluftwm -c ~/.config/herbstluftwm/autostart
}

eval "${X11_WM}"_run "$@"
