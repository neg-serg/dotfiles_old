if [[ ${source_fzf} ]]; then
    [[ ! "${PATH}" == *~/.vim/bundle/fzf/bin* ]] && export PATH="${PATH}:~/.vim/bundle/fzf/bin"
    if [[ ! "${MANPATH}" == *~/.vim/bundle/fzf/man* && -d "~/.vim/bundle/fzf/man" ]]; then
        export MANPATH="${MANPATH}:~/.vim/bundle/fzf/man"
    fi
    [[ $- == *i* ]] && source "~/.vim/bundle/fzf/shell/completion.zsh" 2> /dev/null
    source "~/.vim/bundle/fzf/shell/key-bindings.zsh"
else
    if [[ $- == *i* ]]; then
        __fzfcmd() { [ ${FZF_TMUX:-1} -eq 1 ] && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf" }
        fzf-history-widget() {
            local selected num
            selected=( $(fc -l 1 | $(__fzfcmd) --extended-exact -i +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r -q "${LBUFFER//$/\\$}") )
            if [ -n "${selected}" ]; then
                num=$selected[1]
                if [ -n "${num}" ]; then
                zle vi-fetch-history -n $num
                fi
            fi
            zle redisplay
        }
    fi
fi

function fe() {
    local out file key
    out=$(fzf-tmux --color=16 --ansi --multi --with-nth=3 --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
    key=$(head -1 <<< "${out}")
    file=$(head -2 <<< "${out}" | tail -1)
    if [[ -n "${file}" ]]; then
        [[ "${key}" = 'ctrl-o' ]] && xdg-open "${file}" || ${EDITOR:-vim} "${file}"
    fi
}

function fkill() {
    zle -I
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

function fco() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "${commits}" | fzf --tac +s +m -e) &&
    git checkout $(echo "${commit}" | sed "s/ .*//")
}

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
        vid_fancy_print "${find_result}"
        mpv --input-unix-socket=/tmp/mpvsocket  "${find_result}"
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
    echo $(([[ -n "$ZSH_NAME" ]] && fc -l 1 || history) | fzf +s --extended-exact| sed 's/ *[0-9]* *//')
}
