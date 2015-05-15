case ${UID} in
0)
    PROMPT="%{$fg[red]%}<%T>%{$fg[red]%}[root@%m] %(!.#.$) %{${reset_color}%}%{${fg[red]}%}[%~]%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    ;;
*)
    DARK_BLUE="%{"$'\033[00;38;5;4m'"%}"
    _fizsh_user_pretoken="${DARK_BLUE}[${NOCOLOR}"
    function precmd(){
        export PS1="$_fizsh_user_pretoken%40<..<`~/.zsh/modules/syntax/fizsh-prompt.zsh`"
    }
    PS2="%{$fg[magenta]%}» %{$reset_color%}"
    # selection prompt used within a select loop.
    PS3='?# '
    # the execution trace prompt (setopt xtrace). default: '+%N:%i
    PS4='+%N:%i:%_> '
    function vi_mode_prompt_info() {
      if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
      RPS1='$(vi_mode_prompt_info)'
    fi
    }

    # if mode indicator wasn't setup by theme, define default
    if [[ "$MODE_INDICATOR" == "" ]]; then
      MODE_INDICATOR="%{$fg[green]%}<%{$fg_bold[green]%}<%{$reset_color%}"
    fi

    function vi_mode_prompt_info() {
      echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
    }

    # define right prompt, if it wasn't defined by a theme
    if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
      RPS1='$(vi_mode_prompt_info)'
    fi
    ;;
esac
