function nwim_goto() {
    if [[ $(pidof notion) && -x $(which notionflux) ]]; then
        notionflux -e "app.byclass('', 'nwim')" > /dev/null
    else
        if [[ -x $(which wmctrl) ]]; then
            wmctrl -i -a $(wmctrl -l -x|awk '/nwim.nwim/{print $1}')
        elif [[ -x $(which xdotool) ]]; then
            xdotool windowfocus $(xdotool search --class nwim)
        fi
    fi
}

function eprocess_list() {
    nwim_goto
    sleep "$1"; shift   
    for line; do nvr --servername /tmp/nvimsocket --remote-wait "$@"; done
}

function nwim_embed { nwim_run "__nwim_embed" "$@" }

function nwdiff {
    # or it's maybe better to use :windo diffthis
    if [[ $# == 2 ]]; then
        nwim_run "" && nv -b":tabnew" && \
        {nwim_run $1; shift} && \
        nv -b":diffthis" && \
        nv -b":vs" && \
        {nwim_run $1; shift} && \
        nv -b":diffthis"
    fi
}


function nvim_file_open() (
    local file_name="$(resolve_file ${line})"
    file_name=$(bash -c "printf %q '${file_name}'")
    { nvr --servername /tmp/nvimsocket --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
        || { while [[ $(nvr --servername /tmp/nvimsocket --remote-expr "g:nvim_is_started" 2>/dev/null) != "on" ]]; do
            sleep ${nwim_timer}
        done \
        && nvr --servername /tmp/nvimsocket --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null } } && {
        local file_size=$(_zfile_sz <<< stat -c%s "${file_name}" 2>/dev/null)
        local file_length="$(wc -l ${file_name} 2>/dev/null|grep -owE '[0-9]* '|tr -d ' ')"
        local sz_msg=$(_zwrap "sz$(_zfg 237)~$fg[white]${file_size}")
        local len_msg=$(_zwrap "len$(_zfg 237)=$fg[white]${file_length}")
        local new_file_msg=$(_zwrap new_file)
        local dir_msg=$(_zwrap directory)
        local pref=$(_zwrap ">>")
        if [[ ! -e "${file_name}" ]]; then
            <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${new_file_msg}"
        elif [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
            <<< "${pref} $(_zfwrap ${file_name}) $(_zdelim) ${sz_msg} $(_zdelim) ${len_msg}${syn_msg}"
        else
            if [[ -d "${file_name}" ]]; then
                if [[ $(readlink -f ${file_name}) == $(readlink -f $(pwd)) ]]; then
                    <<< "${pref} $(_zfwrap "current dir") $(_zdelim) ${dir_msg}"
                else
                    <<< "${pref} ${fancy_name} $(_zdelim) ${dir_msg}"
                fi
            fi
        fi
    }
    unset file_name
)

function nprocess_list() {
    nwim_goto
    sleep "$1"; shift
    while getopts ":b:a:c:" opt; do
        case ${opt} in
            a|c) after="${OPTARG}" ;;
            b) before="${before}${OPTARG}" ;;
            --) shift ; break ;;
        esac
    done
    shift $((OPTIND-1))
    [[ ${after#:} != ${after} && ${after%<CR>} == ${after} ]] && after="${after}<CR>"
    [[ ${before#:} != ${before} && ${before%<CR>} == ${before} ]] && before="${before}<CR>"
    local cmd="${to_normal}${before}${after}"
    if [[ ${cmd} == ${to_normal} ]]; then
        for line; do nvim_file_open; done
    else
        nvr --servername /tmp/nvimsocket --remote-send "${cmd}"
        for line; do nvim_file_open; done
    fi
    unset before; unset after
}

function nwim_run(){
    local proc="nprocess_list"
    [[ $1 == "__nwim_embed" ]] && {proc="eprocess_list"; shift}
    local wid=$(xdotool search --classname nwim)
    if [[ -z "${wid}" ]]; then
        st -f "${nwim_font}:pixelsize=${nwim_font_size}" -c 'nwim' -e bash -c "tmux -S ${nwim_sock_path} new -s nvim -n nvim \"nvr --servername /tmp/nvimsocket\" && \
            tmux -S ${nwim_sock_path} switch-client -t nvim" 2>/dev/null &!
        eval ${proc} ${nwim_timer} "$@"
    else  
        eval ${proc} ${nwim_timer} "$@"
    fi
}

function nv { 
    while read -r arg; do
        nwim_run ${arg[@]}
    done <<< "$(printf '%q\n' "$@")"
}

