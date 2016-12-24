powerline-daemon -q
local powerline_path_="/usr/lib/python3.5/site-packages/powerline"
source "${powerline_path_}/bindings/zsh/powerline.zsh"

DARK_BLUE="%{"$'\033[00;38;5;4m'"%}"
_neg_user_pretok="${DARK_BLUE}[${NOCOLOR}"
function precmd(){ 
    # export PS1="$("$POWERLINE_COMMAND" $=POWERLINE_COMMAND_ARGS shell aboveleft -r .zsh --last-exit-code=$? --last-pipe-status="$pipestatus" --renderer-arg="client_id=$$" --renderer-arg="shortened_path=${(%):-%~}" --jobnum=$_POWERLINE_JOBNUM --renderer-arg="mode=$_POWERLINE_MODE" --renderer-arg="default_mode=$_POWERLINE_DEFAULT_MODE" --width=$(( ${COLUMNS:-$(_powerline_columns_fallback)} - ${ZLE_RPROMPT_INDENT:-1} )))"
    export PS1="${_neg_user_pretok}%40<..<$(${ZSH}/neg-prompt)"
}
PS2="%{$fg[magenta]%}» %{$reset_color%}"
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i
PS4='+%N:%i:%_> '
