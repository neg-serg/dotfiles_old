#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: bookmark.zsh
#  Description: 
#       Author: rkumar http://github.com/rkumar/zfm/
#         Date: 2013-02-10 - 15:51
#      License: GPL
#  Last update: 2013-03-01 18:04
# ----------------------------------------------------------------------------- #
#  bookmark.zsh  Copyright (C) 2012-2013 rahul kumar
#
# Vim_mode will not execute a char binding in the main binding, it will get
# swallowed. This has to go in vim's binding, but vim has not go loaded until mode is set.
#
# MARK stores the cursor position not the filename, this means that if the directory
#  listing is sorted or filtered, then the marks will not land on the correct file.
#  THus we do not keep file names although we can. This hold true also if files are added or deleted
#   but do NOTE that sorting will affect this. However, you can still jump to the directroy easily.
#
vim_bind_key "m" zfm_mark
## to enable users in other modes to set a mark, leader + m.
zfm_bind_key "ML m" zfm_mark
zfm_bind_key "'" zfm_jump_to_mark
zfm_bind_subcommand "marks" zfm_print_marks
zfm_bind_subcommand "write" config_write

# also :marks to list marks
# NOTE: TODO These are also selectors so one should be able to do d'a or y'b etc

typeset -Ag M_MARKS
M_MARKS=()
# I am now trying to keep local marks in a different format that can be saved and read up
# and will take less memory
# LOCAL_MARKS[$PWD]="a 10 b 30 t 55 y 12"
# The above is a string but can be used as a hash
typeset -Ag M_LOCAL_MARKS
M_LOCAL_MARKS=()


function zfm_mark () {
    #local ret=0
    #return $ret
    # get a char a-ZA-Z 
    # set current location (path , cursor and sta as that)
    #
    # Each path can have its own a-z
    #  hh[PATH:a]="sta:cursor" or rather have abs_cursor, so we can goto
    #  line
    #
    # A-Z are across paths
    # h[A]="/some/path : abs_cursor
    #  see :help marks or help ' for 0-9 these are not set directly but
    #  are related to viminfo, we can use these for last edited files.
    #  however the desc says something else
    #
    #
    print -n "Enter character to create mark [a-z A-Z]: "
    read -k reply
    [[ $reply == "" || $reply == "" ]] && return
    local pos
    curpos pos
    if [[ $reply =~ [a-z] ]]; then
        local mm
        #M_MARKS[$PWD:$reply]=$pos
        mm=$M_LOCAL_MARKS[$PWD]
        if [[ -z $mm ]]; then
            #mm="$reply $pos"
            mm="$reply $vpa[$CURSOR]"
        else
            # why I did a hash was to prevent dupes, then i forgot and made it a string
            typeset -A mmh
            mmh=( $(print $mm) )
            mmh[$reply]=$pos
            mmh[$reply]=$vpa[$CURSOR]
            mm=( ${(kv)mmh} )
            #mm+=" $reply $pos"
        fi
        M_LOCAL_MARKS[$PWD]=$mm
        #pinfo "$0 set mark ($PWD:$reply) for $pos"
        pinfo "$0 set mark $M_LOCAL_MARKS[$PWD]"
        M_MODIFIED=1
    elif [[ $reply =~ [A-Z] ]]; then 
        M_MARKS[$reply]="$PWD:$pos"
        pinfo "$0 set mark ($reply) for $PWD $pos"
        # updated so we can save later on exit
        M_MODIFIED=1
    else
        perror "$0: $reply is not handled as a mark"
        pause
    fi

}
function zfm_jump_to_mark () {
    print -n "Enter mark to jump to [a-z A-Z]: "
    read -k reply
    [[ $reply == "" || $reply == "" ]] && return
    local pos rep dir columns
    pos=1
    if [[ $reply =~ [a-z] ]]; then
        #pos=$M_MARKS[$PWD:$reply]
        pos=
        mm=$M_LOCAL_MARKS[$PWD]
        if [[ -n $mm ]]; then
            typeset -A mmh
            mmh=( $( print $mm ) )
            #pos=$mmh[$reply]
            fn=$mmh[$reply]
            # convert filename to position, we need abso position since we could be on some other page
            pos=$viewport[(i)$fn]
            [[ $pos -gt $#viewport ]] && pos=
            unset mmh mm
        fi
        if [[ -n $pos ]]; then
            zfm_goto_line $pos
        else
            pinfo "No bookmark with $reply. Finding first match.."
            vim_file_starting_with $reply
        fi
    elif [[ $reply =~ [A-Z] ]]; then 
        rep=$M_MARKS[$reply]
        if [[ -z $rep ]]; then
            perror "$0: No such mark ($reply)"
            pause
            return
        fi
        columns=("${(s/:/)rep}")
        dir=$columns[1]
        pos=$columns[2]
        pos=${pos:-1}
        #pinfo "$0: Got $dir, $pos for $reply"
        zfm_open_dir $dir $pos
    else
        ## allow user to map combination with ' outside of chars such as ' '
        # perhaps first look in mode binding and then global
        key="' $reply"
        zfm_exec_key_binding $key
    fi
}
## Print marks set 
#  Ideally I need to print only local marks for current folder, not all local marks
#
function zfm_print_marks() {
    clear
    pbold "Marks set"
    print
    # first print global ones
    pbold "Global marks"
    print
    for key in ${(k)M_MARKS} ; do
        if [[ $key =~ ^[A-Z]$ ]]; then
            val=$M_MARKS[$key]
            columns=("${(s/:/)val}")
            dir=$columns[1]
            pos=$columns[2]
            print -rl -- " $fg_bold[white]$key$reset_color = $dir $pos"
        fi
    done
    print
    pbold "Local marks"
    print
    mm=$M_LOCAL_MARKS[$PWD]
    print "Marks for $PWD are : $mm"
    for key in ${(k)M_MARKS} ; do
        if [[ $key =~ ^[A-Z]$ ]]; then
            #print "ignoring $key"
        else
            columns=("${(s/:/)key}")
            dir=$columns[1]
            ch=$columns[2]
            if [[ $dir == $PWD ]]; then
                pos=$M_MARKS[$key]
                print -rl -- " $fg_bold[white]$ch$reset_color = $pos $fg[green]($dir)$reset_color"
            else
                #print "rejected $dir ($PWD)"
            fi
        fi
    done
}
function first_char_is() {
    local file=$1:t
    local ch=$2
    [[ $file[1] == $ch ]] && return 0
    return 1
}
function file_matching() {
    local file=$1:t
    local ch=$2
    [[ $file =~ $ch ]] && return 0
    return 1
}
function vim_file_starting_with() {
    setopt localoptions
    setopt noextendedglob
    # to prevent ^ from getting globbed.
    #offset=$(return_next_match first_char_is $1)
    offset=$(return_next_match file_matching ^$1 )
    setopt extendedglob
    [[ -n $offset ]] && vim_motion $offset
}
