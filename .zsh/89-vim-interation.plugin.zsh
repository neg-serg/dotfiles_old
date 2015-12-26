function vim_file_open() (
    local file_name="$(resolve_file ${line})"
    file_name=$(bash -c "printf %q '${file_name}'")
    { vim --servername ${vim_server_name} --remote-send "${to_normal}:silent edit ${file_name}<CR>" 2>/dev/null \
        || { while [[ $(vim --servername VIM --remote-expr "g:vim_is_started") != "on" ]]; do
            sleep "0.1s"
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
        if [[ -f "${file_name}" ]] && [[ ! -d "${file_name}" ]]; then
            echo "${pref} ${fancy_name} ${msg_delim} ${sz_msg} ${msg_delim} ${len_msg}${syn_msg}"
        else
            if [[ -z "${file_name}"  ]]; then
                echo "${pref} ${fancy_name} ${msg_delim} ${new_file_msg}"
            elif [[ -d "${file_name}" ]]; then
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
    # local cmd="${to_normal}${before}${after}"
    # vim --servername ${vim_server_name} --remote-send "${cmd}"
}

function v {
    local wid=$(xdotool search --classname wim)
    
    # readonly to_normal="--remote-send <C-\><C-N>:call<SPACE>foreground()<CR>"
    readonly to_normal="<C-\><C-N>:call<SPACE>foreground()<CR>"
    while getopts ":b:a:" opt; do
        #  -b':vsp' -b':sp'
        #  -b':wincmd k' -b':wincmd j'
        #  -b':wincmd l' -b':wincmd h'
        #  -b':sp<cr>:wincmd k'
        #  -b':sp<cr>:wincmd j'
        #  -b':vsp<cr>:wincmd h'
        #  -b':vsp<cr>:wincmd l'
        case ${opt} in
            a) after="${OPTARG}" ;;
            b) before="${before}${OPTARG}" ;;
        esac
    done
    shift $((OPTIND-1))
    [[ ${after#:} != $after && ${after%<CR>} == ${after} ]] && after="${after}<CR>"
    [[ ${before#:} != $before && ${before%<CR>} == ${before} ]] && before="${before}<CR>"
    local mfiles=""
    for f; do
        f="$(resolve_file ${f})"
        mfiles="${mfiles} $(bash -c "printf %q '${f}'")"
    done
    [[ -n ${mfiles} ]] && mfiles=':args! '"${mfiles}<CR>"
    #----------------------------------------------------------------
    if [[ -z "${wid}" ]]; then
        st -f "${wim_font}:pixelsize=${wim_font_size}" -c 'wim' -e bash -c "tmux -S ${wim_sock_path} new -s vim -n vim \"vim --servername ${vim_server_name}\" && \
            tmux -S ${wim_sock_path} switch-client -t vim" &!
        process_list ".1s" "$@"
    else  
        process_list ".1s" "$@"
    fi
}
