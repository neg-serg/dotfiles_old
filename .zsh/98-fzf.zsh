function fe() {
    local out file key
    out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
    key=$(head -1 <<< "${out}")
    file=$(head -2 <<< "${out}" | tail -1)
    if [[ -n "${file}" ]]; then
        [[ "${key}" = 'ctrl-o' ]] && xdg-open "${file}" || ${EDITOR:-vim} "${file}"
    fi
}

# fkill - kill process
function fkill() {
    zle -I
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}


# fco - checkout git commit
function fco() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "${commits}" | fzf --tac +s +m -e) &&
    git checkout $(echo "${commit}" | sed "s/ .*//")
}

# fshow - git commit browser (enter for show, ctrl-d for diff, backtick toggles sort)
function fshow() {
    local out shas sha q k
    while out=$(
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --multi --no-sort --reverse --query="${q}" \
            --print-query --expect=ctrl-o,ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "${out}")
    k=$(head -2 <<< "${out}" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "${out}" | awk '{print $1}')
    [[ -z "${shas}" ]] && continue
    if [[ "${k}" = 'ctrl-d' ]]; then
        git diff --color=always ${shas} | ${PAGER}
    elif [[ "${k}" = 'ctrl-o' ]]; then
        git checkout ${shas}
    else
        for sha in ${shas}; do
            git show --color=always ${sha} | ${PAGER}
        done
    fi
    done
}

function ftpane () {
    local panes current_window target target_window target_pane
    panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    current_window=$(tmux display-message  -p '#I')
    target=$(fzf <<< "${panes}") || return
    target_window=$(awk 'BEGIN{FS=":|-"} {print$1}' <<< ${target})
    target_pane=$(awk 'BEGIN{FS=":|-"} {print$2}' <<< ${target}| cut -c 1)

    if [[ ${current_window} -eq ${target_window} ]]; then
        tmux select-pane -t ${target_window}.${target_pane}
    else
        tmux select-pane -t ${target_window}.${target_pane} &&
        tmux select-window -t $target_window
    fi
}

function pl(){
    local args
    [[ -e "$@" ]] && args="$@"
    [[ -z "${args}" ]] && args="${HOME}/vid/"
    find_result="$(find ${args}|${HOME}/.zsh/fzf-tmux -d 30% -- --color=16)"
    xsel <<< ${find_result}
    if [[ ! -z ${find_result} ]]; then
        exifdata=$(exiftool ${find_result})

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

        local fancy_name=$(_zfwrap ${find_result})
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
        for i in ${img_size_str} ${duration_str} ${created_str} ${comment_str}; do
            if [[ ${i} != "" ]]; then
                echo -ne "${i}\n"
            fi
        done
        mpv "${find_result}"
    fi
}

function fmpc() {
    local song_position
    song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
                    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
                    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
    [[ -n "${song_position}" ]] && mpc -q play $song_position
}

function fq() {
    local file=$(find ${1:-.} -maxdepth 1 -type f -print 2> /dev/null | fzf +m)
    echo ${file}
}

zle -N fe ; bindkey "^Xe" fe
zle -N fh ; bindkey "^Xh" fh
zle -N fkill ; bindkey "^Xq" fkill


# fh - repeat history
function fh() {
    zle -I;
    echo $(([[ -n "$ZSH_NAME" ]] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
}
