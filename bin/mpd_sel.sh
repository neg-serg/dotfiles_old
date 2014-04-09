#!/bin/zsh

DMENU="${HOME}/bin/dmenu_select"

ARTIST=$( mpc ls | $DMENU )

if [[ $ARTIST == "" ]]; then
  exit 1
else
  ALBUM=$( echo -e "Play All\n$( mpc ls "$ARTIST" )" | $DMENU )

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
