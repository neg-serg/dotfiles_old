# Setup fzf
# ---------
if [[ ! "$PATH" == */home/neg/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/home/neg/.vim/bundle/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/neg/.vim/bundle/fzf/man* && -d "/home/neg/.vim/bundle/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/neg/.vim/bundle/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/neg/.vim/bundle/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/neg/.vim/bundle/fzf/shell/key-bindings.bash"

