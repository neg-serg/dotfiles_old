set-option -g status-position top
new -n dmesg 'dmesg -L never --follow --human --nopager | ccze -A' 
neww -n var_log 'tail -f /var/log/*.log ~/.xsession-errors |ccze -A' 
neww -n journalctl 'journalctl|ccze -A ; echo "--------------------" ; journalctl -fq | ccze -A'
