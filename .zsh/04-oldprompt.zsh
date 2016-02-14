export _zsh_oldprompt_is_sourced="true"

local _lambda_ok="" # "%{$fg_bold[green]%}=λ\\"
local _lambda_err="%{$fg_bold[red]%}=λ\\"
local _lambda="%(?,${_lambda_ok},${_lambda_err})%{${reset_color}%}"

case ${UID} in
0)
    PROMPT="%{$fg[red]%}<%T>%{$fg[red]%}[root@%m] %(!.#.$) %{${reset_color}%}%{${fg[red]}%}[%~]%{${reset_color}%} "
    PS1="${PROMPT}"
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    PS2="${PROMPT2}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    ;;
*)
    DARK_BLUE="%{"$'\033[00;38;5;4m'"%}"
    _neg_user_pretok="${DARK_BLUE}[${NOCOLOR}"
    function precmd(){ 
        # _neg_hashes="$(hash -d|tr -d \')"
        # while read i; do 
        #     what_change=$(echo ${_neg_tilda_path}|grep -o "$(awk -F '=' '{print $2}' <<< ${i})")
        #     if [[ ${what_change} != "" ]]; then
        #         fst_arg=$(awk -F '=' '{print $1}' <<< ${i})
        #         _neg_tilda_path=${fst_arg}
        #     fi
        # done <<< ${_neg_hashes[@]}
        export PS1="${_neg_user_pretok}%40<..<$(${ZSH}/neg-prompt)" 
    }
    PS2="%{$fg[magenta]%}» %{$reset_color%}"
    # selection prompt used within a select loop.
    PS3='?# '
    # the execution trace prompt (setopt xtrace). default: '+%N:%i
    PS4='+%N:%i:%_> '
    function vi_mode_prompt_info() { [[ "${RPS1}" == "" && "${RPROMPT}" == "" ]] && RPS1='${_lambda}$(vi_mode_prompt_info)' }

    # if mode indicator wasn't setup by theme, define default
    [[ "${mode_ind}" == "" ]] && mode_ind="%{$fg[blue]%}[%{$fg[white]%}<<%{$fg[blue]%}]%{$reset_color%}"

    function vi_mode_prompt_info() {
        echo "${${KEYMAP/vicmd/${mode_ind}}/(main|viins)/}"
    }
    # define right prompt, if it wasn't defined by a theme
    [[ "${RPS1}" == "" && "${RPROMPT}" == "" ]] && RPS1='${_lambda}$(vi_mode_prompt_info)'
    ;;
esac
