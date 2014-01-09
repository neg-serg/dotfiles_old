# TMUX
# if which tmux 2>&1 >/dev/null; then
#     # if no session is started, start a new session
#     test -z ${TMUX} && tmux
# 
#     # when quitting tmux, try to attach
#     while test -z ${TMUX}; do
#         tmux attach || break
#     done
# fi
# tmux run-shell ~/bin/stx

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear
fi

if [[ -o LOGIN ]]; then
    (( $#commands[tmux] )) && tmux list-sessions 2>/dev/null
fi

# startx if on tty1 and tmux on tty2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] && [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && [ -z `pgrep xinit` ]; then
    exec startx -- vt1 &>/dev/null
    logout
elif [[ $(tty) = /dev/tty4 ]]; then
    tmux -f $HOME/.tmux.conf new -s ~/1st_level/main.socket
fi
