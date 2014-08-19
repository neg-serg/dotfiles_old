source ~/.fzf.zsh
# This is a helper function that splits the current pane to start the given
# command ($1) and sends its output back to the original pane with any number of
# optional keys (shift; $*).
function fzf_tmux_helper() {
  [ -n "$TMUX_PANE" ] || return
  local cmd=$1
  shift
  tmux split-window -p 40 \
    "zsh -c \"\$(tmux send-keys -t $TMUX_PANE \"\$(source ~/.fzf.zsh; $cmd)\" $*)\""
}

# This is the function we are going to run in the split pane.
# - "find" to list the directories
# - "sed" will escape spaces in the paths.
# - "paste" will join the selected paths into a single line
function fzf_tmux_dir() {
  fzf_tmux_helper \
    'find * -path "*/\.*" -prune -o -type d -print 2> /dev/null |
     fzf --multi |
     sed "s/ /\\\\ /g" |
     paste -sd" " -' Space
}
