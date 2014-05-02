# disable annoying pc speaker
setterm -bfreq 0
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

# Set our default path
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/dw"
export XDG_MUSIC_DIR="${HOME}/music"
export GREP_COLORS="ms=1;35:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30"

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
