# Setup fzf
# ---------
if [[ ! "$PATH" == */home/neg/.vim/repos/github.com/junegunn/fzf/bin* ]]; then
  export PATH="$PATH:/home/neg/.vim/repos/github.com/junegunn/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/neg/.vim/repos/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

FZF_TMUX=1
# Key bindings
# ------------
source "/home/neg/.vim/repos/github.com/junegunn/fzf/shell/key-bindings.zsh"
