set-option -g status-position top
bind-key -n M-` set-option -g status

# toggle status bar position
bind-key -n M-~ \
  if-shell 'tmux show-option -g status-position | grep -q top$' \
    'set-option -g status-position bottom' \
    'set-option -g status-position top'

# break off pane to a new window
bind-key -n M-x \
  command-prompt -p '(break-pane)' -I '#W' \
    "break-pane ; rename-window '%%'"
bind-key -n M-X break-pane

bind-key -n M-k \
  set-window-option monitor-activity \;\
  display-message 'monitor-activity #{?monitor-activity,on,off}'

bind-key -n M-K \
  if-shell 'tmux show-window-option -g monitor-activity | grep -q off$' \
    'set-window-option -g monitor-activity on' \
    'set-window-option -g monitor-activity off' \;\
  display-message 'monitor-activity #{?monitor-activity,on,off} (global)'

new -n dmesg 'dmesg -L never --follow --nopager | ccze -A' 
neww -n var_log 'sudo tail -f /var/log/*.log ~/.xsession-errors |ccze -A' 
neww -n journalctl 'journalctl|ccze -A ; echo "--------------------" ; journalctl -fq | ccze -A'

