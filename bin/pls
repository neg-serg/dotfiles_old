#!/bin/zsh

if [[ ${DISPLAY} ]]; then
    local font='PragmataPro for Powerline 17'

    _v=(-lines 1 -columns 11 -location 6 -font "${font}" -o 90 -yoffset -22 -dmenu)
    _s=(-location 6 -font "${font}" -o 90 -yoffset -22 -dmenu)

    client_runner=(rofi ${_s} -dmenu -p "Clients:")
    volume_runner=(rofi ${_v} -p "Volume: ")
    sink_runner=(rofi ${_s} -p "Sink: ")
else
    client_runner=(fzf --prompt "Clients:")
    volume_runner=(fzf --prompt "Volume: ")
    sink_runner=(fzf --prompt "Sink: ")
fi

if [[ ${SCRIPT_OUTPUT} ]]; then
    client_runner=(cat)
    volume_runner=(cat)
    sink_runner=(cat)
fi

get_index() {
    sink=$(pacmd list-sinks | \
        grep name:          | \
        awk 'gsub(">$","")' | \
        cut -c 9-           | \
        sed 's/[<>]/ /g'    | \
        ${sink_runner[@]}     \
        )

    index=$(pacmd list-sinks  | \
        grep ${sink} -B1      | \
        head -1               | \
        awk -F : '{print $2}' | \
        tr -d '[:blank:]'       \
        )
}

case $1 in
    -unmute) shift; get_index; pactl set-sink-mute ${index} 0 ;;
    -mute) shift; get_index; pactl set-sink-mute ${index} 1 ;;
    *)  client=$(pacmd list-sink-inputs                              | \
                grep -E 'client:|index:'                             | \
                awk 'NR % 2 == 1 { o=$0 ; next } { print o " " $0 }' | \
                awk '{print $2" "substr($0, index($0,$5))}'          | \
                sed 's/[<>]/#/g'                                     | \
                ${client_runner[@]})
        case $1 in
            -vol)
                shift
                levels="0\n10\n20\n30\n40\n50\n60\n70\n80\n90\n100"
                volume=$(echo "${levels}"  | \
                         sed 's/[<>]/ /g'  | \
                         ${volume_runner[@]} \
                        )
                set_vol=$(bc <<< "scale=1; ${volume} / 100 * 65536")
                pacmd set-sink-input-volume "$(awk '{print $1}' <<< "${client}" 2>/dev/null )" "${set_vol%.*}"
            ;;
            -sink)
                shift
                sink=$(pacmd list-sinks    | \
                       grep name:          | \
                       awk 'gsub(">$","")' | \
                       cut -c 9-           | \
                       sed 's/[<>]/ /g'    | \
                       ${sink_runner[@]})
                [[ ${SCRIPT_OUTPUT} ]] && echo "${sink}"
                pacmd move-sink-input $(awk '{print $1}' <<< "${client}") $(echo ${sink})
            ;;
            *)
        esac
esac
