#!/bin/bash
#
#   Author:      Twily                   2015
#   Description: 4chan post number/id monitor
#   Usage:       $ sh ./4trips https://boards.4chan.org/g/catalog <S> <N>
#   Requires:    wget, sed
#   Note:        Allow 10 seconds margin for post ids to appear in 4trips
#                from the actual time they are posted
#


S=${2:-10}  # Seconds to wait before refresh
N=${3:-1}   # Index number of first thread in catalog

tA=0 && tB=0

while true; do
    T=$RANDOM

    echo -ne "\033[1;31m>"

    F1="4c.catalog."$T".tmp"
    F2="4c.thread."$T".tmp"

    wget $1 --quiet --no-cache --no-http-keep-alive -O ./$F1
    echo -ne "\033[1;33m>"

    sed -i 's/{/{\n/g' ./$F1
    grep \"id\" < ./$F1 > ./$F2

    sed -i 's/,"semantic.*//g' ./$F2
    sed -i 's/"id"://g' ./$F2
    sed -i 's/,".*//g' ./$F2
    sed -i 's/}//g' ./$F2

    R=$(sed $N'q;d' < ./$F2)
    D=$(date)

    tB=$tA && tA=$R
    tC=$(( $tA - $tB ))
    echo -ne "\033[1;32m> \033[0m"

    if [ "$R" != "$tC" ]; then p=""; for i in `seq 1 $tC`; do p="$p="; if [ $i -ge 80 ]; then break; fi; done; fi
    echo -e "Last Post ID   \033[1;31m$R   \033[0m$D   \033[1;30mWait "$S"s   \033[1;33m$tC \033[1;32m$p\033[0m"

    rm -f ./$F1
    rm -f ./$F2
    
    sleep $S
done

exit 0
