#!/bin/bash -e
# this script requires:
#
#   - A running herbstluftwm instance
#   - herbstclient
#   - xdotool

prog="$0"
usage() {
    echo "Usage: $prog PROPERTY VALUE [CMD..]"
    echo ""
    echo "This tries to a window whose PROPERTY equals VALUE."
    echo "If such a window is found, it is focused using »herbstclient jumpto«."
    echo "If not, the given programe CMD is executed."
    echo ""
    echo "PROPERTY is one of:"
    echo "  class (the first entry of WM_CLASS)"
    echo "  classname (the second entry of WM_CLASS)"
    echo "  name (the window title)"
    echo ""
    echo "Example: $prog class Firefox firefox"
}

insufficient_arguments() {
    echo "Insufficiently many arugments." >&2
    usage >&2
    exit 1
}

property="$1" ; shift || insufficient_arguments
value="$1" ; shift || insufficient_arguments
if winid=$(xdotool search  --all --maxdepth 2 "--$property" "$value") ; then
    for i in $winid ; do
        herbstclient silent jumpto $(printf "0x%x\n" "$i") && break
    done
else
    if [ -n "$*" ] ; then
        # only 
        "$@" &
    fi
fi
