#!/bin/zsh

cmd=""
selection=""
out=""
paste=false

cmds=("sort" "tac")

window=$(xdotool getwindowfocus|tr -d '\n')

function read_command {
    local dmenu_opts=(-fn 'PragmataPro for Powerline' -nb '#000000' -nf '#FFFFFF' -sb '#ff8c00' -sf '#000000')
    cmd_=$(echo -n "${cmds}"| tr -s ' ' '\n' | rofi -dmenu ${dmenu_opts} -yoffset -22)
    # builtin printf "${cmd}\n"
    echo ${cmd_}
    return "${cmd_}"
}

function send_key(){
    local key="$1"
    xdotool key --window "${window}" "${key}"
}

while true; do
    case "$1" in 
        -p | --paste)
            paste=true; 
            shift 
        ;;
        -c | -e | --command | * ) 
            # if [[ $2 != "" ]]; then
            #     cmd="$2"
            # else
            cmd="$(read_command)"
            # fi
            # shift 
        ;;
        --) shift; break ;;
    esac
    if [[ ${paste} == true ]]; then
        echo -n | xclip -i # clear clipboard first
        send_key 'Control_L+c'; send_key 'Control_L+v'
    fi
    if [[ ${cmd} != "" ]]; then
        # read the selection
        selection=$(xclip -o)
        if [[ ${selection} == "" && ${paste} ]]; then
            builtin printf "no input, aborting..."
            exit 1
        fi

        # put it into the clipboard (and clear it first so Klipper doesn't interfere)
        echo -n | xclip -i -sel clipboard

        clipboard=$(xclip -o)
        out=$(${cmd} <<< "${clipboard}")
        xclip -i -sel clipboard <<< "${out}"

        exit 0
    else
        builtin printf "you need to specify a command"
        exit 1
    fi
done
