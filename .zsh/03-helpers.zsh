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

function vid_fancy_print(){
        local exifdata=$(exiftool "$1")

        local vid_comment="$(awk -F: '/^Comment/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local file_size="$(awk -F: '/^File Size/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local mime_type="$(awk -F: '/^MIME Type/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local doc_type="$(awk -F: '/^Doc Type/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local muxing_app="$(awk -F: '/^Muxing App/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local duration="$(awk -F: '/^Duration/' <<< ${exifdata}|cut -d: -f 3-|tr -d '[:blank:]')"
        local date_time="$(awk -F: '/^Date Time Original/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local img_width="$(awk -F: '/^Image Width/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local img_height="$(awk -F: '/^Image Height/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"
        local wrighting_app="$(awk -F: '/^Wrighting App/{print $2}'<<< ${exifdata}|tr -d '[:blank:]')"

        local fancy_name=$(_zfwrap "$1")
        if [[ ! $(tr -d '[:blank:]'<<< ${vid_comment} ) == "" ]]; then
            local comment_str="$(zwrap "Comment $(_zdelim) ${vid_comment}")"
        else
            local comment_str=""
        fi

        local img_size_str="$(_zwrap "Size $(_zdelim) ${img_width} x ${img_height}")"
        local duration_str="$(_zwrap "Duration $(_zdelim) ${duration}")"

        if [[ ! $(tr -d '[:blank:]' <<< ${created_str}) == "" ]]; then
            local created_str="$(_zwrap Created $(_zdelim) ${date_time})"
        else
            local created_str=""
        fi
        echo -e "$(_zpref) ${fancy_name}"
        for q in ${img_size_str} ${duration_str} ${created_str} ${comment_str}; do
            [[ ${q} != "" ]] && echo -ne "${q}\n"
        done
}

