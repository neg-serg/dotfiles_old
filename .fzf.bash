# Setup fzf
# ---------
if [[ ! "$PATH" == */home/neg/.vim/repos/github.com/junegunn/fzf/bin* ]]; then
  export PATH="$PATH:/home/neg/.vim/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/neg/.vim/repos/github.com/junegunn/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/neg/.vim/repos/github.com/junegunn/fzf/shell/key-bindings.bash"

