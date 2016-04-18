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

_zex_tag(){ grep -E '^'"$1"'' <<< ${exifdata_} | cut -d ':' -f 2- | tr -d '[:blank:]' }
_zex_tag_untr(){ grep -E '^'"$1"'' <<< ${exifdata_} | cut -d ':' -f 2- }

function vid_fancy_print(){
    if [[ -f "$1" ]]; then
        exifdata_=$(exiftool "$1")
        #------------------------------------------
        local fancy_name=$(_zfwrap "$1")
        local vid_comment="$(_zex_tag 'Comment')"
        if [[ ! $(tr -d '[:blank:]'<<< ${vid_comment} ) == "" ]]; then
            local comment_str="$(zwrap "Comment $(_zdelim) ${vid_comment}")"
        else
            local comment_str=""
        fi
        #------------------------------------------
        local img_width="$(_zex_tag 'Image Width')"
        local img_height="$(_zex_tag 'Image Height')"
        local img_size_str="$(_zwrap "Size $(_zdelim) $fg[white]${img_width}$(_zfg 24)x$fg[white]${img_height}")"
        #------------------------------------------
        local duration="$(awk -F: '/^Duration/' <<< ${exifdata_}|cut -d: -f 3-|tr -d '[:blank:]')"
        local duration_str="$(_zwrap "Duration $(_zdelim) $fg[white]${duration}")"
        #------------------------------------------
        local file_size="$(_zex_tag 'File Size'))"
        local file_size_str="$(_zwrap "File Size $(_zdelim) $fg[white] $(_zfile_sz <<< ${file_size})")"
        #------------------------------------------
        local mime_type="$(_zex_tag 'MIME Type')"
        not_empty_in_fact_ ${mime_type} && \
        local mime_type_str="$(_zwrap "MIME Type $(_zdelim) $fg[white]${mime_type}")"
        #------------------------------------------
        local average_bitrate="$(_zex_tag 'Average Bitrate')"
        local max_bitrate="$(_zex_tag 'Max Bitrate')"
        not_empty_in_fact_ ${max_bitrate} && not_empty_in_fact_ ${average_bitrate} && \
        local bitrate_str="$(_zwrap "Bitrate $(_zdelim) $fg[white]${average_bitrate}/${max_bitrate}")"
        #------------------------------------------
        local video_frame_rate="$(_zex_tag 'Video Frame Rate')"
        not_empty_in_fact_ ${video_frame_rate} && \
        local vid_fps_str="$(_zwrap "FPS: $(_zdelim) $fg[white]${video_frame_rate}")"
        #------------------------------------------
        local audio_bits="$(_zex_tag 'Audio Bits Per Sample')"
        local audio_sample_rate="$(_zex_tag 'Audio Sample Rate')"
        not_empty_in_fact_ ${audio_bits} && not_empty_in_fact_ && ${audio_sample_rate} && \
        local audio_qa_str="$(_zwrap "Audio: $(_zdelim) $fg[white]${audio_bits}/${audio_sample_rate}")"
        #------------------------------------------
        local encoder="$(_zex_tag 'Encoder')"
        not_empty_in_fact_ ${encoder} && \
        local encoder_str="$(_zwrap "Encoder: $(_zdelim) $fg[white]${encoder}")"
        #------------------------------------------
        local wrighting_app="$(_zex_tag 'Wrighting App')"
        not_empty_in_fact_ ${wrighting_app} && \
        local writing_app_str="$(_zwrap "Wrighting App $(_zdelim) ${wrighting_app}")"
        #------------------------------------------
        local wrighting_app="$(_zex_tag 'Muxing App')"
        not_empty_in_fact_ ${muxing_app} && \
        local muxing_app_str="$(_zwrap "Muxing App $(_zdelim) ${wrighting_app}")"
        #------------------------------------------
        local doc_type="$(_zex_tag 'Doc Type'|tr '\n' ' '|sed 's/ *$//')"
        not_empty_in_fact_ ${doc_type} && \
        local doc_type_str="$(_zwrap "Doc Type $(_zdelim) $fg[white]${doc_type}")"
        #------------------------------------------
        local date_time="$(_zex_tag_untr 'Date\/Time Original')"
        not_empty_in_fact_ ${date_time} && \
        local date_time_str="$(_zwrap "Date/Time $(_zdelim) $fg[white]${date_time}")"
        #------------------------------------------
        if [[ ! $(tr -d '[:blank:]' <<< ${created_str}) == "" ]]; then
            local created_str="$(_zwrap Created $(_zdelim) ${date_time})"
        else
            local created_str=""
        fi
        #------------------------------------------
        echo -e "$(_zpref) ${fancy_name}"
        for q in ${img_size_str} \
                 ${duration_str} \
                 ${bitrate_str} \
                 ${vid_fps_str} \
                 ${audio_qa_str} \
                 ${created_str} \
                 ${file_size_str} \
                 ${mime_type_str} \
                 ${comment_str} \
                 ${wrighting_app_str} \
                 ${muxing_app_str} \
                 ${doc_type_str} \
                 ${date_time_str} \
                 ${encoder_str} \
                 ; do
            [[ ! ${q} == "" ]] && echo -ne "${q}\n"
        done
        unset exifdata_
    fi
}

