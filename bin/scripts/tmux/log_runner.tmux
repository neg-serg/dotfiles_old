new -n _logs_ 'dmesg -L never --follow --human --nopager | ccze -A' 
neww 'tail -f /var/log/*.log ~/.xsession-errors |ccze -A' 
neww 'journalctl|ccze -A ; echo "--------------------" ; journalctl -fq | ccze -A'
