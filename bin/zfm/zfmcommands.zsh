#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: zfmcommands.zsh
#  Description: command picks up by zfm, for user to override or change
#       Author: rkumar http://github.com/rkumar/rbcurse/
#         Date: 2012-12-26 - 15:13
#      License: Freeware
#  Last update: 2013-01-29 20:28
# ----------------------------------------------------------------------------- #

# The delim you are using between commands. If commands use a space inside
# then use comma or some such delim. Otherwise commands will be delimited on space.
#
ZFM_MY_DELIM=,
#
# these are the commands that will be available when you press
# MENU_KEY + c (i.e. backtick + c) and will operate without any file names provided
# usually directory level. They are currently parsed using "read -A" and use IFS.
#
#
ZFM_MY_COMMANDS="ag,tree,tig stats,git stats,structure,stree,vidir"
# hotkeys for commands, put space if no hotkey
ZFM_MY_MNEM="a igseV"

#  Now place functions for above commands, otherwise it is expected they
#  are in path, if ZFM_xxx is first looked for, otherwise xxx in $PATH
#

ZFM_ag() {
    # check for whether you have ag installed (the_silver_searcher)
    cpattern=${cpattern:-""}
    vared -p "Pattern to ag for: " cpattern
    [[ -z $cpattern ]] && return 1
    ag "$cpattern"
    pause
    files=$( ag -l "$cpattern" )
    [[ $#files -eq 0 ]] && return 1
    #handle_files $files
    fuzzyselectrow $files
    if [[ $#selected_files -gt 0 ]]; then
        vim -c /$cpattern $selected_files
    fi
}
#
# remove the space when defining the function and add ZFM_ before it.
#
ZFM_tigstats() {
    # check for whether you have tig installed
    # If you have problems committing try setting GIT_EDITOR
    # e.g. export GIT_EDITOR=/usr/local/bin/vim
    echo "C for commit mode, S for status mode"
    tig status
}
ZFM_gitstats() {
    # check for whether you have git installed
    git status -sb | $PAGER
}
ZFM_tree() {
    # check for whether you have git installed
    tree -aCFl --charset=UTF8 --du --si -I .git | $PAGER
    #tree | $PAGER
    pause
}
ZFM_structure() {
    # check for whether you have git installed
    tree -aCFl --charset=UTF8 --du --si -I .git -d | $PAGER
    #tree | $PAGER
    pause
}
ZFM_mdfind() {
    perror "Not yet implemented, the results are usually too massive to be of use here"
}
ZFM_stree() {
    print -rl -- **/*(/N) | sed 's#/$##;s#/\([^/]*\)$#	\1#;s#\([^/]*/\)#    #g;s#\( *\)\(.*\)	#    \1|___#;s#^\([^ ]\)#|--  \1#;s#^ #| #'
    ct=$( print -rl -- **/*(/N) )
    if [[ -z "$ct" ]]; then
        print "0 directories"
    else
        print "$(echo $ct | wc -l) directories"
    fi
    pause
}
