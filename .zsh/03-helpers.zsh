function _zwrap() { echo "$fg[blue][$fg[white]$1$fg[blue]]$fg[default]" }

function _zfwrap(){
    apply=$1;
    body=$2;
    shift
    echo $(apply) ${body} $(apply)
}

function _zgwrap(){
    side=$1;
    body=$2;
    shift
    echo ${side} ${body} ${side}
}

function _zfwrap() {
    local tmp_name="$(echo $1|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
    local decoration="$fg[green]‒$fg[white]"
    local fancy_name="${decoration} $fg[white]${tmp_name} ${decoration}"
    echo ${fancy_name}
}

function _zpref() { echo $(_zwrap ">>") }
function _zfg(){ echo -ne "[38;5;$1m" }
function _zdelim(){ echo -ne "$(_zfg 24)::"$(_zfg 8) }

function resolve_file {
    if [[ -f "$1" ]]; then
        echo $(readlink -f "$1")
    elif [[ "${1#/}" == "$1" ]]; then
        echo "$(pwd)/$1"
    else
        echo $1
    fi
}

function not_empty_in_fact_(){
    if [[ $(echo "${1}"| tr -d '[:blank:]') != "" ]]; then
        true
    else
        false
    fi
}

function _zfile_sz(){
    sed "s/\([KMGT]iB\|B\)/$fg[green]&/" || \
    numfmt --to=iec-i --suffix=B|sed "s/\([KMGT]iB\|B\)/$fg[green]&/"
}

function vid_fancy_print(){
        local exifdata=$(exiftool "$1")

        local fancy_name=$(_zfwrap "$1")
        local vid_comment="$(awk -F: '/^Comment/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        if [[ ! $(tr -d '[:blank:]'<<< ${vid_comment} ) == "" ]]; then
            local comment_str="$(zwrap "Comment $(_zdelim) ${vid_comment}")"
        else
            local comment_str=""
        fi

        local img_width="$(awk -F: '/^Image Width/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local img_height="$(awk -F: '/^Image Height/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local img_size_str="$(_zwrap "Size $(_zdelim) $fg[white]${img_width} $(_zfg 24)x$fg[white] ${img_height}")"

        local duration="$(awk -F: '/^Duration/' <<< ${exifdata}|cut -d: -f 3-|tr -d '[:blank:]')"
        local duration_str="$(_zwrap "Duration $(_zdelim) $fg[white]${duration}")"

        local file_size="$(awk -F: '/^File Size/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local file_size_str="$(_zwrap "File Size $(_zdelim) $fg[white] $(_zfile_sz <<< ${file_size})")"

        local mime_type="$(awk -F: '/^MIME Type/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        not_empty_in_fact_ ${mime_type} && \
        local mime_type_str="$(_zwrap "MIME Type $(_zdelim) $fg[white]${mime_type}")"

        local wrighting_app="$(awk -F: '/^Wrighting App/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        not_empty_in_fact_ ${wrighting_app} && \
        local writing_app_str="$(_zwrap "Wrighting App $(_zdelim) ${wrighting_app}")"

        local muxing_app="$(awk -F: '/^Muxing App/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        not_empty_in_fact_ ${muxing_app} && \
        local muxing_app_str="$(_zwrap "Muxing App $(_zdelim) ${wrighting_app}")"

        local doc_type="$(awk -F: '/^Doc Type/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        not_empty_in_fact_ ${doc_type} && \
        local doc_type_str="$(_zwrap "Doc Type $(_zdelim) ${doc_type}")"

        local date_time="$(awk -F: '/^Date Time Original/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        not_empty_in_fact_ ${date_time} && \
        local date_time_str="$(_zwrap "Date/Time $(_zdelim) ${date_time}")"

        if [[ ! $(tr -d '[:blank:]' <<< ${created_str}) == "" ]]; then
            local created_str="$(_zwrap Created $(_zdelim) ${date_time})"
        else
            local created_str=""
        fi

        echo -e "$(_zpref) ${fancy_name}"
        for q in ${img_size_str} \
                 ${duration_str} \
                 ${created_str} \
                 ${file_size_str} \
                 ${mime_type_str} \
                 ${comment_str} \
                 ${wrighting_app_str} \
                 ${muxing_app_str} \
                 ${doc_type_str} \
                 ${date_time_str} \
                 ; do
            [[ ! ${q} == "" ]] && echo -ne "${q}\n"
        done
}

