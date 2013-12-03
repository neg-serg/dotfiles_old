# Set prompt
# PROMPT='%{$(pwd|grep --color=always /)%${#PWD}G%} %(!.%F{red}.%F{cyan})%n%f@%F{yellow}%m%f%(!.%F{red}.)%#%f '
# PROMPT='%{$(pwd|([[ $EUID == 0 ]] && GREP_COLORS="mt=01;36" grep --color=always /|| GREP_COLORS="mt=01;36" grep --color=always /))%${#PWD}G%} >> '
# PROMPT='[%{$(pwd|grep --color=always /)%${#PWD}G%}] >> '
export PS1="%{${fg[green]}%}[%40<..<%~$NO_COLOUR%{${fg[green]}%}] %{${fg_bold[green]}%}>> $NO_COLOUR"
# . ~/.zsh/fizsh-prompt
# PROMPT='%40<..<`fizsh-prompt`'
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
