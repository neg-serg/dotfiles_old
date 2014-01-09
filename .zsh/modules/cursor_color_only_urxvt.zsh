bindkey -v
zle-keymap-select () {
  if [ $TERM = "screen" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne '\033P\033]12;#ff6565\007\033\\'
    else
      echo -ne '\033P\033]12;grey\007\033\\'
    fi
  elif [ $TERM != "linux" ]; then
    if [ $KEYMAP = vicmd ]; then
      echo -ne "\033]12;#ff6565\007"
    else
      echo -ne "\033]12;grey\007"
    fi
  fi
}; zle -N zle-keymap-select
zle-line-init () {
  zle -K viins
  if [ $TERM = "screen" ]; then
    echo -ne '\033P\033]12;grey\007\033\\'
  elif [ $TERM != "linux" ]; then
    echo -ne "\033]12;grey\007"
  fi
}; zle -N zle-line-init
