#!/bin/zsh

function notion_run(){
    if [[ -e "${PANELS}" ]]; then
        "${SCRIPT_HOME}/panels"
    fi
    source ${XDG_CONFIG_HOME}/xinit/hotkeys.zsh

    (urxvtd -q -f -o && ${BIN_HOME}/urxvt) &

    cat /tmp/ws_out.txt &
    ~/bin/scripts/panels

    exec notion 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function windowchef_run() {
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec windowchef 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function herbstluftwm_run() {
    exec herbstluftwm -c ~/.config/herbstluftwm/autostart
}

function bspwm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec bspwm 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function 2bwm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec 2bwm 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

function nowm_run(){
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    wew | ~/bin/yawee &
    exec ~/bin/wm/wmtls/xwait 2>> ~/tmp/${windowmanager}err$$ 2>&1
}

if type "${windowmanager}"_run; then
    eval "${windowmanager}"_run "$@"
else
    exec ${windowmanager} "$@"
fi

