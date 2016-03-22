#!/bin/bash
#
# wildefyr - 2016 (c) wtfpl
# simple notify script that uses fyre
# depends on: lemonbar txtw && a sane unix environment
# inspired by: http://blog.z3bra.org/2014/04/pop-it-up.html

ARGS="$@"

usage() {
    cat << EOF
Usage: $(basename $0) [-d seconds] [-D] [-m message]
    -d : Duration of notification in seconds.
    -D : Disable notifiction sound.
    -m : Message to display.
    -h : Print this help.

Exit codes:
    0 : Progran ran succesfully.
    1 : Argument Error
EOF

    test -z $1 && exit 0 || exit $1
}

fyrerc() {
    # wildefyr - 2016 (c) wtfpl
    # source file for global variables across the environment

    ROOT=$(lsw -r)
    SW=$(wattr w $ROOT)
    SH=$(wattr h $ROOT)

    PFW=$(pfw)
    CUR=${2:-$(pfw)}

    BW=${BW:-2}

    minW=$((466 + BW))
    minH=$((252 + BW))

    X=$(wattr x $CUR)
    Y=$(wattr y $CUR)
    W=$(wattr w $CUR)
    H=$(wattr h $CUR)

    XGAP=${XGAP:-$((20))}
    TGAP=${TGAP:-$((40))}
    BGAP=${BGAP:-$((20))}
    # add $BW for non-overlapping borders / will probably cause glitches
    IGAP=${IGAP:-$((0))}
    VGAP=${VGAP:-$((0))}

    ACTIVE=${ACTIVE:-0xD7D7D7}
    WARNING=${WARNING:-0xB23450}
    INACTIVE=${INACTIVE:-0x737373}

    BLUR=0
    # WALL=$(cat $(which bgc) | head -n 1 | sed 's#~#/home/wildefyr#')

    # how long to wait to repeat loop in runfyre.sh
    DURATION=5

    FYREDIR=${FYREDIR:-~/.config/fyre}
    GROUPSDIR=${GROUPSDIR:-$FYREDIR/groups}
    LAYOUTDIR=${LAYOUTDIR:-$FYREDIR/layouts}

    test ! -d $GROUPSDIR && mkdir -p $GROUPSDIR
    test ! -e $LAYOUTDIR && mkdir -p $LAYOUTDIR

    FSFILE=${FSFILE:-$FYREDIR/fullinfo}
    MPVPOS=${MPVPOS:-$FYREDIR/mpvposition}
}


createDialog() {
    fyrerc

    # kill notify on new run
    POPNAME='pop'
    pidof -s $POPNAME 2>&1 > /dev/null && kill -9 $(pidof -s $POPNAME)

    POPUPFILE=${POPUPFILE:-/tmp/.popup}

    txtw -s 12 "$@" > $POPUPFILE
    barw=$(cat /tmp/.popup | awk '{for (i=1;i<=NF;++i) total += $i; print total}')
    test -f $POPUPFILE && rm $POPUPFILE

    barw=$((barw + 10))
    barx=$((SW - XGAP - 240 - 40 - barw + BW))
    bary=$((TGAP - 30))
    barh=$XGAP
    bar_bg='#66D7D7D7'

    barx=$((barx + BW))
    bary=$((bary + BW))
    barh=$((barh - 2*BW))
    barw=$((barw - 2*BW))

    bar_bg='#cc03070B'
    bar_fg='#D7D7D7'
    bar_font='fixed'

    (echo "%{c} $@ %{c}"; sleep $DURATION) | {
        exec -a $POPNAME lemonbar -d -g ${barw}x${barh}+${barx}+${bary} -B${bar_bg} -F${bar_fg} -f ${bar_font}
    }
}

main() {
    ROOT=$(lsw -r)
    SW=$(wattr w $ROOT) SH=$(wattr h $ROOT)

    PFW=$(pfw)
    CUR=${2:-$(pfw)}

    BW=${BW:-2}

    minW=$((466 + BW)) minH=$((252 + BW))
    X=$(wattr x $CUR) Y=$(wattr y $CUR) W=$(wattr w $CUR) H=$(wattr h $CUR)
    XGAP=${XGAP:-$((20))} TGAP=${TGAP:-$((40))} BGAP=${BGAP:-$((20))}
    # add $BW for non-overlapping borders / will probably cause glitches
    IGAP=${IGAP:-$((0))}
    VGAP=${VGAP:-$((0))}

    ACTIVE=${ACTIVE:-0xD7D7D7}
    WARNING=${WARNING:-0xB23450}
    INACTIVE=${INACTIVE:-0x737373}

    BLUR=0
    # WALL=$(cat $(which bgc) | head -n 1 | sed 's#~#/home/wildefyr#')

    # how long to wait to repeat loop in runfyre.sh
    DURATION=5

    FYREDIR=${FYREDIR:-~/.config/fyre}
    GROUPSDIR=${GROUPSDIR:-$FYREDIR/groups}
    LAYOUTDIR=${LAYOUTDIR:-$FYREDIR/layouts}

    test ! -d $GROUPSDIR && mkdir -p $GROUPSDIR
    test ! -e $LAYOUTDIR && mkdir -p $LAYOUTDIR

    FSFILE=${FSFILE:-$FYREDIR/fullinfo}
    MPVPOS=${MPVPOS:-$FYREDIR/mpvposition}

    # has the user inputed *anything*
    test -z $1 && usage 1

    NOTIFICATION=${NOTIFICATION:-~/files/sounds/notification.mp3}
    SOUNDENABLED=true

    for arg in "$@"; do
        case $arg in
            -d)
                DURATION=$arg
                DURATIONFLAG=false
                test "$MESSAGEFLAG" = "true" && MESSAGEFLAG=false
                ;;
            -D)
                SOUNDENABLED=false
                test "$MESSAGEFLAG" = "true" && MESSAGEFLAG=false
                ;;
            -?)
                test "$MESSAGEFLAG" = "true" && MESSAGEFLAG=false
                ;;
            -h) usage 0 ;;
        esac

        test "$MESSAGEFLAG" = "true" && \
            ARGSTRING="$ARGSTRING $arg"

        case $arg in
            -m) MESSAGEFLAG=true  ;;
            -d) DURATIONFLAG=true ;;
        esac

    done

    createDialog $ARGSTRING
}

main $ARGS
