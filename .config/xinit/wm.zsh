#!/bin/zsh

if [[ ${X11_WM} == "notion" ]]; then
    if $[[ -e "${PANELS}" ]]; then
        "${SCRIPT_HOME}/panels"
    fi
    source ${XDG_CONFIG_HOME}/xinit/hotkeys.zsh

    cat /tmp/ws_out.txt &
    ~/bin/scripts/panels

    exec notion 2>> ~/tmp/${X11_WM}err$$ 2>&1
elif [[ ${X11_WM} == "windowchef" ]]; then
    sxhkd -c "${XDG_CONFIG_HOME}/windowchef/sxhkd.conf" &
    exec windowchef 2>> ~/tmp/${X11_WM}err$$ 2>&1
fi
