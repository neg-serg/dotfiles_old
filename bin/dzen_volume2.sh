#!/bin/bash
level=$(get_it_from_alsa_or_oss)

# we use a fifo to buffer the repeated commands that are common with 
# volume adjustment
pipe='/tmp/volpipe'

# define some arguments passed to dzen to determine size and color.
dzen_args=( -tw 200 -h 25 -x 50 -y 50 -bg '#101010' )

# similarly for gdbar
gdbar_args=( -w 180 -h 7 -fg '#606060' -bg '#404040' )

# spawn dzen reading from the pipe (unless it's in mid-action already).
if [[ ! -e "$pipe" ]]; then
  mkfifo "$pipe"
  (dzen2 "${dzen_args[@]}" < "$pipe"; rm -f "$pipe") &
fi

# send the text to the fifo (and eventually to dzen). oss reports 
# something like "15.5" on a scale from 0 to 25 so we strip the decimals 
# and send gdbar an optional "upper limit" argument
(echo ${level/.*/} 25 | gdbar "${gdbar_args[@]}"; sleep 1) >> "$pipe"
