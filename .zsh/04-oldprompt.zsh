# Set prompt
# PROMPT='%{$(pwd|grep --color=always /)%${#PWD}G%} %(!.%F{red}.%F{cyan})%n%f@%F{yellow}%m%f%(!.%F{red}.)%#%f '
# PROMPT='%{$(pwd|([[ $EUID == 0 ]] && GREP_COLORS="mt=01;36" grep --color=always /|| GREP_COLORS="mt=01;36" grep --color=always /))%${#PWD}G%} >> '
# PROMPT='[%{$(pwd|grep --color=always /)%${#PWD}G%}] >> '
# export PS1="%{${fg[green]}%}[%40<..<%~$NO_COLOUR%{${fg[green]}%}] %{${fg_bold[green]}%}» $NO_COLOUR"

case ${UID} in
0)
    PROMPT="%{$fg[red]%}<%T>%{$fg[red]%}[root@%m] %(!.#.$) %{${reset_color}%}%{${fg[red]}%}[%~]%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    ;;
*)
    # autoload -Uz vcs_info
    # zstyle ':vcs_info:*' formats '(%s:%b)'
    # zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
    # precmd () {
    #   psvar=()
    #   LANG=en_US.UTF-8 vcs_info
    #   [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    # }
    # TIME_FORMAT="%{${fg[yellow]}%}<%T>"
    # USER_AND_HOST="%{$fg[white]%}[%n@%m]"
    # CURRENT_DIR="%{${fg[yellow]}%}[%~]"
    # RESET_COLOR="%{${reset_color}%}"
    #   PROMPT="${TIME_FORMAT}${USER_AND_HOST}${RESET_COLOR}%% "
    #   PROMPT2="%{${fg[red]}%}%_> %{${reset_color}%}"
    #   SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
    #   RPROMPT="%1(v|%F{green}%1v%f|)${CURRENT_DIR}$RESET_COLOR"
    export PS1="%{${fg[green]}%}[%40<..<%~$NO_COLOUR%{${fg[green]}%}] %{${fg_bold[green]}%}>> $NO_COLOUR"
    # export PS1="%{${fg[green]}%}[%40<..<%~$NO_COLOUR%{${fg[green]}%}] %{${fg_bold[green]}%}❯ $NO_COLOUR"
    # . ~/.zsh/fizsh-prompt
    # PS1=`~/.zsh/fizsh-prompt`
    # PROMPT='%40<..<`/home/neg/.zsh/neg-prompt`'
    # secondary prompt, printed when the shell needs more information to complete a
    # command.
    PS2="%{$fg[green]%}>%{$fg_bold[green]%}> %{$reset_color%}"
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
