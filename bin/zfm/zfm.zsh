#!/usr/bin/env zsh
# header {
# vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
# ----------------------------------------------------------------------------- #
#         File: zfm.zsh
#  Description: file/dir browser/navigator using hotkeys
#       Author: rkumar http://github.com/rkumar/rbcurse/
#         Date: 2012-12-17 - 19:21
#      License: GPL
#  Last update: 2013-03-03 15:13
#   This is the new kind of file browser that allows selection based on keys
#   either chose 1-9 or drill down based on starting letters
#
#   In memory of my dear child Gabbar missing since Nov 13th, 2012.
# ----------------------------------------------------------------------------- #
#   Copyright (C) 2012-2013 rahul kumar

# header }
ZFM_DIR=${ZFM_DIR:-~/bin}
export ZFM_DIR
export EDITOR=${EDITOR:-vi}
## This is the startup mode, also whenever escaping from another mode such as HINTs
#  app will come back to this mode
export ZFM_DEFAULT_MODE=${ZFM_DEFAULT_MODE:-HINT}
source ${ZFM_DIR}/zfm_menu.zsh
source $ZFM_DIR/zfm_viewoptions.zsh
setopt MARK_DIRS
## color of current line: use from autocolors red blue white black cyan magenta yellow
CURSOR_COLOR="red"

export M_FULL_INDEXING=
export TAB=$'\t'
set_auto_view
# This did not work when called from a function
#stty_settings
ttysave=$(stty -g)
#stty raw echo
    # We need C-c for mappings, so we disable it 
    stty intr '^-'
    # this is strangely eating up C-o
    stty flush '^-'
    # so we can trap C-\ to abort
    stty quit '^-'
    # so we can trap C-q to quit
    stty start '^-'

#
# for printing details 
zmodload zsh/stat
zmodload -F zsh/stat b:zstat
M_SCROLL=${M_SCROLL:-10}
export M_SCROLL


# list_printer {
# Used to take title and data, now takes no parameters
# This was called in a loop from the caller, everytime a file was selected we would return to caller
# and come back here, now we only return when caller wants to exit.
#
function list_printer() {
    selection=
    local width=30
    #local title=$1
    title="$PWD"
    #local viewport vpa fin
    param=$(print -rl -- *(M))
    myopts=("${(@f)$(print -rl -- $param)}")
    

    # using cols to calculate cursor movement right
    LIST_COLS=3
    local tot=$#myopts
    #local sta=1


    # 2012-12-26 - 00:49 trygin this out so after a selection i don't lose what's filtered
    # but changing dirs must clear this, so it's dicey
    PATT=${PATT:-""}
    local mark ic approx
    globflags=
    ic=
    approx=
    while (true)
    do
        if [[ -z $M_NO_REPRINT ]]; then
            clear
            print -l -- ${M_MESSAGE:-"  $M_HELP"}
            (( fin = sta + $PAGESZ )) # 60

            # THIS WORKS FINE but trying to avoid external commands
            #viewport=$(print -rl -- $myopts  | grep "$PATT" | sed "$sta,${fin}"'!d')
            # this line replace grep and searches from start. if we plae a * after
            # the '#' then the match works throughout filename
            ic=${ZFM_IGNORE_CASE:+"-i"}
            approx=${ZFM_APPROX_MATCH+a1}
            # in case other programs need to display or account for, put in round bracks
            globflags="$ic$approx"
            # we keep filtering, not refreshing so deleted moved files still show up
            # the caller queries, and that sucks

            # I am fed up of this crazy crap. Things were great when i used grep and sed
            # I am giong back even though it will cause various changes
            if [[ -z $M_MATCH_ANYWHERE ]]; then
                #viewport=(${(M)myopts:#(#${ic}${approx})$PATT*})
                mark="^"
                prefix="^"
            else
                #viewport=(${(M)myopts:#(${ic}${approx})*$PATT*})
                mark=" "
                prefix=""
            fi
            viewport=("${(@f)$(print -rl -- $myopts | grep $ic "${prefix}$PATT" )}")

            ## testing out 
            #if [[ $#viewport -eq 0 ]]; then
            ## Ifwe don't get any results lets take the last entered pattern
            ## and place a .* before it so its a little more helpful. This is since
            ## sometimes there are too many common characters in file names.
            #
            ## This was nice but can be confusing esp when you backspace
            #
            if [[ -n "$M_SMART_FUZZY" ]]; then
                if [[ -z $viewport ]]; then
                    if [[ $#PATT -ge 2 ]]; then
                        local testpatt=$PATT
                        testpatt[-2]+='.*'
                        ## we repeat the above command, so make sure it is identical
                        viewport=("${(@f)$(print -rl -- $myopts | grep "${prefix}$testpatt" )}")
                        [[ ! -z $viewport ]] && PATT=$testpatt
                    fi
                fi
            fi


            ## Run a filter entered by the user on the existing data
            #
            if [[ -n "$M_CFILTER" ]]; then
                viewport=("${(@f)$(print -rl -- $viewport | eval "$M_CFILTER" )}")
            fi

            ## these lines must come after any filtering, othewise totals displayed
            ## are wrong
            let tot=$#viewport  # store the size of matching rows prior to paging it. 2013-01-09 - 01:37 
            END=$tot
            [[ $fin -gt $tot ]] && fin=$tot
            
            ## this line replaces the sed filter
            #  2013-02-09 - 00:38 I am trying to separate viewport and vpa
            #  viewport will have data prior to grep so "yG" etc can work. I am losing the entire
            #  list which is paged. I only have the slice shown, or the entire myopts.
            #  ------------- operation code commaneted out START ----
            #viewport=(${viewport[$sta, $fin]})
            #vpa=("${(@f)$(print -rl -- $viewport)}")
            #  ------------- operation code commaneted out END ----
            vpa=(${viewport[$sta, $fin]})
            #vpa=("${(@f)$(print -rl -- $viewport[$sta, $fin])}")
            # -------- end of new code -----


            VPACOUNT=$#vpa
            #PAGE_END=$VPACOUNT
            #PAGE_TOP=1
            (( PAGE_END= VPACOUNT + sta - 1 ))
            (( PAGE_TOP = sta ))
            ZFM_LS_L=
            if (( $VPACOUNT <  (ZFM_LINES -2 ) )); then
                # need to account for title and read lines at least and message line
                LIST_COLS=1
                # this could have the entire listing which contains TABS !!!
                (( width= ZFM_COLS - 2 ))
                ZFM_LS_L=1
            elif [[ $VPACOUNT -lt 40 ]]; then
                LIST_COLS=2
                (( width = (ZFM_COLS / LIST_COLS) - 2 ))
            else
                LIST_COLS=3
                # i can use 1 instead of 2, it touches the end, 2 to be safe for other widths
                (( width = (ZFM_COLS / LIST_COLS) - 2 ))
            fi
            # NO, vpa is not entire thing, its grepped and filtered, so it can't be more than page size=
            #let tot=$#vpa
            [[ $fin -gt $tot ]] && fin=$tot
            local sortorder=""
            [[ -n $ZFM_SORT_ORDER ]] && sortorder="o=$ZFM_SORT_ORDER"

            ## This relates to the new cursor functionality. Arrow keys allow us to
            ## move around the file list and press ENTER
            #
            (( CURSOR == -1 || CURSOR > tot )) && CURSOR=$tot
            #
            # If user presses down at last file, and there are more we should
            #  page down, but that's not working at present, some glitches, so we just
            #  bring cursor back to 1
            #(( CURSOR > $VPACOUNT && CURSOR < $tot )) && { sta=$CURSOR ; CURSOR=1 }
            # this is fine but does not redraw the page until cursor moves
            (( CURSOR > VPACOUNT && CURSOR < tot )) && { zfm_next_page  }
            ## if there are no rows then CURSOR gets set to 0 and remains there forever, check
            (( CURSOR == 0 )) && CURSOR=1


            print_title "$title $sta to $fin of $tot ${COLOR_GREEN}$sortorder $ZFM_STRING ${globflags}${COLOR_DEFAULT} "

            ## This is the original line, which had a pipeline. I had to break this up
            ## since it updates a cache of file details and this cache is lost each
            ## time a call is made, since it is in another process
            #
            #print -rC$LIST_COLS "${(@f)$(print -rl -- $viewport | numberlines -p "$PATT" -w $width)}"
            # 2013-02-09 - 00:49 replaced viewport with vpa
            #numberlines -p "$PATT" -w $width $viewport
            numberlines -p "$PATT" -w $width $vpa
            print -rC$LIST_COLS "${(@f)$(print -l -- $OUTPUT)}"

            [[ -n $M_SELECTION_MODE ]] && mode="[SEL $#selectedfiles] "
        fi # M_NO_REPRINT

        ## ---
        #  If we want a file preview we will have to put the code here, or 
        #  a hook here for stuff that needs to be printed in addition to the listing
        #  since this list will erase anything printed on the side.
        #  ---

        M_NO_REPRINT=
        #print -n "$mode${mark}$PATT > "
        print -n "\r$mode${mark}$PATT > "
        # prompt for key PROMPT
        #read -k -r ans
        # see zfm_menu.zsh for _read moved there

        ## check for pending key - should be integrate this with read_k so it works everywhre
        reply=
        pop_key_stack
        ret=0
        [[ -z $reply ]] && { _read_keys; ret=$? }

        #M_MESSAGE=
        if [[ $ret != 0 ]]; then
            # maybe ^C
            perror "$ret: Got error from _read_keys: r=$reply , k=$key"
            key=''
            ans=''
            #break
        else
            #[[ -n $ckey ]] && reply=$ckey
            ans="${reply}"
            #pdebug "Got ($reply)"
        fi
        if [[ $ans == "C-q" ]]; then
            if [[ $ZFM_MODE == $ZFM_DEFAULT_MODE ]]; then
                QUITTING=true
                break
            else
                zfm_set_mode $ZFM_DEFAULT_MODE
            fi
        elif [[ $ans == '' ]]; then
            QUITTING=true
            break
        elif [[ -n $ZFM_MODE ]]; then

                if [[ -z $MODE_KEY_HANDLER ]]; then
                    MODE_KEY_HANDLER=${ZFM_MODE:l}_key_handler
                fi
                ZFM_KEY=$ans
                NO_BREAKING=
                $MODE_KEY_HANDLER $ZFM_KEY
                ans=
                ## 2013-02-22 - 00:36 LP added next line so break from mode can happen
                [[ -n $QUITTING ]] && break
                # should be not break only if selection has been set XXX
            # 2013-02-22 - 00:14 LP commented off next line
                #[[ -n $NO_BREAKING ]] || break
            # above is for modes
        else
            [[ $ZFM_QUIT_KEY == $ans ]] && { QUITTING=true; ans= ; break; }

            zfm_exec_key_binding $ans
            [[ -n $binding ]] && {  ans= ; 
            # 2013-02-22 - 00:14 LP commented off next line
                #[[ -n $NO_BREAKING ]] || break
                ## added 2013-02-22 - 00:31 LP
                [[ -n $QUITTING ]] && break
            }
            #[[ -n $binding ]] && { $binding ; ans= ; break }
        fi
        ## added 2013-02-22 - 00:31 LP 3 lines
        [[ -n $QUITTING ]] && break
        [[ -n $selection ]] && zfm_open_file $selection
        selection=
        ## end added LP

        ## 2013-01-24 - 20:24 thre break in the next line without clearing ans
        ## was causing the unused error to keep popping up when no rows were returned
        ## 2013-02-22 - 01:05 LP break removed from next line
        #[[ $sta -ge $tot ]] && { sta=1; CURSOR=1;  ans= ; pinfo "wrapping"; }
        # break takes control back to MARK1 section below

    done
}
# }
function zfm_next_page () {
    local pos
    curpos pos 
    (( pos += PAGESZ1 ))
    zfm_goto_line $pos
    return
}
function zfm_prev_page () {
    local pos
    curpos pos 
    (( pos -= PAGESZ1 ))
    zfm_goto_line $pos
}
## currently called by C-d
#  scrolls using value of M_SCROLL
#
function zfm_scroll_down () {
    local pos
    curpos pos 
    (( pos += M_SCROLL ))
    zfm_goto_line $pos
}
## currently called by C-b
#  scrolls using value of M_SCROLL
function zfm_scroll_up () {
    local pos
    curpos pos 
    (( pos -= M_SCROLL ))
    zfm_goto_line $pos
}
function zfm_go_top () {
    CURSOR=1
    sta=1
}
function zfm_go_bottom () {
    CURSOR=$VPACOUNT
    (( sta = tot - VPACOUNT + 1 ))
}
function patt_toggle() {
    local gpatt=$1
    gpatt=${gpatt:gs/*//}
    gpatt="${gpatt}"
    if [[ -z "$ZFM_FUZZY_MATCH_DIR" ]]; then
    else
        gpatt=$(print $gpatt | sed 's/\(.\)/\1\*/g')
    fi
    print "$gpatt"
}

function toggle_match_from_start() {
    # default is unset, it matches what you type from start
    if [[ -z "$M_MATCH_ANYWHERE" ]]; then
        M_MATCH_ANYWHERE=1
    else
        M_MATCH_ANYWHERE=
    fi
    export M_MATCH_ANYWHERE
}
# utility functions {
# check if there is only one file for this pattern, then straight go for it
# with some rare cases the next char is a number, so then don't jump.
function check_patt() {
    #local p=${1:s/^//}  # obsolete, refers to earlier grep version
    local p=$1
    local approx
    local ic=
    ic=${ZFM_IGNORE_CASE+i}
    approx=${ZFM_APPROX_MATCH+a1}
    ## XXX TODO needs to be checked sicne we have moved back to grep
    if [[ -z $M_MATCH_ANYWHERE ]]; then
        # match from start - default
        lines=$(print -rl -- (#$ic${approx})${p}*)
    else
        lines=$(print -rl -- (#$ic${approx})*${p}*)
    fi
    # need to account for match from start
    print $lines
}
## triggered upon pressing :.
#  Allows user to type in command such as help, marks etc
#  Someday we will allow history and completion
#
function subcommand() {
    #dcommand=${dcommand:-""}
    #[[ $dcommand == "?" ]] && dcommand=""
    local dcommand

    vared -h -p "Enter command (? - help): " dcommand

    [[ "$dcommand" = "q" || $dcommand = "quit" ]] && { QUITTING=1 ; break }
    [[ "$dcommand" = "wq" ]] && { config_write; QUITTING=1 ; break }
    [[ "$dcommand" = "x" ]] && { [[ -n "$M_MODIFIED" ]] && config_write; QUITTING=1 ; break }

    # write command to history file
    [[ -n $dcommand ]] && print -s -- "$dcommand"

    if [[ $dcommand[1] == '!' ]]; then
        dcommand=${dcommand[2,-1]}
        # subst selected files for %%  NOT TESTED
        if [[ $dcommand = *%%* ]]; then
            dcommand=${(S)dcommand//\%\%/${selectedfiles:q}}
        fi
        eval "$dcommand"
        pause
        return
    else
        binding=$M_SUBCOMMAND[$dcommand]
        if [[ -n $binding ]]; then
            zfm_exec_binding $binding
            pause
            return
        fi
    fi

    case "$dcommand" in
        # these two save and pop ae quite stupid, are we ever gonna use it
        "S"|"save")
            print "Saving $PWD to directory stack"
            push_pwd
            print "Dir Stack: $ZFM_DIR_STACK"
            pause
        ;;
        "P"|"pop")
            pop_pwd
        ;;
        "a"|"ack")
            zfm_ack
        ;;
        "l"|"locate")
            zfm_locate
        ;;
        "f"|"file")
            if [[ -n $selectedfiles ]]; then
                pdebug "selected files: $#selectedfiles"

                M_NO_AUTO=1
                call_fileoptions $selectedfiles
            else
                selection=${selection:-$vpa[$CURSOR]}
                if [[ -n "$selection" ]]; then
                    M_NO_AUTO=1
                    fileopt $selection
                    selection=
                else
                    perror "Please select a file first. Use $ZFM_SELECTION_MODE_KEY key to toggle selection mode"
                fi
            fi
        ;;
        "?"|"h"|"help")
            print "Commands are save (S), pop (P), help (h)"
            print ""
            print "'S' 'save' - save this dir in stack for later returning"
            print "'P' 'pop'  - revert to saved dir"
            print "'f' 'file' - file operations on selected file"
            print "     helpful if you have auto-actions on but want to execute"
            print "     another action on selected file"
            print "'a'  ack (search string) in files"
            print "'p'  'pwd' copy PWD ( $PWD ) to clipboard"
            print "'q' 'quit' - quit application"
            print "You may enter any other command too such as 'git status'"
            print 
            pbold "Subcommands: "
            for kk in ${(k)M_SUBCOMMAND} ; do
                val=$M_SUBCOMMAND[$kk]
                print "$fg_bold[white]$kk$reset_color  - $val "
            done
        ;;
    "pipe")
        # accept a command and pass the result to selectrows
        command_select
        ;;
    "l"|"locate")
        zfm_locate
        ;;
    "p"|"pwd") print -r -- $PWD | pbcopy
        pinfo "Copied $PWD to clipboard"
        ;;
    *)
        # actually it should have had a ! before it. We should not allow this.
        eval "$dcommand"
        ;;
    esac
    M_SELECTION_MODE=
    [[ "$dcommand" = "q" || $dcommand = "quit" ]] && QUITTING=1
    pause
}

#  add current dir to stack so we can pop back
#  We add it backwards so i can shift 
#  Currently aclled only from GOTO_DIR and :S
function push_pwd() {
    local dir
    dir=${1:-$PWD}
    ZFM_DIR_STACK+=( $dir:q )
    #print $ZFM_DIR_STACK 
}
## this is only called from :P not from pop, see popd
#  This does not remove dirs when popping so we always have all visited dirs with us
function pop_pwd() {
    # remove from end
    newd=$ZFM_DIR_STACK[-1]
    ZFM_DIR_STACK[-1]=()
    # put it back on top (first)
    ZFM_DIR_STACK[1]+=( $newd:q )
    # XXX maybe should cd to new top dir, not removed one.
    cd $newd
    pwd
    post_cd
}
#  executed when dir changed
function post_cd() {
    PATT=""
    filterstr=${filterstr:-M}
    param=$(eval "print -rl -- ${pattern}${M_EXCLUDE_PATTERN}(${MFM_LISTORDER}$filterstr)")
    ## added 2013-02-22 - 00:50 LP myopts
    title=$PWD
    myopts=("${(@f)$(print -rl -- $param)}")
    param=
    [[ $#myopts -eq 0 ]] && {
        M_MESSAGE="$#param files, use UP or ZFM_GOTO_PARENT_KEY to go to parent folder, LEFT to popd"
    }
    # clear hash of file details to avoid recomp
    FILES_HASH=()
    execute_hooks "chdir"
    CURSOR=1
    sta=1
    revert_dir_pos
}
function zfm_refresh() {
    title=$PWD
    filterstr=${filterstr:-M}
    param=$(eval "print -rl -- ${pattern}${M_EXCLUDE_PATTERN}(${MFM_LISTORDER}$filterstr)")
    restore_exoanded_state
    myopts=("${(@f)$(print -rl -- $param)}")
    param=
    sms "Rescanned..."
}

## This will ensure that when you return to the directory where
# some dirs were exploded, they will be exploded again
function restore_exoanded_state() {
local td
    for d in $ZFM_EXPANDED_DIRS ; do
        if [[ -d "$d" ]]; then
            td=$d:t
            _files=("${(@f)$(print -rl -- $td/*)}")
            for f in $_files ; do
                param+=( $f )
            done
        else
            # This happens when we move to another dir, so don't worry
            perror "$d not a directory: [$ZFM_EXPANDED_DIRS[1]]"
        fi
    done
}
function print_help_keys() {

    local str
    str=""

    # first print mode related help
    local f
    f=${ZFM_MODE:l}_help
    str=$(eval "$f")
    print
    str+=" \n"
    str+="$fg_bold[white]$ZFM_APP_NAME some keys$reset_color"
    str+=" \n"
    str+=$(cat <<EndHelp

    = General application keys =
       * Note: These may have been overriden by individual modes

    $ZFM_MENU_KEY	- Invoke menu (default: backtick)
    ^	- toggle match from start of filename
    $ZFM_GOTO_DIR_KEY	- Enter directory name to jump to
    $ZFM_SELECTION_MODE_KEY	- Toggle selection mode
    $ZFM_EDIT_REGEX_KEY	- Edit pattern (should be valid grep regex)
    $ZFM_GOTO_PARENT_KEY	- Goto parent of existing dir (cd ..)
    $ZFM_POPD_KEY	- popd (go back to previously visited dirs)
    :	- Command key
        	* S - Save current dir in list
        	* P - Pop dirs from list
    $ZFM_RESET_PATTERN_KEY	- Clear existing search pattern    **
    $ZFM_REFRESH_KEY	- refresh/rescan dir listing     **
    $ZFM_SORT_KEY	- change sort order (pref. use menu) **
    $ZFM_FILTER_KEY	- change filter criteria (pref. use menu) **
    $ZFM_SIBLING_DIR_KEY	- view/select sibling directories **
    $ZFM_CD_OLD_NEW_KEY	- cd OLD NEW functionality (visit second cousins) **
    $ZFM_OPEN_FILES_KEY - open file/s (selected) or under cursor

    Most keys are likely to change after getting feedback, the ** ones definitely will
    
EndHelp
)
    str+=" \n"
    local keys
    keys=(${(k)zfm_keymap})
    keys=(${(o)keys})
for key in ${keys} ; do
    #print $key  : $zfm_keymap[$key]
    str+=$(print "    $key  : $zfm_keymap[$key]")"\n"
done
print -l -- "$str" | $PAGER
#pbold "Key mappings"
}

# utility }
# main {
#   alias this to some single letter after sourcing this file in .zshrc
function myzfm() {
    ##  global section
    ZFM_APP_NAME="zfm"
    ZFM_VERSION="0.1.15-alnitak4"
    M_TITLE="$ZFM_APP_NAME $ZFM_VERSION 2013/02/25"
    #  Array to place selected files
    typeset -U selectedfiles
    # hash of file details to avoid recomp each time while inside a dir
    typeset -Ag FILES_HASH

    # hash to store position in dir when we went somewhere else such as into a child dir
    # We need to position cursor back when we come up.
    typeset -Ag DIR_POSITION
    ## M_SUBCOMMAND keeps a map of command shortname and function
    #  These are commands typed in on : prompt
    typeset -Ag ZFM_MODE_MAP M_SUBCOMMAND

    selectedfiles=()

    #  directory stack for jumping back, opened fies, and expanded dirs
    typeset -U ZFM_DIR_STACK ZFM_FILE_STACK ZFM_EXPANDED_DIRS ZFM_USED_DIRS
    ZFM_DIR_STACK=()
    ZFM_FILE_STACK=()
    ZFM_EXPANDED_DIRS=()
    ZFM_USED_DIRS=()
    DIR_POSITION=()
    M_SUBCOMMAND=()
    ZFM_CD_COMMAND="pushd" # earlier cd lets see if dirs affected
    export ZFM_CD_COMMAND
    ZFM_START_DIR="$PWD"

    ## If user has passed in any keystrokes read them from here
    #  passed in keys will only work in our own read here, not in other
    # reads or vareds. They will be passed as a string, but we weill put into our array
    [[ -n $Z_KEY_STACK ]] && {
        Z_KEY_STACK=("${(s/ /)Z_KEY_STACK}")
    }
    ZFM_FILE_SELECT_FUNCTION=fuzzyselectrow
    export ZFM_FILE_SELECT_FUNCTION
    export last_viewed_files

    #  defaults KEYS
    ZFM_OPEN_FILES_KEY=${ZFM_OPEN_FILES_KEY:-'C-o'}  # pressing selects whatever cursor is on
    ZFM_MENU_KEY=${ZFM_MENU_KEY:-$'\`'}  # pops up menu
    ZFM_GOTO_PARENT_KEY=${ZFM_GOTO_PARENT_KEY:-','}  # goto parent of this dir 
    ZFM_GOTO_DIR_KEY=${ZFM_GOTO_DIR_KEY:-'+'}  # goto dir 
    ZFM_POPD_KEY=${ZFM_POPD_KEY:-"."}  # goto previously visited dir
    ZFM_SELECTION_MODE_KEY=${ZFM_SELECTION_MODE_KEY:-"@"}  # toggle selection mode
    ZFM_SORT_KEY=${ZFM_SORT_KEY:-"%"}  # change sort options
    ZFM_FILTER_KEY=${ZFM_FILTER_KEY:-"#"}  # change filter options
    ZFM_TOGGLE_MENU_KEY=${ZFM_TOGGLE_MENU_KEY:-"="}  # change toggle options
    ZFM_TOGGLE_FILE_KEY=${ZFM_TOGGLE_FILE_KEY:-"C-SPACE"}  # change toggle options
    ZFM_SIBLING_DIR_KEY=${ZFM_SIBLING_DIR_KEY:-"["}  # change to sibling dirs
    ZFM_CD_OLD_NEW_KEY=${ZFM_CD_OLD_NEW_KEY:-"]"}  # change to second cousins
    ZFM_QUIT_KEY=${ZFM_QUIT_KEY:-'Q'}  # quit application
    ZFM_SELECT_ALL_KEY=${ZFM_SELECT_ALL_KEY:-"M-a"}  # select all files on screen
    ZFM_EDIT_REGEX_KEY=${ZFM_EDIT_REGEX_KEY:-"/"}  # edit PATT used to filter
    export ZFM_REFRESH_KEY=${ZFM_REFRESH_KEY:-'"'}  # refresh the listing
    ZFM_MAP_LEADER=${ZFM_MAP_LEADER:-'\'}
    ZFM_HINT_KEY=${ZFM_HINT_KEY:-';'}
    #export ZFM_NO_COLOR   # use to swtich off color in selection
    M_SWITCH_OFF_DUPL_CHECK=
    MFM_LISTORDER=${MFM_LISTORDER:-""}
    M_EXCLUDE_PATTERN=
    pattern='*' # this is separate from patt which is a temp filter based on hotkeys
    filterstr="M"
    M_PRINT_COMMAND_DESC=1
    MFM_NLIDX="123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ"
    ZFM_STRING="${pattern}(${MFM_LISTORDER}$filterstr)"
    integer ZFM_COLS=$(tput cols)
    integer ZFM_LINES=$(tput lines)
    ## we want 59 if we want no long list info, else lines -4 or 5
    PAGESZ=59     # used for incrementing while paging
    #(( PAGESZ = ZFM_LINES - 4 ))
    (( PAGESZ1 = PAGESZ + 1 ))

    integer CURSOR=1
    export ZFM_COLS ZFM_LINES CURSOR
    export ZFM_STRING
    init_key_function_map
    init_menu_options
    init_file_menus
    if [[ -f $ZFM_DIR/bindings.zsh ]]; then
        source ${ZFM_DIR}/bindings.zsh
    else
        perror  "Can't find bindings.zsh"
        exit 1
    fi
    source $ZFM_DIR/cursor.zsh
    for ff in ${ZFM_DIR}/modes/*
    do
        source $ff
    done
    source $ZFM_DIR/bookmark.zsh
    source_addons
    config_read
    zfm_set_mode $ZFM_DEFAULT_MODE
    # at this point read up users bindings
    #print "$ZFM_TOGGLE_MENU_KEY Toggle | $ZFM_MENU_KEY menu | ? help"
    aa=( "?" Help  "$ZFM_MENU_KEY" Menu "$ZFM_TOGGLE_MENU_KEY" Toggle)
    M_HELP_GEN=$( print_hash $aa )
    ab="M_HELP_$ZFM_MODE"
    M_HELP="$M_HELP_GEN | ${(P)ab}"
    #print $M_HELP
    M_MESSAGE="$M_HELP    $M_TITLE"
    # sta was local in list_printer, tring out belove
    # 2013-02-22 - we had a loop here, files were only opened on coming back, I've deleted the loop.
    sta=1
    list_printer 
    print "bye"
    #stty intr ''
    stty $ttysave
} # myzfm

function zfm_open_file() {
    local selection=$1
    [[ -z $selection ]] && selection=$vpa[$CURSOR]

    if [[ -d "$selection" ]]; then
        [[ -n $ZFM_VERBOSE ]] && print "got a directory $selection"
        save_dir_pos
        $ZFM_CD_COMMAND $selection
        post_cd
    elif [[ -f "$selection" ]]; then
        # although nice to immediately open, but what if its not a text file
        # and what if i want to do something else
        #vim $selection
        if [[ -n "$M_SELECTION_MODE" ]]; then
            selection=$PWD/$selection
            zfm_toggle_file $selection
        else
            fileopt $selection
        fi
    else
        [[ -n "$selection" ]] && {
            # sometimes comes here on a link (esp broken) and fileopt will check for -f and reject
            pbold "$0: Don't know how to handle $selection"
            file $selection
            fileopt $selection
            pause
        }
    fi
}
## temporary func name for C-o key open selected files or what's under cursor
#
function zfm_selected_file_options() {
    if [[ -n $selectedfiles ]];then 
        call_fileoptions $selectedfiles
    else
        selection=$vpa[$CURSOR]
    fi
}
## line numbering function, also takes care of widths and coloring since these are interdependent
#  and can clobber one another.
## Earlier this acted as a filter and read lines and printed back output, But now we cache
# file details to avoid screen flicker, so the hash must be in the same shell/process, thus 
# it stored details in OUTPUT string. And reads from viewport.
#
# NOTE: Avoid app specific code in here, i can see PWD already and perhaps get_file_details
#       Keep it general and simple so we can reuse for other apps.
function numberlines() {
    let c=1
    local patt='.'
    if [[ -n "$ZFM_NO_COLOR" ]]; then
        BOLD='*'
        BOLD_OFF=
        COLOR_STANDOUT=
        COLOR_STANDOUTOFF=
    else
        BOLD=$COLOR_BOLD
        COLOR_STANDOUT="\\033[7m"
        COLOR_STANDOUTOFF="\\033[27m"
        BOLD_OFF=$COLOR_DEFAULT
    fi
    OUTPUT=""
    ##local defpatt='.'
    local defpatt=""
    local selct=$#selectedfiles
    [[ $1 = "-p" ]] && { shift; patt="$1"; shift }
    [[ $1 = "-w" ]] && { shift; width="$1"; shift }
    # since string searching in zsh isn;t on regular expressions and ^ is not respected
    # i am taking width of match after removing ^ and using next char as next shortcut
    # # no longer required as i don't use grep, but i wish i still were since it allows better
    # matching
    #patt=${patt:s/^//}
    local w=$#patt
    #let w++
    #while IFS= read -r line; do
    for line in $*; do
        cc=' '
        (( c == CURSOR )) && cc=$CURSOR_MARK
        #if [[ -n "$M_FULL_INDEXING" ]]; then
        if [[ $ZFM_MODE ==  "HINT" ]]; then
            sub=$MFM_NLIDX[$c]
        elif [[ $ZFM_NUMBERING == "ABSOLUTE" ]]; then
            ## This is triggered by vim when we do a "g"
            #sub=$c
            # moved to absolute numbering not just cursor which was page relative
            (( sub = c + sta - 1 ))
        elif [[ $ZFM_NUMBERING == "RELATIVE" ]]; then
            ## This is triggered by vim when we do a j or k
            #sub=$c
            if [[ $c -lt $CURSOR ]]; then
                (( sub = CURSOR - c   ))
            elif [[ $c -gt $CURSOR ]]; then 
                (( sub = c - CURSOR  ))
            else 
                ## instead of zero show actual pos so some calculations can be done
                sub=$c
            fi
        elif [[ $ZFM_MODE == "VIM" ]]; then
            # print absolute number by default, see note below why i do it differently
            (( _c = c + sta - 1 ))
            sub=$_c

            ## for some strange reason if i put the next line here
            #then HINT starts printing a 0 for all indices after 9 and it prints a 12 for 12
            #(( sub = c + sta - 1 ))

        elif [[ $ZFM_MODE == "INS" ]]; then
            sub=$c

            [[ $c -gt 9 ]] && {
                #sub=$line[$w,$w] ;  
                # in the beginning since the patter is . we show first char
                # otherwise this will match the dot
                if [[ $patt = "$defpatt" ]]; then
                    sub=$line[1,1]
                else
                    # after removing the ^ we find match and get the character after the pattern
                    # NOTE: that if the match is at end of filename there is no next character i can show.
                    ix=$line[(i)$patt]
                    (( ix += w ))
                    sub=$line[$ix,$ix] ;  
                fi
            }
        else
            sub=$c
        fi
        ## pad it to prevent the wiggle/dance
        ## CRASHES IN INS MODE if you type t* in work folder saying bad math expression
        if [[ $ZFM_MODE == "VIM" && $sub -le 9 ]]; then
            sub=" $sub"
        fi
        link=
        _detail=
        if [[ -n "$ZFM_LS_L" ]]; then
            if [[ -n "$line" ]]; then
                if [[ -e "$line" ]]; then
                    # check cache for file details
                    get_file_details "$line"
                    # above call updates _detail and the hash, so has to be in current process
                else
                    _detail="(deleted? $PWD)"
                    # file does not exist so it could be deleted ?
                fi
            fi
        fi
        # only if there are selections we check against the array and color
        # otherwise no check, remember that the cut that comes later can cut the 
        # escape chars
        _line=
        boldflag=0
        # 2013-01-09 - 19:33 I am trying out only highlighting the number or else
        # its becoming too confusing, and even now the trunc is taking size of 
        # ANSI codes which are not displayed, so a little less is shown that cold be
        if [[ $selct -gt 0 ]]; then
            # quoted spaces causing failure in matching,
            # however if i don't quote then other programs fail such as ls and tar
            if [[ $selectedfiles[(ie)$PWD/${line}] -gt $selct ]]; then
                #_line="$sub) $_detail $line $link"
            else
                #_line="$sub) $_detail ${BOLD}$line${BOLD_OFF}"
                #sub="${BOLD}$sub${BOLD_OFF}"
                boldflag=1
            fi
        else
            #_line="$sub) $_detail $line $link"
        fi
        _line="$sub)$cc $_detail $line $link"
        (( $#_line > width )) && _line=$_line[1,$width] # cut here itself so ANSI not truncated
        (( boldflag == 1 )) && _line="${BOLD}$_line${BOLD_OFF}"
        #(( c == CURSOR )) && _line="${COLOR_STANDOUT}$_line${COLOR_STANDOUTOFF}"
        (( c == CURSOR )) && _line="${bg_bold[$CURSOR_COLOR]}$_line${reset_color}"
        ### 2013-01-21 - 21:09 trying to do this in same process so hash be updated
        #print -l -- $_line
        OUTPUT+="$_line\n"
        let c++
    done
    #print -l -- $OUTPUT
} # numberlines

## 
# updates file details in _detail and also updates hash/cache
# this cannot be called in new process, must be called and then _detail used
function get_file_details() {
    local line=$1
    # TAB required because some methods will parse this when selection ??
    # changed tab to spaces on 2013-02-12 - 14:29 BE CAREFUL if things stop working, revert to tab
    local tt="  "
    local sz link
    _detail=$FILES_HASH[$line]
    if [[ -z $_detail ]]; then
        mtime=$(zstat -L -F "%Y-%m-%d %H:%M" +mtime $line)
        zstat -L -H hash $line
        sz=$hash[size]
        if [[ $sz -gt 1048576 ]]; then
            (( sz = sz / 1048576 )) ; sz="${sz}M" 
            # statements
        elif [[ $sz -gt 9999 ]]; then
            (( sz = sz / 1024 )) ; sz="${sz}k" 
        fi
        sz=$( print ${(l:6:)sz} )
        #[[ $sz -gt 9999 ]] && {  (( sz = sz / 1024 )) ; sz="${sz}k" }
        link=$hash[link]
        [[ -n $link ]] && link=" -> $link"
        #_detail="${TAB}$sz${TAB}$mtime${TAB}"
        _detail="${tt}$sz${tt}$mtime${tt}"
        # cache details of file
        FILES_HASH[$line]=$_detail
    else
        #_detail="$_detail +"
    fi

}

function selection_menu() {
    local mode="remove_mode"
    local mmode="Selection"
    [[ $#selectedfiles -eq 0 ]] && ZFM_REMOVE_MODE=
    if [[ -n $ZFM_REMOVE_MODE ]]; then
        mode="add_mode"
        mmode="Unselection "
    fi
    menu_loop "$mmode Options ($#selectedfiles)" "today extn ack invert $mode" "txaim"
    files=
    case $menu_text in
        "today")
            # finding common rows between what's visible and today's files
            files=("${(@f)$(print -rl -- *(.m0))}")
            pdebug "files $#files : $files"
            ;;
        "extn")
            # finding common rows between what's visible and today's files
            print -n "Enter extensions to select (space delim *.c *.h): "
            read extns
            files=("${(@f)$(eval print -rl -- $extns)}")
            ;;
        "ack")
            # files containing some text
            print -n "Enter pattern to search : "
            read cpattern
            files=("${(@f)$(eval ack -l $M_ACK_REC_FLAG $cpattern)}")
            pdebug "file $#files : $files"
            ;;
        "remove_mode")
            if [[ $#selectedfiles -eq 0 ]]; then
                perror "There are no files to unselect"
            else
                ZFM_REMOVE_MODE=1
                pinfo "Files selected will be removed from selection"
            fi
            ;;
            #(( ZFM_REMOVE_FLAG =  ZFM_REMOVE_MODE * -1 ))
        "add_mode")
            ZFM_REMOVE_MODE=
            pinfo "Files selected will be added to selection (normal mode)"
            ;;
            #(( ZFM_REMOVE_FLAG =  ZFM_REMOVE_MODE * -1 ))
        "invert")
            ## This is resulting in directories getting selected, avoid that
            local vp
            vp=($PWD/${^viewport}) # prepend PWD to each element 2013-01-10 - 00:17
            selectedfiles=( ${vp:|selectedfiles} )
            ;;


    esac
    if [[ -n $files ]]; then
        files=($PWD/${^files}) # prepend PWD to each element
        # don't quote files again in common loop or spaced files will not get added
        if [[ -n $ZFM_REMOVE_MODE ]]; then
            #files=( $files:q )
            selectedfiles=(${selectedfiles:|files})
        else

            # i think viewport has only file names, no details
            # so we can just do a one line operation
            vp=($PWD/${^viewport})
            common=( ${vp:*files} )
            for line in $common
            do
                pdebug "line $line"
                selected_row=("${(s/	/)line}")
                selected_file=$selected_row[-1]
                selectedfiles+=( $selected_file )
            done
        fi
    fi
    pdebug "selected files $#selectedfiles"
}
# }

# this is the main menu used in the list when pressing MENU_KEY
# The purpose of initializing this is to make it configurable or modifiable through
# a config file
function init_menu_options() {
    typeset -gA main_menu_command_hash
    main_menu_options+=("Directory" "zk dirjump" "d children" "[ Siblings" "] cd OLD NEW" "M mkdir" "% New File" "." "." "\n")
    main_menu_options+=("Commands" "a ack" "/ ffind" "v filejump" "l locate" "u User Commands" "_ Last viewed file" "2 Selected files" "1 File under cursor" "\n")
    main_menu_options+=("Settings"  "x Exclude Pattern" "F Filter options" "s Sort Options" "o General"  "\n")
    main_menu_options+=("Listings" "f File Listings" "r Recursive Listings" "\n")
    main_menu_command_hash=(
        o settingsmenu
        f nonrecviewoptions
        r recviewoptions
        d m_child_dirs
        z m_dirstack
        k m_dirstack
        v m_recentfiles
        F filteroptions
        x zfm_exclude_pattern
        s sortoptions
        u mycommands
        a zfm_ack
        l zfm_locate
        M zfm_newdir
        % zfm_newfile
        / zfm_ffind
        [ sibling_dir
        ] cd_old_new
        _ edit_last_file
        1 select_current_line
        2 zfm_selected_file_options
        )
}
function init_key_function_map() {
    typeset -gA zfm_hook
    #add_hook "chdir" chdir_message
    add_hook "chdir" restore_exoanded_state
    add_hook "fileopen" fileopen_hook

    typeset -gA zfm_keymap
    # testing out key mappings with different kinds of keys
    zfm_keymap=("$ZFM_GOTO_PARENT_KEY"
                    zfm_goto_parent_dir
                "$ZFM_GOTO_DIR_KEY"
                    zfm_goto_dir
                $ZFM_SORT_KEY
                    sortoptions
                $ZFM_FILTER_KEY
                    filteroptions
                "TAB"
                    zfm_views
                "$ZFM_POPD_KEY"
                    zfm_popd
                ":"
                    subcommand
                "$ZFM_MENU_KEY"
                    zfm_show_menu
                "^"
                    toggle_match_from_start
                $ZFM_TOGGLE_MENU_KEY
                    toggle_options_menu
                "$ZFM_SIBLING_DIR_KEY"
                    sibling_dir
                $ZFM_CD_OLD_NEW_KEY
                    cd_old_new
                "?"
                    print_help_keys
                $ZFM_SELECT_ALL_KEY
                    zfm_select_all_rows
                $ZFM_SELECTION_MODE_KEY
                    zfm_selection_mode_toggle
                $ZFM_TOGGLE_FILE_KEY
                    zfm_toggle_file
                "$ZFM_HINT_KEY"
                    full_indexing_toggle
                "C-x"
                    cx_map
                $ZFM_MAP_LEADER
                    cx_map
                "C-x d"
                    zfm_toggle_expanded_state
                "i"
                    "zfm_set_mode INS"
                "I"
                    "zfm_set_mode INS"
                    )
}
function init_file_menus() {
    # edit these or override in ENV
    ZFM_ZIP_COMMAND=${ZFM_ZIP_COMMAND:-'tar zcvf ${archive} %%'}
    ZFM_RM_COMMAND=${ZFM_RM_COMMAND:-rmtrash}
    ZFM_UNZIP_COMMAND=${ZFM_UNZIP_COMMAND:-dtrx}
    #
    ## Apps used for text files, will be used in menus on file selection
    #FT_TEXT=(vim cmd less 'mv % ${target}' ${ZFM_RM_COMMAND} archive tail head open auto)
    #FT_DEFAULT_PDF=("vim =(pdf2html %)" htmlize h)
    #
    ## Applications used for text files -- currently only executable names in path
    ##  will be difficult to remove from both arrays, better to use a hash
    ##  However, a hash won't gaurantee positions in menu each time!
    typeset -Ag FT_EXTNS FT_ALIAS FT_OPTIONS
    typeset -Ag FT_ALIAS
    typeset -Ag FT_ALL_APPS FT_ALL_HK
    ## THis way could get long and tedious for some types like zip and others
    FT_ALIAS[md]="MARKDOWN"
    FT_ALIAS[htm]="HTML"
    FT_ALIAS[zsh]="TXT"   # lets me jump there rather than go through extns  NOOO
    FT_ALIAS[rb]="TXT"   # lets me jump there rather than go through extns
    FT_EXTNS[TXT]=" txt rb pl py java js c cpp cc css mk h Makefile Rakefile gemspec zsh sh rc conf md markdown TXT html htm"
    FT_EXTNS[ZIP]=" zip jar tgz bz2 arj gz Z "
    FT_EXTNS[BIN]=" o a class pyc lib "
    FT_EXTNS[SWAP]=" ~ swp "    # ends with ~ not an extension
    FT_EXTNS[IMAGE]=" png jpg jpeg gif "    # ends with ~ not an extension
    FT_EXTNS[VIDEO]=" flv mp4 "    # ends with ~ not an extension
    FT_EXTNS[AUDIO]=" mp3 m4a aiff aac ogg "    # ends with ~ not an extension
    FT_COMMON="open cmd mv gitmv trash auto clip chdir"
    
    ## options displayed when you select multiple files
    ##  Sadly, this is not taking into account filetypes selected, thatcould be helpful
    FT_OPTIONS[MULTI]="zip grep gitadd gitcom vim vimdiff ${FT_COMMON}"

    # These were variables like FT_TXT which allowded me to use an array inside if
    # i wanted but complicated programs since i need to derive the name. Since I am
    # using a string, might as well just use a hash, we can loop it then. 2013-01-18 - 19:27 
    PAGER=${PAGER:-less}
    FT_OPTIONS[TXT]="vim $PAGER archive tail head ${FT_COMMON}"
    FT_OPTIONS[OTHER]="$FT_COMMON od stat vim"
    FT_OPTIONS[IMAGE]="${FT_COMMON}"
    FT_OPTIONS[ZIP]="view tvf zless unzip zipgrep $FT_COMMON"
    FT_OPTIONS[SWAP]="vim cmd"
    ## in addiition to other commands for pdf's
    FT_OPTIONS[PDF]="pdftohtml pdfgrep w3mpdf"
    FT_OPTIONS[VIDEO]="open vlc mplayer ffmp ${FT_COMMON}"
    FT_OPTIONS[AUDIO]="open mpg321 afplay ${FT_COMMON}"
    FT_OPTIONS[HTML]="html2text w3m elvis sgrep"
    # now we need to define what constitutes markdown files such as MD besides MARKDOWN extension
    FT_OPTIONS[MARKDOWN]="Markdown.pl w3mmd multimarkdown"
    FT_OPTIONS[BIN]="od bgrep strings"
    FT_OPTIONS[SQLITE]="tables schema sql $FT_COMMON"
    #
    ## options for when a directory is selected
    # This doesn't allow us to do stuff inside a dir like mkdir or newfile since 
    #  we are not inside a dir
    # added 2013-01-23 - 20:46 
    FT_OPTIONS[DIR]="chdir archive trash du dush ncdu clip pwd cmd"

    ## -- how to specify a space, no mnemonic?
    #FT_TEXT=(v vim : cmd l less # mv D ${ZFM_RM_COMMAND} z archive t tail h head o open a auto)
    typeset -Ag COMMAND_HOTKEYS
    COMMAND_HOTKEYS=(vim v cmd : mv \# trash D archive z zless l clip Y)

    typeset -Ag COMMANDS
    # remember that in such cases we have to check for file existing, overwriting etc
    # so it is not advisable unless you call a file, in viewing cases it is fine
    #COMMANDS[mv]='mv %% ${target}'
    COMMANDS[trash]="$ZFM_RM_COMMAND"
    COMMANDS[archive]="$ZFM_ZIP_COMMAND"
    COMMANDS[unzip]="$ZFM_UNZIP_COMMAND"
    #COMMANDS[chdir]="$ZFM_CD_COMMAND %% && post_cd"
    COMMANDS[dush]="du -sh"
    #COMMANDS[head]="head -25"
    #COMMANDS[tail]='tail -${lines} %%'
    COMMANDS[pdftohtml]='vim =(pdftohtml -stdout %%)'
    COMMANDS[w3mpdf]='w3m -T text/html =(pdftohtml -stdout %%)'
    COMMANDS[Markdown.pl]="Markdown.pl %% | $PAGER"
    COMMANDS[w3mmd]='w3m -T text/html =(Markdown.pl %%)'
    COMMANDS[gitadd]='git add'
    COMMANDS[gitcom]='git commit'
    ## convert selected flv file to m4a using ffmpeg
    COMMANDS[ffmp]='ffmpeg -i %% -vn ${${:-%%}:r}.m4a'
    COMMANDS[clip]='print -r -- %% | pbcopy && print "Copied filename to clipboard"'
    COMMANDS[pwd]='print -r -- $PWD/%% | pbcopy && print "Copied PWD to clipboard"'
    COMMANDS[tvf]='tar ztvf'
    COMMANDS[gitmv]='git mv'
    COMMANDS[tables]='sqlite3 %% .tables'
    COMMANDS[schema]="sqlite3 %% .schema | $PAGER"
    #COMMANDS[sql]='sqlite3 %% \'select * from ${table}\' '
    COMMANDS[sql]='sqlite3 %%'
    # after calling sqlite3, C-c aborts and C-q and C-\ stop working
    # pdftohtml -stdout %% | links -stdin
    #FT_DEFAULT_PDF="pdftohtml"
    #export FT_TXT FT_ZIP FT_OTHERS COMMANDS COMMAND_HOTKEYS
}
function get_command_for_title() {
    print $COMMANDS[$1]
}
function zfm_bind_key() {
    # should we check for existing and refuse ?
    zfm_keymap[$1]=$2
    if (( ${+zfm_keymap[$1]} )); then
    else
        perror "Unable to bind $1 to keymap "
        pause
    fi
}
function zfm_unbind_key() {
    zfm_keymap["$1"]=()
}
function zfm_get_key_binding() {
    binding=$zfm_keymap[$1]
    ret=1
    [[ -n $binding ]] && ret=0
    [[ -z $binding ]] && pdebug "Nothing bound for $1"
    return $ret
}
# fetch and execute binding for a key
function zfm_exec_key_binding() {
    binding=$zfm_keymap[$1]
    ret=1
    if [[ -n $binding ]]; then
        ret=0
        M_MESSAGE=
        #
        zfm_exec_binding $binding
        ret=$?
    else
        perror "Nothing bound for $1"
    fi
    return $ret
}
## executes given binding, so this can be from anywhere, some other keymap too
function zfm_exec_binding() {
        ## if the bding is a single word then execute it as is
        # if there's a space then the first word is the function rest is argument
        #  so split it and execute it -- eval will not work since it will be in another process
        #  I could have used a split, but don't want any space issues happening at some point.
        #   columns=("${(s/ /)binding}")
    local binding=$1
    [[ -z $binding ]] && return 1
    local ix ret=1
    local sp=" "
    ix=$binding[(i)$sp]
    if [[ $ix -le $#binding ]]; then
        let ix--
        b=$binding[1,$ix]
        # jump space
        (( ix += 2 ))
        args=$binding[$ix,-1]
        M_MESSAGE="$0 exec $b with $args, m=$MULTIPLIER, s=$M_SELECTOR"
        $b $args
        ret=$?
    else
        $binding
        ret=$?
    fi
    return $ret
}
function zfm_bind_subcommand() {
    # should we check for existing and refuse ?
    M_SUBCOMMAND[$1]=$2
    if (( ${+M_SUBCOMMAND[$1]} )); then
    else
        perror "Unable to bind $1 to M_SUBCOMMAND "
        pause
    fi
}
function zfm_set_mode() {
    [[ -n $ZFM_MODE && $ZFM_MODE != $ZFM_PREV_MODE ]] && ZFM_PREV_MODE=$ZFM_MODE

    export ZFM_MODE=$1
    [[ -z "$ZFM_MODE" ]] && { print "Error: ZFM_MODE blank." 1>&2; exit 1; }
    MODE_KEY_HANDLER=
    ZFM_NUMBERING=
    mode="[$ZFM_MODE]"
    #[[ $ZFM_MODE == "VIM" ]] && { vimmode_init }
    initf="${ZFM_MODE:l}mode_init"
    $initf
    local ab
    ab="M_HELP_$ZFM_MODE"
    M_HELP="$M_HELP_GEN | ${(P)ab}"
    clear_mess
}
function zfm_unset_mode() {
    ## UNUSED NOW
    pinfo "Quitting mode $ZFM_MODE"
    unset ZFM_MODE
    ZFM_MODE_MAP=()
    MODE_KEY_HANDLER=
    mode="[NIL]"
}

## A separate mapping namespace
# If we use a separate hash we can print out mappings for C-x or prompt easily
# Generalized this for C-x and mapleader
#
function cx_map() {
    local kp=$ans
    local anskey mapkey
    anskey=$ans
    mapkey=$ans
    [[ $ans == '\' ]] && { anskey='\\' ; mapkey="ML"; }
    print -n "$anskey awaiting a key: "
    _read_keys
    #[[ -n $ckey ]] && reply=$ckey
    local key
    key="$mapkey $reply"
    binding=$zfm_keymap[$key]
    M_MESSAGE="$0: $anskey $reply => $binding"
    ret=1
    [[ -n $binding ]] && { zfm_exec_binding $binding ; ret=0 }
    [[ -z $binding ]] && { 
        perror "could not find [$key] in keymap" ;
        #for f ( ${(k)zfm_keymap}) print -l "[$f] ==> $zfm_keymap[$f]"
        #print -l "${(k)zfm_keymap}"
    }
    return $ret
}
#
## add a function to call on an event
#  Events are chdir 
#  Should be check event passed in or let it be open?
#  $1 - event
#  $2 - function to call when even happens
function add_hook() {
    zfm_hook[$1]+=" $2 "
}
function execute_hooks() {
    local event=$1
    shift
    local params
    params="$@"
    local hooks
    hooks=$zfm_hook[$event]
    hooks=("${(s/ /)hooks}")
    for ev in $hooks; do
        #pinfo "  :: executing $ev"
        # This is not correct : -x is only for files not for function names
        # we need to call zfm_exec_binding or just try the first case TODO
        if [[ -x "$ev" ]]; then
            $ev $params
        else
            eval "$ev $params"
        fi
    done
}
function chdir_message() {
    #[[ $#param -gt 0 ]] && M_MESSAGE="$M_HELP   <LEFT>: popd   <UP>: Parent dir"
}
function fileopen_hook () {
    [[ -z $1 ]] && { perror "fileopen_hook got no files. Check caller"; pause; }
    [[ -d $1 ]] && perror "$0 called with directory"
    local files
    files=($@)
    if [[ ${files[1][1]} == '/' ]]; then
    else
        files=($PWD/${^files}) # prepend PWD to each element
    fi
    ZFM_FILE_STACK+=($files)
    ZFM_USED_DIRS+=($PWD)
}
function toggle_options_menu() {
    ## by default or first time pressing toggle key twice will toggle full-indexing
    # After that it toggles whatever the last toggle was. If that is too confusing
    # maybe i can set it to one option whatever is the most used.

    toggle_menu_last_choice=FullIndexing
    #ML_COLS=2 menu_loop "Toggle Options" "FullIndexing HiddenFiles FuzzyMatch IgnoreCase ApproxMatchToggle AutoView" "ihfcxa${ZFM_TOGGLE_MENU_KEY}"
    ML_COLS=2 menu_loop "Toggle Options" "FullIndexing HiddenFiles FuzzyMatch IgnoreCase MatchFromStart AutoView LongList" "ihfcsal${ZFM_TOGGLE_MENU_KEY}"
    [[ $menu_text == $ZFM_TOGGLE_MENU_KEY ]] && { menu_text=$toggle_menu_last_choice }
    case "$menu_text" in
        "FullIndexing")
            full_indexing_toggle
            ;;
        "HiddenFiles")
            show_hidden_toggle
            ;;
        "FuzzyMatch")
            fuzzy_match_toggle
            ;;
        "IgnoreCase")
            ignore_case_toggle
            ;;
        "ApproxMatchToggle")
            approx_match_toggle
            ;;
        "MatchFromStart")
            toggle_match_from_start
            ;;
        "AutoView")
            pinfo "Autoview determines whether file selection automatically opens files for viewing or allow user to decide action"
            toggle_auto_view
            if [[ "$ZFM_AUTOVIEW_TOGGLE_KEY" == "1" ]]; then
                pinfo "Files will be viewed upon selection"
            else
                pinfo "Files will NOT be viewed upon selection. Other actions may be performed"
            fi
            ;;
        "LongList")
            local sz=59
            if [[ $PAGESZ -eq $sz ]]; then
                (( PAGESZ = ZFM_LINES - 4 ))
            else
                (( PAGESZ = sz ))
            fi
            (( PAGESZ1 = PAGESZ + 1 ))
            ;;
        *)
            [[ -n $menu_text ]] && {
                perror "Wrong option [$menu_text]"
            }
    esac
    toggle_menu_last_choice=$menu_text
}
## called by POPD_KEY to pop back to previous dirs
#
function zfm_popd() {
    dirs
    popd && post_cd
    selection=
}
function zfm_show_menu() {
    if [[ -n "$M_SELECTION_MODE" ]]; then
        selection_menu
    else
        local olddir=$PWD
        view_menu
        [[ $olddir == $PWD ]] || {
            # dir has changed
            post_cd
        }
    fi
}
function zfm_goto_parent_dir() {
    clear_mess
    save_dir_pos
    #cd ..
    $ZFM_CD_COMMAND ..
    post_cd
}
function zfm_goto_dir() {
    # push directory before changing
    local tmp
    push_pwd
    #GOTO_PATH="/"
    GOTO_PATH=${GOTO_PATH:-"$HOME/"}
    # FIXME backspace etc issues in vared here, hist not working
    vared -h -p "Enter path: " GOTO_PATH
    selection=${(Q)GOTO_PATH}  # in case space got quoted, -d etc will all give errors
    if [[ ! -d $selection ]]; then
        tmp=${(P)selection}  # check if variable by that name
        if [[ ! -d $tmp ]]; then
            # check if in home dir
            tmp=~/$selection
            if [[ -d $tmp ]]; then
                selection=$tmp
            fi
        else
            selection=$tmp
        fi
    fi
    [[ -d $selection ]] && print -s -- "$selection"

    PATT="" # 2012-12-26 - 00:54 
    push_pwd $selection
}
## a wrapper over dir change command -- we should move to using this
# to localize changes.
# This takes a position to open on.
# Use cases: 
#   - open a dir
#   - open a dir at n position
#   - open a dir on some file TODO if reqd
#   - open a dir on first occu of pattern TODO if reqd
function zfm_open_dir() {
    local dir=$1
    local pos=$2
    # push directory before changing
    push_pwd $dir
    $ZFM_CD_COMMAND $dir
    post_cd
    if [[ -n $pos ]]; then
        calc_sta_offset $pos
    fi
}
##
# directories user has visited in this session
# These are not all the dirs, only those specifically selected through some options
# We could save them on exit and read them up
#
function visited_dirs() {
    print
    menu_loop "Select a dir: " "$ZFM_DIR_STACK"
    [[ -n "$menu_text" ]] && { 
        $ZFM_CD_COMMAND $menu_text
        post_cd
    }
}
function visited_files() {
    print
    menu_loop "Select a file: " "$ZFM_FILE_STACK"
    [[ -n "$menu_text" ]] && { 
        fileopt $menu_text
    }
}
## 
## find files in current directory
#
function zfm_ffind() {
    # find files with string in filename, uses zsh (ffind)
    searchpattern=${searchpattern:-""}
    vared -p "Filename to search for (enter > 2 characters): " searchpattern
    [[ -z $searchpattern ]] && return 1
    # recurse and match filename only
    #files=$( print -rl -- **/*(.) | grep -P $searchpattern'[^/]*$' )
    # find is more optimized acco to zsh users guide
    # this won't work if user puts * in pattern.
    #files=$( print -rl -- **/*$searchpattern*(.) )
    files=("${(@f)$(print -rl -- **/*$searchpattern*(.) )}")
    #I get a blank returned so it passed and does not use find
    #Earlier it worked but failed on spaces in fiel name
    if [[ $#files -eq 0 || $files == "" ]]; then
        perror "Trying with find -iname, press a key"
        pause
        files=("${(@f)$(noglob find . -iname *$searchpattern*  )}")
        #files=$( find . -iname $searchpattern )
    else
    fi
    if [[ $#files -gt 0 ]]; then
        ## sort so latest come on top
        #files=$( print -N -- $files | xargs -0 ls -t )
        files=$( print -N $files | xargs -0 ls -t )
        handle_files $files
        #ZFM_FUZZY_MATCH_DIR="1" fuzzyselectrow $files
        selected_files=
        selected_file=
    else
        perror "No files matching $searchpattern"
    fi
}
function cd_old_new() {
    #$ZFM_CD_OLD_NEW_KEY)
    pbold "This implements the: cd OLD NEW metaphor"
    print "Part to change :"
    parts=(${(s:/:)PWD})
    menu_loop "Parts" "$(print $parts )"
    [[ -z "$menu_text" ]] && return 1
    pbold "Replace $menu_text"
    parts[$menu_index]='*'
    local newpath pp
    newpath=""
    ## join path with * in appropriate place
    for pp in $parts
    do
        newpath="${newpath}/${pp}"
    done
    newpath+="(/)"
    menu_loop "Select target ($newpath): " "$(eval print  $newpath)"
    [[ -n "$menu_text" ]] && { 
        $ZFM_CD_COMMAND $menu_text
        post_cd
    }
}
function sibling_dir() {
    # This should only have search and drill down functionality
    # so it can be reused by other parts such as viewoptions
    # to drill down, should be minimal and keep local stuff
    #
    # siblings (find a better place to put this, and what if there
    # are too many options)
    print "Siblings of this dir:"
    menu_loop "Siblings" "$(print ${PWD:h}/*(/) )"
    [[ -z "$menu_text" ]] && return 1
    [[ -d "$menu_text" ]] || {
        perror "$menu_text not a directory"
        return 1
    }
    print "selected $menu_text"
    $ZFM_CD_COMMAND $menu_text
    post_cd
}

## load any addons that might be present in addons folder
#
function source_addons() {
    local _d
    _d=${ZFM_DOTDIR:-$HOME/.zfm}
    _d=$_d/addons
    if [[ -d "$_d" ]]; then
        for exe ( $_d/*(xN) ) { 
            pdebug "sourcing $exe"
            source $exe
        }
    fi

}
## 
## Apply a filter to the list displayed.
#
function zfm_filter_list() {
    print
    print  "Add a command to filter file list, e.g. head / grep foo/ "
    vared -c -p "Enter filter: " M_CFILTER
}

## selects all visible rows
## Should only select files not dirs, since you can't deselect a dir
#
function zfm_select_all_rows() {
    for line in $viewport
    do
        pdebug "line $line"
        selected_row=("${(s/	/)line}")
        selected_file=$selected_row[-1]
        ## reject directories 
        if [[ -n "$M_SELECT_ALL_NO_DIRS" ]]; then
            ## don;t select dirs
            [[ -d $selected_file ]] || selectedfiles+=( $PWD/$selected_file )
        else
            # select files and dirs, everything
            selectedfiles+=( $PWD/$selected_file )
        fi
    done
    pinfo "selected files $#selectedfiles. "
    if [[ -n "$M_SELECTION_MODE" ]]; then
        pbold "Press $ZFM_SELECTION_MODE_KEY when done selecting"
    else
        # this is outside of selection mode

        M_NO_AUTO=1
        call_fileoptions $selectedfiles
        # This deals with a separate array -- doesn't have underscore
        #[[ $#selectedfiles -gt 1 ]] && multifileopt $selectedfiles
        #M_NO_AUTO=1
        #[[ $#selectedfiles -eq 1 ]] && fileopt $selectedfiles
        selectedfiles=()
        M_MESSAGE=
    fi
}
## Go into selection mode, so files selected will be added to list
#
function zfm_selection_mode_toggle() {
    #  This switches on selection so files will be added to a list
    if [[ -n "$M_SELECTION_MODE" ]]; then
        M_SELECTION_MODE=
        mode="[$ZFM_MODE]"
        pinfo "Selected $#selectedfiles files"
        M_NO_AUTO=1
        call_fileoptions $selectedfiles
        #[[ $#selectedfiles -gt 1 ]] && multifileopt $selectedfiles
        #[[ $#selectedfiles -eq 1 ]] && fileopt $selectedfiles
        selectedfiles=()
        pbold "selection mode is off"
    else
        M_SELECTION_MODE=1
        pinfo "selection mode is on. After selecting files, use same key to toggle off and operate on files"
        pinfo "$ZFM_SELECT_ALL_KEY to select all, $ZFM_MENU_KEY for selection menu, $ZFM_TOGGLE_FILE_KEY to toggle file"
        aa=( Mode: "[Select]" $ZFM_SELECT_ALL_KEY "Select All" $ZFM_MENU_KEY "Selection Menu" $ZFM_TOGGLE_FILE_KEY "Toggle File"  $ZFM_SELECTION_MODE_KEY "Exit Mode")

        M_MESSAGE=$( print_hash $aa )
    fi
}
function zfm_toggle_file() {
    #selection=$PWD/$selection
    local selection="$1"
    ## if the user interactively selected then advance cursor like memacs does
    # cursor++ fine in single page but screwed on multipage when turning over page
    #[[ -z $selection ]] && { selection=$PWD/$vpa[$CURSOR]; (( CURSOR++ )) ; }
    [[ -z $selection ]] && { selection=$PWD/$vpa[$CURSOR]; vim_cursor_down; }

    if [[ -n  ${selectedfiles[(re)$selection]} ]]; then
        pinfo "File $selection already selected, removing ..."
        i=$selectedfiles[(ie)$selection]
        selectedfiles[i]=()
        pinfo "File $selection unselected"
    else
        zfm_add_to_selection $selection
        pinfo "Adding $selection to array, $#selectedfiles "
    fi
}
# add given file to selection, $PWD should be prepended to it or it won't highlight
#
zfm_add_to_selection() {
    local selection
    selection=($@)
    selectedfiles+=( $selection )
}
zfm_remove_from_selection() {
    local selection
    selection=($@)
    selectedfiles=(${selectedfiles:|selection})
}
## This expands dir under cursor, actually toggles expanded state
#  This places dir name in an array, however, it keeps only final part of dir not complete
#  path, so if "lib" is expanded in one dir, it will be expanded in others, and toggle off. XXX
function zfm_toggle_expanded_state() {
    local d _files fd
    d=$myopts[$CURSOR]
    fd=$PWD/$d
    # if exists, remove it
    if [[ $ZFM_EXPANDED_DIRS[(i)$fd] -le $#ZFM_EXPANDED_DIRS ]]; then
        ZFM_EXPANDED_DIRS[(i)$fd]=()
        zfm_refresh
        return
    fi
    ZFM_EXPANDED_DIRS+=($fd)
    if [[ -d "$fd" ]]; then
        _files=("${(@f)$(print -rl -- $d/*)}")
        for f in $_files ; do
            param+=( $f )
        done
    fi
}
## open file related to hint HINT
#
function zfm_get_full_indexing_filename() {
    local ans=$1
    iix=$MFM_NLIDX[(i)$ans]
    [[ -n "$iix" ]] && { 
        (( CURSOR = iix ))
        # from vim or other modes we may want to use this only to position the cursor
        # like on f or some key, not open a file
        if [[ -z $M_HINT_POSITION_CURSOR_ONLY ]]; then
            selection=$vpa[$iix]
            ## 2013-02-22 - 00:28 LP added
            zfm_open_file $selection
            selection=
        else
        fi
    }
}

function zfm_edit_regex() {
    #$ZFM_EDIT_REGEX_KEY
    ## character like number cause automatic selection, but if your file name
    ## contains or starts with numbers then this key allows you to enter a key
    ## which will get added to search pattern 2013-01-28
    #
    vared -p "Edit pattern (valid regex): " PATT
}
function mess() {
    M_MESSAGE=$1
}
function clear_mess() {
    M_MESSAGE=$M_HELP
}
function sms() {
    M_MESSAGE="$M_HELP [$1]"
}
function zfm_goto_end() {
    # XXX this should just do a zfm_goto_line $END
    zfm_goto_line $END
}
function zfm_goto_start() {
    sta=1
    CURSOR=1
}
## takes an absolute line number not relative CURSOR value
#  Value has to be between 1 and $tot
#  Typically value is sta + CURSOR - 1
#
#  TODO we could save cursor here, if is ensured that callers do not update CURSOR
#  but pass a position in.
#
function zfm_goto_line() {
    # when splitting output into multple pages, we are not showing absolute numbers
    # when going to a line, we need to page accordingly.
    ##
      
    local ln=$1
    [[ -z $ln ]] && {

        print
        print -n "Enter line: "
        read ln
    }
    ## first some sanity checks
    # Thre are cases where we can programmatically call this after changing a dir
    # In such cases, tot has the value of prev dir. Thus check fails and sets tot to lower 
    # value. e.g. jump_to_mark
    (( ln > tot )) && { perror "$0: correcting $ln to $tot"; ln=$tot }
    (( ln < 1 && sta == 1 )) && ln=1

    # we save cursor here, so please don't chang cursor in caller, just pass the new position
    save_cursor
    calc_sta_offset $ln

    execute_hooks "on_enter_row" $vpa[$CURSOR]
    return

}
## calculate start and offset given a absolute position of file in dir
# I separated this from zfm_goto_line since that does sanity checks and here
# we have not yet got tot calculated.
# NOTE: no validation is to be done on line number passed in since the 
# directory totals have not been calculated yet. It is assumed they are correct
# and these values will come into play once the dir is displayed.
function calc_sta_offset() {
    local pages ln
    ln=$1
    (( pages = ln / PAGESZ1 ))
    # ceiling_divide is in cursor.zsh, this is reqd for edge cases such as last item on page
    pages=$(ceiling_divide $ln $PAGESZ1)
    (( pages = pages - 1 ))
    (( sta = pages * PAGESZ1 + 1 ))
    ## This sets cursor to be relative to page.
    # Once we call this from all motion places then we can make it absolute and do away 
    # with using vpa from everwhere except for numberlines
    (( CURSOR = ln - sta + 1 ))
    #mess "$0 got $ln: setting CURS to $CURSOR and sta to $sta "
}
function zfm_escape () {
    # vim has its binding for escape but the other two should go to vim if ESC pressed
    if [[ $ZFM_MODE == "VIM" ]]; then
        return
    fi
    zfm_set_mode VIM
}
function zfm_bs () {

    # BACKSPACE backspace if we are filtering
    if [[ $PATT = "" ]]; then
        M_NO_REPRINT=1
    else
        # backspace if we are filtering, remove last char from pattern
        PATT[-1]=
        PATT=${PATT%.*}
    fi
}
## saves both start and curpos
#  We need to move to using correct cursor position and not this page relative position
function save_cursor() {
    PREV_CURSOR=$CURSOR
    PREV_STA=$sta
}
## calculates absolute position for given relative CURSOR position
## pass variable name and it will update absolute curpos in var name
function curpos() {
    # convert current cursor to abso
    local result_name=$1
    (( ${result_name} = sta + CURSOR - 1 ))
}
##
# Saves directories last known position before user left to go into a child (at least)
# or hopefull anywhere, so we can revert to that position
# NOTE: this saves position not file name so if you drill down to a file then come back up
#   then the saved cursor position will not be the correct one.
#
function save_dir_pos() {
    DIR_POSITION[$PWD]="${sta}:${CURSOR}"
    #pinfo "$0: saving $sta nd $CURSOR"
}
##
# revert us to last position in directory
#
function revert_dir_pos() {
    local pos elems
    pos=$DIR_POSITION[$PWD]
    [[ -z "$pos" ]] && { return }
    elems=("${(s/:/)pos}")
    sta=$elems[1]
    CURSOR=$elems[2]
    #pinfo "$0: reverting ($pos) $sta nd $CURSOR"
}
function stty_settings() {
    ## We need C-c for mappings, so we disable it 
    stty intr '^-'
    # this is strangely eating up C-o
    stty flush '^-'
    # so we can trap C-\ to abort
    stty quit '^-'
    # so we can trap C-q to quit
    stty start '^-'
}

## read up dirs and fies and bookmarks
#  bookmarks requires addons/bookmark.zsh to be loaded.
function config_read() {
    
    # pop existing history and automatically reload after function over
    # This is part of subcommand, see vared -h 
    fc -ap ~/.zfmhist 20 20

    local conf="$HOME/.zfminfo"
    if [[ -f "$conf" ]]; then
        source $conf
        [[ -n "$DIRS" ]] && ZFM_USED_DIRS=("${(s/:/)DIRS}")
        [[ -n "$FILES" ]] && ZFM_FILE_STACK=("${(s/:/)FILES}")
        local bm
        setopt brace_ccl
        bm=({A-Z})
        for ch in $bm ; do
            var=BM_$ch
            [[ -n ${(P)var} ]] && M_MARKS[$ch]=${(P)var}
        done
        ## local marks
        arr=$( grep '#> ' $conf | cut -c 4- )
        bm=("${(@f)$(print -rl -- $arr)}")
        #perror "$0 got lbm: $#bm >>> $bm"
        #pause
        for ff in $bm
        do
            d=("${(s/:/)ff}")
            M_LOCAL_MARKS[$d[1]]=$d[2]
            #perror "$0: setting $ff to $d[1] : $M_LOCAL_MARKS[$d[1]] "
            #pause
        done
    fi
}
# bound to write subcommand
# :write , :wq , :x
# Append config data to $conf, user should remove dupe entries
# I don't want to overwrite stuff since its possible that multiple instances
# are running and have separate bookmarks which could overwrite each other
#
function config_write() {
    local conf="$HOME/.zfminfo"
    if [[ -f "$conf" ]]; then
        pinfo "Appending data to $conf, please edit."
        print -rl -- "## Updated config on: " >> $conf
        d=${(j#:#)ZFM_USED_DIRS}
        print -rl -- "DIRS=\"$d\"" >> $conf
        d=${(j#:#)ZFM_FILE_STACK}
        print -rl -- "FILES=\"$d\"" >> $conf
        print -rl -- "# Global bookmarks:" >> $conf
        for key in ${(k)M_MARKS} ; do
            # this is okay for global marks but will fail on local ones which have a ":" inside
            # ignore local marks till we find a way
            if [[ $#key -eq 1 ]]; then
                val=$M_MARKS[$key]
                print -rl -- "BM_$key=\"$val\"" >> $conf
            fi
        done

        print -rl -- "# Local bookmarks:" >> $conf
        for key in ${(k)M_LOCAL_MARKS} ; do
            val=$M_LOCAL_MARKS[$key]
            # writing local bookmarks in a comment since the key is a dir which could have spaces etc
            print -rl -- "#> $key:$val" >> $conf
        done
    else
        pinfo "Config data not saved since $conf not found. Use touch $conf to save data."
    fi
}

# comment out next line if sourcing .. sorry could not find a cleaner way
myzfm
