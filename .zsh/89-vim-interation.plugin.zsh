readonly to_normal="<C-\><C-N>:call<SPACE>foreground()<CR>"

function wim_run(){
    local proc="process_list"
    if [[ $1 == "__wim_cmd" ]]; then
        proc="vprocess_list"; shift
    fi
    local wid=$(xdotool search --classname wim)
    if [[ -z "${wid}" ]]; then
        st -f "${wim_font}:pixelsize=${wim_font_size}" -c 'wim' -e bash -c "tmux -S ${wim_sock_path} new -s vim -n vim \"vim --servername ${vim_server_name}\" && \
            tmux -S ${wim_sock_path} switch-client -t vim" 2>/dev/null &!
        eval ${proc} ".1s" "$@"
    else  
        eval ${proc} ".1s" "$@"
    fi
}

function handle_files() {
    local mfiles=""
    for f; do
        f="$(resolve_file ${f})"
        mfiles="${mfiles} $(bash -c "printf %q '${f}'")"
    done
    [[ -n ${mfiles} ]] && mfiles=':args! '"${mfiles}<CR>"
}

function vim_file_open() (
    local file_name="$(resolve_file ${line})"
    file_name=$(bash -c "printf %q '${file_name}'")
    { vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
        || { while [[ $(vim --servername ${vim_server_name} --remote-expr "g:vim_is_started" 2>/dev/null) != "on" ]]; do
            sleep ".1s"
        done \
        && vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null } } && {
        local FG237="[38;5;237m"
        local file_size=$(stat -c%s "$file_name" 2>/dev/null| numfmt --to=iec-i --suffix=B|sed "s/\([KMGT]iB\|B\)/$fg[green]&/")
        local file_length="$(wc -l $file_name 2>/dev/null|grep -owE '[0-9]* '|tr -d ' ')"
        local sz_msg=$(_zsh_wrap "sz ${FG237}~$fg[white] $file_size")
        local len_msg=$(_zsh_wrap "len ${FG237}=$fg[white] $file_length")
        local new_file_msg=$(_zsh_wrap new_file)
        local dir_msg=$(_zsh_wrap directory)
        local msg_delim="[38;5;24m::"
        local pref=$(_zsh_wrap ">>")
        local decoration="$fg[green]‒$fg[white]"
        local tmp_name="$(echo ${file_name}|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
        local fancy_name="${decoration} $fg[white]${tmp_name} ${decoration}"
        if [[ ! -e "${file_name}" ]]; then
            echo "${pref} ${fancy_name} ${msg_delim} ${new_file_msg}"
        elif [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
            echo "${pref} ${fancy_name} ${msg_delim} ${sz_msg} ${msg_delim} ${len_msg}${syn_msg}"
        else
            if [[ -d "${file_name}" ]]; then
                if [[ $(readlink -f ${file_name}) == $(pwd) ]]; then
                    local spec_fancy_name="${decoration} $fg[white]current dir ${decoration}"
                    echo "${pref} ${spec_fancy_name} ${msg_delim} ${dir_msg}"
                else
                    echo "${pref} ${fancy_name} ${msg_delim} ${dir_msg}"
                fi
            fi
        fi
    }
    unset file_name
)

function process_list() {
    notionflux -e "app.byclass('', 'wim')" > /dev/null
    sleep "$1"; shift
    for line; do vim_file_open; done
}

function vprocess_list() {
    notionflux -e "app.byclass('', 'wim')" > /dev/null
    sleep "$1"; shift
    while getopts ":b:a:" opt; do
        case ${opt} in
            a) after="${OPTARG}" ;;
            b) before="${before}${OPTARG}" ;;
        esac
    done
    shift $((OPTIND-1))
    [[ ${after#:} != $after && ${after%<CR>} == ${after} ]] && after="${after}<CR>"
    [[ ${before#:} != $before && ${before%<CR>} == ${before} ]] && before="${before}<CR>"
    local cmd="${to_normal}${before}${after}"
    vim --servername ${vim_server_name} --remote-send "${cmd}"
    unset before; unset after
}

function wim_cmd {
    handle_files "$@"
    wim_run "__wim_cmd" "$@"
}

function wdiff {
    # or it's maybe better to use :windo diffthis
    if [[ $# == 2 ]]; then
        wim_run "" && wim_cmd -b":tabnew" && \
        {wim_run $1; shift} && \
        wim_cmd -b":diffthis" && \
        wim_cmd -b":vs" && \
        {wim_run $1; shift} && \
        wim_cmd -b":diffthis"
    fi
}


function v {
    handle_files "$@"
    wim_run "$@"
}

