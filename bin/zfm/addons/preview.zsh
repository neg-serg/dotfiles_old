#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: preview.zsh
#  Description: print a preview of a file on right side
#       Author: rkumar http://github.com/rkumar/zfm/
#         Date: 2013-02-13 - 22:34
#      License: GPL
#  Last update: 2013-02-16 18:38
# ----------------------------------------------------------------------------- #
#   preview.zsh  Copyright (C) 2012-2013 rahul kumar



zfm_bind_key "ML p" pr_file_preview

## print a preview of file content on right side
#  Currently it gets wiped out since directory does a display immediately so i've put a 
#  pause.
#  This highlights need to have a flag that redraw or break should not happen
#
#  TODO: take care of dirs and tgz files, also check for type of file so we don't make a mess
#  of terminal
#
function pr_file_preview() {
    local file=$1
    file=${file:-$vpa[$CURSOR]}

    local filler row col c wid len

    row=1
    col=60
    (( len = ZFM_LINES - 2 ))
    (( wid = ZFM_COLS - col ))
    filler=${(r:$wid:: :)}
    c=1
    tput cup 0 $col 
    print "==== $file ===="
    type=$(filetype $file)
    case $type in
        "txt")
            buffer=("${(f)$(< $file )}")
            ;; 
        "DIR")
            #buffer=("${(f)$( print -rl -- $file/* )}")
            ## unfortunately this repeats the dir name which is not needed
            # ls gives too long a list with the filename at the end
            buffer=("${(f)$( listdir.pl $file/* | tr $'\t' ' ' )}")
            ;;
        "zip")
            buffer=("${(f)$( tar ztvf $file )}")
            ;;
        "SQLite")
            buffer=("${(f)$( sqlite3 $file '.tables' )}")
            #buffer=("${(f)$( sqlite3 $file '.schema' )}")
            ;;
        *)
            buffer=("${(f)$( stat $file )}")
            ;; 
    esac

    for (( ii = 1; ii <= $len; ii++ )); do
        if [[ $c -gt $#buffer ]]; then
            line=$filler
        else
            line=$buffer[$c]
        fi
        tput cup $row $col
        if [[ $#line -gt $wid ]]; then
            print -rl -- $line[1,$wid]
        elif [[ $#line -lt $wid ]]; then
            print -rl -- ${(r:$wid:: :)line}
        else
            print -rl -- $line
        fi

        (( c++ ))
        (( row++ ))
    done
    NO_BREAKING=1
    M_NO_REPRINT=1

}
