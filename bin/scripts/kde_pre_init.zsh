#!/bin/zsh
for wid in $(xwininfo -root -tree | \
    sed '/"plasma-desktop": ("Plasma" "Plasma")/!d; s/^  *\([^ ]*\) .*/\1/g'); do
    xprop -id ${wid} -remove _KDE_NET_WM_SHADOW
done

