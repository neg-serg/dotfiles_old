function each(){
    while read line; do
        eval "${*//_/'$line'}" &
    done
    wait
}

function peach(){
    while read line; do
        eval "${*//_/'$line'}" &
    done
    wait
}


function ineachdir(){
    PRINT=false
    TOSTDERR=true
    if [ "$1" == "-p" ] ; then
        PRINT=true
        TOSTDERR=true
        shift
    elif [ "$1" == "-po" ] ; then
        PRINT=true
        TOSTDERR=false
        shift
    fi
    set -e
    while read line ; do
        pushd "${line}" >/dev/null
        if $PRINT ; then
            if $TOSTDERR ; then
                pwd >&2
            else
                pwd
            fi
        fi
        eval "${*}"
        popd >/dev/null
    done
}

function repeat(){
    repeat_count=$1
    shift
    for ((i = 0; i < repeat_count; ++i)); do
        eval "$@"
    done
}

function uncat(){
    temporary=${1:-$(mktemp)}
    echo $temporary
    cat > $temporary
}

function y(){
    while eval "$*"; do
        :
    done
}
