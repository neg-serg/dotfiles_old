#!/bin/bash

# a q3-like (or yakuake-like) terminal for arbitrary applications.
#
# this lets a new monitor called "q3terminal" scroll in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet). If the monitor already exists it is scrolled out of
# the screen and removed again.
#
# Warning: this uses much resources because herbstclient is forked for each
# animation step.
#
# If a tag name is supplied, this is used instead of the scratchpad

tag="${1:-sidebar}"
cur_mon="${2:-0}"

hc() {
    #echo "hc $@" >&2 ;
    herbstclient "$@" ;
}

mrect=( $(hc monitor_rect -p ${cur_mon} ) )
termwidth=$((${mrect[2]}*3/10))
termheight=${mrect[3]}

rect=(
    $termwidth
    $termheight
    $((${mrect[2]}-$termwidth))
    ${mrect[1]}
)


x_line=$((${mrect[2]}-$termwidth))


hc add sidebar


monitor=sidebar

exists=false
if ! hc add_monitor $(printf "%dx%d%+d%+d" "${rect[@]}") \
                    "$tag" $monitor 2> /dev/null ; then
    exists=true
fi

update_geom() {
    local geom=$(printf "%dx%d%+d%+d" "${rect[@]}")
    hc move_monitor "$monitor" $geom
}

steps=5
interval=0.01

animate() {
    progress=( "$@" )
    for i in "${progress[@]}" ; do
        echo $i
        rect[2]=$((${x_line}+(i*termwidth)/$steps))
        #echo ${rect[@]}
        update_geom
        sleep "$interval"
    done
}

show() {

    hc lock
    hc raise_monitor $monitor
    hc focus_monitor $monitor
    hc unlock
    hc lock_tag $monitor
    #animate $(seq $steps -1 0)
    update_geom
}

hide() {
    rect=( $(hc monitor_rect "$monitor" ) )
    local tmp=${rect[0]}
    rect[0]=${rect[2]}
    rect[2]=${tmp}
    local tmp=${rect[1]}
    rect[1]=${rect[3]}
    rect[3]=${tmp}
    termheight=${rect[1]}

    #animate $(seq 0 +1 $steps)
    hc remove_monitor $monitor
}

[ $exists = true ] && hide || show
