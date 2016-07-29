#!/bin/bash

if [[ -n "$@" ]]; then
	coproc (p clip "$@" > /dev/null 2>&1)
    echo "$@" > "$(readlink -f ~/tmp)/pass_rofi_picked"
	exit
fi

cat "$(readlink -f ~/tmp)/pass_rofi_fifo"
