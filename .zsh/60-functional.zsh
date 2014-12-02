# These scripts provide a functional shell environment. This gives you the ability
# to use constructs similar to those in functional programming languages, but on
# the shell level.
#
# This project is uninspired at present and needs ideas.
#
# The 'each' command takes each line of input and maps it to _ in the command you
# give it. Iteration terminates if the command returns nonzero status.
#
# ls | each echo _                                        # The same as ls
# ls | each cat _                                         # Concatenates everything in this directory
# ls | each 'ln -s _ _.txt'                               # Symlinks each file as file.txt
# ls | each 'ln -s _ $(md5sum _ | awk "{print \$1}")'     # Symlinks each file as the MD5 of its contents
# ls | each 'test -f _ && echo _ || :'                    # Only print regular files
# ls | each 'echo _ $(($(wc -c < _) / $(wc -l < _)))'     # Display characters per line for each file
#
# You can also use 'each' to emulate other concepts:
#
# ls | each cat _                                         # This is really flat-mapping across files and lines of files
# ls | each 'test -d _ && ls _ || echo _'                 # Flat-map one level across directories
# ls | each 'test -d _ && ls _ | cat || echo _'           # Ditto, but this one gets proper output from ls
#
# And you can use it with things besides ls:
#
# ps -e | grep '\bdhclient\b' | cut -d' ' -f1 | each kill -9 _
# ifconfig | grep '^\w' | sed 's/\s.*//' | each ifconfig _ down
#
# 'peach' is like 'each', but runs its jobs in parallel:
#
# seq 1 10 | peach 'sleep 1 && echo _'                    # Returns after one second
#
# The 'y' command repeats something until the command returns nonzero status. From
# a functional point of view, it's a sort of fixed point on system state.
#
# y ps -el | grep perl                                    # Print all Perl processes continuously (CPU hog)
# y 'sleep 1 && ps -el' | grep perl                       # Print all Perl processes each second (not a CPU hog)
# y 'sleep 1 && ps -el | grep perl | wc -l'               # Print the number of Perl processes each second
# y 'test -f foo || touch foo'                            # Make sure the file 'foo' never goes away (CPU hog)
# y y                                                     # No clue, but seems dangerous
#
# 'uncat' does the opposite of cat:
#
# cat foo | command                                       # Prints the contents of foo into the command
# command | uncat bar                                     # Writes the output of command into bar
# command | uncat                                         # Writes the output of command into a tempfile and prints the tempfile
#
# In general, uncat has the invariant that 'cat $(cmd | uncat)' is equivalent to 'cmd', modulo buffering.
#
# 'repeat' repeats something a fixed number of times:
#
# repeat 10 echo hi                                       # Says 'hi' ten times

# This is useful for things like benchmarking.

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
