#!/bin/zsh

ROFI='rofi -font "Pragmata Pro for Powerline bold 12" -yoffset -22 -location 6 -width 1850 -lines 10 -dmenu -p "[>>]"'
ARTIST=$( mpc ls | eval $ROFI)
if [[ $ARTIST == "" ]]; then
  exit 1
else
  ALBUM=$( echo -e "Play All\n$( mpc ls "$ARTIST" )" | eval $ROFI)

  if [[ $ALBUM == "" ]]; then
    exit 1
  else
    if [[ $ALBUM == "Play All" ]]; then
      mpc add "$ARTIST"
    else
      mpc add "$ALBUM"
    fi
    mpc play
  fi
fi

exit 0
