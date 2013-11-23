. ~/.zsh/01-init.zsh
. ~/.zsh/02-zsh-syntax-highlighting.zsh
. ~/.zsh/03-exports.zsh
. ~/.zsh/04-oldprompt.zsh
. ~/.zsh/05-functions.zsh
. ~/.zsh/06-alias.zsh
. ~/.zsh/07-misc.zsh
. ~/.zsh/09-cb.zsh
. ~/.zsh/10-hashes.zsh
. ~/.zsh/11-open.zsh
. ~/.zsh/12-completion.zsh
. ~/.zsh/12-vi_additions.zsh
. ~/.zsh/13-bindkeys.zsh
. ~/.zsh/14-dirjumps.zsh
# . ~/.zsh/etc/zce.zsh
# ------------------------------------------
# . ~/.zsh/99-trash.zsh
# ------------------------------------------
#
# #!/bin/bash
# 
# PID=$(pidof $1)
# 
# if [ -z "$PID" ]; then
#     tmux new-session -d -s main ;
#     tmux new-window -t main -n $1 "$*" ;
# fi
#     tmux attach-session -d -t main ;
#     tmux select-window -t $1 ;
# exit 0
