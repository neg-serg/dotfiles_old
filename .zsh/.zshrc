. ~/.zsh/01-init.zsh
. ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
. ~/.zsh/03-exports.zsh
. ~/.zsh/04-oldprompt.zsh
. ~/.zsh/04-zleiab.zsh
. ~/.zsh/05-functions.zsh
. ~/.zsh/06-alias.zsh
. ~/.zsh/07-misc.zsh
. ~/.zsh/09-cb.zsh
. ~/.zsh/10-hashes.zsh
. ~/.zsh/10-jump.zsh
. ~/.zsh/11-open.zsh
. ~/.zsh/12-completion.zsh
. ~/.zsh/12-vi_additions.zsh
. ~/.zsh/13-bindkeys.zsh
. ~/.zsh/14-dirjumps.zsh
. ~/.zsh/20-rehash-hook.zsh
. ~/.zsh/40-gpg-agent.zsh
. ~/.zsh/50-title.zsh
. ~/.zsh/75-urltools.plugun.zsh
. ~/.zsh/97-lastfm.zsh

# zle-keymap-select () {
#   if [ $KEYMAP = vicmd ]; then
#     if [[ $TMUX = '' ]]; then
#       echo -ne "\033]12;Red\007"
#     else
#       printf '\033Ptmux;\033\033]12;red\007\033\\'
#     fi
#   else
#     if [[ $TMUX = '' ]]; then
#       echo -ne "\033]12;Grey\007"
#     else
#       printf '\033Ptmux;\033\033]12;grey\007\033\\'
#     fi
#   fi
# }
# zle-line-init () {
#   zle -K viins
#   echo -ne "\033]12;Grey\007"
# }
# zle -N zle-keymap-select
# zle -N zle-line-init
