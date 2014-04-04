#!/usr/bin/env zsh
autoload colors && colors
# ----------------------------------------------------------------------------- #
#         File: menu.zsh
#  Description: common routine for prompting user with a menu
#       Author: rkumar http://github.com/rkumar/rbcurse/
#         Date: 2012-12-09 - 21:08 
#      License: Same as Ruby's License (http://www.ruby-lang.org/LICENSE.txt)
#  Last update: 2013-02-24 17:39
# ----------------------------------------------------------------------------- #
# see tools.zsh for how to use:
# source this file
# set myhash and myopts
#      - myhash is a hash, myopts is an array with commands to be executed
#      - myhash contains mnemonics or shortcuts for some of commands in myopts
# call menu_loop

export COLOR_DEFAULT="\\033[0m"
export COLOR_RED="\\033[1;31m"
export COLOR_GREEN="\\033[1;32m"
export COLOR_BLUE='\\033[1;34m'
export COLOR_BOLD="\\033[1m"
export COLOR_BOLDOFF="\\033[22m"
# edit these or override in ENV
ZFM_ZIP_COMMAND=${ZFM_ZIP_COMMAND:-tar zcvf}
ZFM_RM_COMMAND=${ZFM_RM_COMMAND:-rmtrash}
ZFM_UNZIP_COMMAND=${ZFM_UNZIP_COMMAND:-dtrx}
# stores autoaction per filetype
typeset -A ZFM_AUTO_ACTION
## for ungetting keys
[[ -z $Z_KEY_STACK ]] && Z_KEY_STACK=()

#  Print error to stderr so it doesn't mingle with output of method
#  M_MESSAGE is a global we are using to print since we clear the screen each time we display
function perror(){
    M_MESSAGE="ERROR: ${COLOR_RED}$@${COLOR_DEFAULT}"
    print -- "$M_MESSAGE" 1>&2
}
#  Print debug statement to stderr so it doesn't mingle with output of method
function pdebug(){
    [[ -n "$ZFM_VERBOSE" ]] && {
        M_MESSAGE="DEBUG: ${COLOR_RED}$@${COLOR_DEFAULT}"
        print -- "$M_MESSAGE" 1>&2
    }
}
function psuccess(){
    print -- "${COLOR_GREEN}$@${COLOR_DEFAULT}" 1>&2
}

#  Print info statement to stderr so it doesn't mingle with output of method
function pinfo(){
    M_MESSAGE="$@"
    print -- "$@" 1>&2
}
#  Print something bold to stderr
function pbold() {
    print -- "${COLOR_BOLD}$*${COLOR_DEFAULT}" 1>&2
}
#  Pause and get a single key
function pause() {
    #local prompt=${1:"Press a key ..."}
    local prompt="Press a key ..."
    local kk
    print -- "$prompt"
    read -k kk
    print
}
#  Print a title in bold
function print_title() {
    local title="$@"
    print -- "${COLOR_BOLD}${title}${COLOR_DEFAULT}"
}

default="1"

#  Display a menu using numbering and hotkeys if provided
#  Returns selected char in "menu_char"
function print_menu() {
    print_title "$1"

    # chars to use as hotkeys
    local mnem="$3"
    ## earlier this was here , but now moved down so caller can translate
    #[[ -z "$mnem" ]] && mnem="         abcdefghijklmnoprstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    ## menu options, parse using IFS, this can be specified by caller
    local myopts
    read -A myopts <<< "$2"
    local c=1

    ## buffer to concat each row so we can print in 2 cols if required
    local _str
    _str=()
    # trying out ML_COLS so called can specify if he wants more than one column
    ## value is always reset to 1 afte printing so be sure to call each time
    ML_COLS=${ML_COLS:-1}
    for f in $myopts
    do
        sub=$c
        [[ $c -gt 9 ]] && { sub=" " }
        desc=
        if [[ -n "$M_PRINT_COMMAND_DESC" ]]; then
            desc="$COMMANDS[$f]"
            [[ -n "$desc" ]] && desc="==>  $desc"
        fi
        # TODO improve by using printf since we are putting the desc
        #print -- "$sub ${mnem[$c]})  $f	    $desc"
        _str+=("$sub ${mnem[$c]})  $f	    $desc")
        let c++
    done
    print -C$ML_COLS -- $_str
    _str=
    #print $str
    ## called must always specify if more than one
    ML_COLS=1
    # show only a max of 9 in text
    (( c-- ))
    (( c > 9 )) && c=9
    print -n "Enter choice 1-${c} (q=quit): "
    read -k menu_char
}

#  Display menu, hotkeys, convert selected char to actual selection
#  Updates  menu_text
#  Try to keep options to 9, and add a mnemonic for options that go beyond
#  TODO currently splits on string, thus cannot use parameters to command
#  TODO use a comma or something else to delimit so we can pass params
function menu_loop () {
    menu_text=""  # this contains the text of menu such as command
    menu_char="" # contains actual character pressed could be numeric or hotkey (earlier ans)
    menu_index=0 # this contain index numeric

    mnem="$3"
    ## earlier this was in print_menu, but now moved here since we don't have offsets
    [[ -z "$mnem" ]] && mnem="         abcdefghijklmnoprstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    ## XXX updating this does not send it to print menu since we pass args straight !
    # we read only one char, so if the options go beyond 9 then we are royally screwed, take off -1
    local myopts var
while (true) 
do
    local options="$2"
    read -A myopts <<< "$2"
    #print_menu "$@"
    print_menu "$1" "$options" "$mnem"
    print

    ## pressing ENTER selects first entry. 
    [[ $menu_char = $'\n' ]] && { menu_char="1" }
    # 
    # precent some line from crashes program on ESC
    [[ $menu_char = "" ]] && { perror "Got a ESC XXX"; menu_char="q" }
    ## the -- is required else a hyphen entered is swallowed
    menu_char=$(print -- "$menu_char" | tr -d '[\n\r\t ]')
    pdebug "$0 : key is :: $menu_char"
    #[[ -z $menu_char ]] && menu_char="$default"
    if [[ -z $menu_char ]] ;
    then
        # enter pressed, no enter converted to 1, possible tab pressed
        print "press q or ',' to exit without selection " 1>&2
        #print_menu 
    else
        # FIXME, ! is a shortcut for command, now that we are checking later
        # we can release it. The comma is used as it is the back key
        # hash '#' needs to be escaped to be detected
        [[ "$menu_char" =~ [q,] ]] && { return 1 }
        [[ "$menu_char" =~ [-+:] ]] && { return 0 }
        print ""
        if [[ "$menu_char" == [1-9] ]]; then
            var="${myopts[$menu_char]}" # 2>/dev/null
            menu_index=$menu_char
        else
            [[ $menu_char == '#' ]] && menu_char='\#'
            index=$mnem[(i)$menu_char]; 
            #pdebug " index is $index of $#mnem, $mnem"
            if [[ $index -gt $#mnem ]]; then
                var=
                menu_index=
            else
                var=${myopts[$index]} 
                menu_index=$index
                # this is a clever loophole for an extra mnemonic that is beyond the 
                # menu options NOTE XXX
                ## This is used so the menu key that called this can be reused
                ## and hit twice to re-exec the last option. e.g. toggle key will re-toggle
                [[ -z "$var" ]] && {  menu_text=$menu_char; break }
                
            fi
            #pdebug "menu_loop index in mnem is $index , $menu_char, $var : $mnem"
        fi
        #perror "key 4 is $menu_char"
        #[[ -z $var1 ]] && { index=$mnem[(i)$menu_char]; var2=${myopts[$index]} }
        #var2="${myhash[$menu_char]}"
        #var=${var1:-$var2}
        if [[ "$menu_char" = "?" ]]; then
            print_title "   Mnemonics are:"
            local i=1
            spl=( ${(s/ /)options})
            while (( i++ < $#mnem )) { 
                if [[ $i -gt $#spl ]]; then
                    # extra key added in call for passing back 
                    print "    $mnem[$i]      =>  (extra key)"
                else
                    [[ -n ${mnem[$i]// /} ]] && print "    ${mnem[$i]}      =>  ${options[(w)$i]}  ";  
                fi
            }
            print "    [q]    => quit"
            print ""
            print -n " Press a key ... "
            read -q hitenter
            print
        elif [[ -z "$var" ]] ; then
            perror "Wrong option $menu_char. q - quit, ? - options"
        elif [[ -n "$var" ]] ; then
            pdebug "$1 returning $var"
            menu_text=$var
            break
            #echo -n " Press a key ... "
            #read -q hitenter
            #echo
        else
            perror "something wrong"
        fi
    fi
done
}
#  options for files
function fileopt() {
    local name="$1"
    [[ -z $name ]] && return
    #local type="$(filetype $name)"
    ## if no extension then do filetype check
    local -U apps
    extn=$name:e
    [[ -d $name ]] && { extn="DIR" }

    extn=${extn:-NIL}
    if [[ -n $extn ]]; then
        uextn=${(U)extn}
        apps=$FT_ALL_APPS[$extn]  # check cache FT_ALL_APPS[pdf]
        ## if we have not already calculated apps for extension then do so
        if [[ -z "$apps" ]]; then
            ## check for specific apps for this file extn
            #local x="FT_$uextn"  # check FT_PDF
            #pdebug "checking $x : ${(P)x}"
            #apps=( ${(P)x} )
            apps=( $FT_OPTIONS[$uextn] )
            if [[ -z "$apps" ]]; then
                oextn=$FT_ALIAS[$extn]  # htm will translate to html or MARKDOWN to md
                pdebug "$0 checking FT_ALIAS with $extn : got $oextn"
                #[[ -n $oextn ]] && { apps=( ${(P)oextn} ) }
                [[ -n $oextn ]] && { apps=( $FT_OPTIONS[$oextn] ) }
                #pdebug "$0 got apps ... $apps "
            fi
            # repeated below in else
            ## determine filetype and general apps for it
            file_type="$(filetype $name)"
            file_type=${file_type:-other}
            #x="FT_${(U)file_type}"  # check FT_PDF
            #pdebug "checking after filetype $x"
            #apps+=( ${(P)x} ) 
            pdebug "$0 got filetype $file_type "
            uft="${(U)file_type}"  # check PDF or TXT in FT_OPTIONS
            apps+=( $FT_OPTIONS[$uft] )
            #pdebug "$0 got apps $apps "
            # If apps still blank, nwe file type defined like SQLIite but no FT_OPTIONS
            [[ -z $apps ]] && { apps=( $FT_OPTIONS[OTHER] ) }

            ## store for that extension so we can quickly reuse
            ##  It could have been for file type but then we would have to calc that all over
            FT_ALL_APPS[$extn]=$apps
            # calculate hotkeys
            hotkeys=$(get_hotkeys "$apps")
            FT_ALL_HK[$extn]=$hotkeys
        else
            hotkeys=$FT_ALL_HK[$extn]
        fi
    else
        # repeated from above
        ## this is for files with no extension, so cannot use extn as a key
        local ext=NIL
        file_type="$(filetype $name)"
        file_type=${file_type:-other}
        #x="FT_${(U)file_type}"  # check FT_TXT or FT_ZIP etc
        pdebug "checking after filetype $file_type"
        #apps+=( ${(P)x} ) 
        uft="${(U)file_type}"  # check FT_PDF
        apps+=( $FT_OPTIONS[$uft] )
        FT_ALL_APPS[$ext]=$apps
        # calculate hotkeys
        hotkeys=$(get_hotkeys "$apps")
        FT_ALL_HK[$ext]=$hotkeys
    fi
    [[ -z $file_type ]] && { 
        # this is only required for checking about auto-actions, can we avoid if none asked for.
        file_type="$(filetype $name)"
        file_type=${file_type:-other}
    }
    # if user has requested some action to be done automatically on selection of a file of some type
    uft=${(U)file_type}
    local act=$ZFM_AUTO_ACTION[$uft]
    [[ -n "$M_NO_AUTO" ]] && { unset M_NO_AUTO; act= }
    if [[ -n "${act}" ]]; then
        print "got $act for $_act ($uft)"
        name=${name:q}
        eval "${act} $name"
        if [[ $act == $EDITOR || $act =~ ^vi ]]; then
            last_viewed_files=$name 
            execute_hooks "fileopen" $PWD/$name
        else
            pause
        fi
        return
    else
        pdebug "$0 got no auto action for $uft"
        #print -rl -- ${(k)ZFM_AUTO_ACTION}
    fi
    print
    print_title "File summary for $name:"
    file $name
    ls -lh $name
    [[ -e "$name" ]] || { perror "$name not found or not a regular file."; pause; return }
    pdebug "$0 before ML : $apps"
    menu_loop "File Operations ($name):" "$apps" $hotkeys
    [[ -n $ZFM_VERBOSE ]] && pdebug "$0 returned 270 $menu_char, $menutext "
    [[ "$menu_char" =~ [!:] ]] && menu_text="cmd"   # XXX we've moved to ':'
    [[ "$menu_char" = '+' ]] && { zfm_add_option "$name" "$extn" }
    [[ "$menu_char" = '-' ]] && { zfm_rem_option "$name" "$extn" }
    [[ -z "$menu_text" ]] && { return 1; } # q pressed
    eval_menu_text "$menu_text" $name
    [[ -z $NO_PAUSE ]] && pause
    NO_PAUSE=
    # we can store def app in a hash so not queried each time
    #default_app=$(alias -s | grep $extn | cut -f2 -d= )
    #[[ -n "$extn" ]] && default_app=$(alias -s | grep "$extn" | cut -f2 -d= )
}
function eval_menu_text () {
    local menu_text=$1
    [[ -z "$menu_text" ]] && { perror "$0 Empty command passed"; return 1; } # q pressed
    shift
    local files="$@"
    files=${files:q}
    local ret=0
    case $menu_text in
        "cmd")
            zfm_cmd $files
            ;;
        "auto")
            ## Now we meed to factor in file type
            file_type="$(filetype $files)"
            file_type=${file_type:-other}
            x="${(U)file_type}"
            # added this 2012-12-26 - 01:11 
            command=${command:-"$EDITOR"}
            vared -c -p "Enter command to automatically execute for $file_type files: " command
            ZFM_AUTO_ACTION[$x]="$command"
            eval "$command $files"
            [[ $command == $EDITOR || $command =~ ^vi ]] && { 
                last_viewed_files=$files 
                execute_hooks "fileopen" $files
            }
            ;;
        "")
            [[ "$menu_char" =~ [a-zA-Z0-9] ]] || {
            perror "got nothing in fileopt $menu_char. Coud be programmer error or key needs to be handled"
            }
            ;;
        "mv"|"gitmv") 
            zfm_mv $files
            ;;
        "cp") 
            ## currently zfm_mv will use menu_text so it should work with cp also
            #  since both need a target.
            zfm_mv $files
            ;;
        "chdir") 
            # you can select a file in some cases and cd to it as in recent_files
            if [[ -f $files ]]; then
                files=$files:h
            fi
            ## darn, if spaces then this gives an error on quotes
            files=${(Q)files}
            $ZFM_CD_COMMAND $files && post_cd
            NO_PAUSE=1
            ;;
        "archive") 
            zfm_zip $files
            ;;
        *)
            # now again this needs to be done for all cases so we can't have such
            # a long loop repeated everywhere
            evaluate_command "$menu_text" $files
            ret=$?
            [[ $menu_text == $EDITOR || $menu_text =~ ^vi ]] && { 
                NO_PAUSE=1
            }
            [[  $ret -eq 0 ]] && zfm_refresh
            ;;
    esac
}
## add an option to menu for existing extension
#
function zfm_add_option () {
    local file="$1"
    local extn="$2"
    extn=${extn:-NIL}
    vared -c -p "New option to add: " newoption
    [[ -z "$newoption" ]] && { return 1 }
    print "Current hotkeys for $extn are: $FT_ALL_HK[$extn]"
    print "Enter hotkey for this command: "
    read -k hk
    COMMAND_HOTKEYS[$newoption]=$hk
    print
    vared -c -p "Command to execute for above: " newcommand
    #FT_ALL_APPS[$extn]+=(newoption)
    local apps=$FT_ALL_APPS[$extn]
    apps+=($newoption)
    FT_ALL_APPS[$extn]=$apps
    # TODO XXX hotkeys needs to be regen
    # need to ask for a hotkey if user wants
    hotkeys=$(get_hotkeys "$apps")
    FT_ALL_HK[$extn]=$hotkeys

    [[ -n "$newcommand" ]] && { COMMANDS[$newoption]=$newcommand }
}
## remove an option from menu for existing extension
#
function zfm_rem_option () {
    local file="$1"
    local extn="$2"
    extn=${extn:-NIL}
    vared -c -p "Option to delete: " newoption
    [[ -z "$newoption" ]] && { return 1 }
    local apps
    apps=$FT_ALL_APPS[$extn]
    apps=("${(s/ /)apps}")  # convert to array
    index=$apps[(i)$newoption]
    if [[ $index -gt $#apps ]]; then
        perror "$newoption not found"
        pdebug "Options are $apps"
        pdebug "Index is $index, $#apps"
    else
        apps[$index]=()
        pdebug "Options are now $apps"
        FT_ALL_APPS[$extn]=$apps
        hotkeys=$(get_hotkeys "$apps")
        FT_ALL_HK[$extn]=$hotkeys
    fi
}
## add or change an existing command 
#
function zfm_change_command () {
    clear
    print
    pbold "File related commands are : "
    print
    for key in ${(k)COMMANDS}; do
        print "$key : ${COMMANDS[$key]}"
    done
    print
    print "Enter key to change (or add): "
    read key
    [[ -z $key ]] && return 1
    command=$COMMANDS[$key]
    vared -p "Edit command: " command
    COMMANDS[$key]=$command
    pbold "$key is ${COMMANDS[$key]}"
}
#  check file type based on output of file command and return a filetype or blank
function filetype(){
    local name="$1"
    [[ -z $name ]] && return
    [[ -d $name ]] && { print "DIR"; return }
    local type=""
    extn=$name:e
    uextn=${(U)extn}
    pdebug "$0 extn: $extn"
    local spextn

    if [[ -n "$extn" ]]; then
        ## don't go in if no extension
        #
        ## loop through each definition list and search for our extn
        for ff in ${(k)FT_EXTNS} ; do
            v=$FT_EXTNS[$ff]
            pdebug "$0 $ff in ft_extns will search $v"
            ## we still need to put a spce around extn otherwise small extns like c and a will match wrongly
            spextn=" $extn "
            if [[ $v[(i)$spextn] -le $#v ]]; then
                ## v is in uppercase
                type=${ff:l} # lower case
                pdebug "filetype got $type from array"
                break
            fi
        done
    fi
    [[ -n "$type" ]] && { print "$type" && return }
    if [[ "$name" =~ "^..*rc$" ]]; then
        pdebug "inside check for rc file" 
        type="text"
        type="txt"
        print "$type"
        return
    fi
    str="$(file $name)"
    # string search for zip
    ftpatts=(zip text video audio image SQLite tar archive)
    for _p in $ftpatts ; do
        ix=$str[(i)$_p]
        if [[ $ix -le $#str ]]; then
            type=$_p
            break
        fi
    done
    [[ $type == "tar" ]] && type="zip"
    [[ $type == "archive" ]] && type="zip"
    [[ $type == "text" ]] && type="txt"
    print $type
}
# WARNING XXX some of these commands will fail is a file has a space in it
# Then you must put the command in a string and eval it.
# Also all files in the selection list have been quoted, but from other sources they could
# come unquoted, esp to other procedures. If so, have them quoted first.
#   This procedure has operations for multiple files
function multifileopt() {
    local files
    # careful I am quoting spaces so some commands can work like the tar
    # this may cause problems with some commands
    files=($@:q) # NOTE since array incoming we need to bracket else converts to string
    print_title "File summary for $#files files:"
    # eval otherwise files with spaces will cause an error
    eval "ls -lh $files"
    #IFS=, menu_loop "File operations:" "zip,cmd,grep,mv,${ZFM_RM_COMMAND},git add,git com,vim,vimdiff" "zcg!#a vd"
    hotkeys=$(get_hotkeys "$FT_OPTIONS[MULTI]")
    menu_loop "Multiple File operations ($#files):" $FT_OPTIONS[MULTI] $hotkeys
    [[ -n $ZFM_VERBOSE ]] && pdebug "$0 returned $menu_char, $menutext "
    [[ "$menu_char" = "!" ]] && menu_text="cmd"
    case $menu_text in
        "cmd")
            zfm_cmd $files
            ;;
        "")
            [[ "$menu_char" =~ [a-zA-Z0-9] ]] || {
                perror "got nothing in fileopt $menu_char. Could be programmer error or key needs to be handled"
            }
            ;;
        "mv") 
            zfm_mv $files
            ;;
        "zip") 
            zfm_zip $files
            ;;
        "grep")
            greppatt=${greppatt:-""}
            vared -p "Enter pattern : " greppatt
            # piping to pager not working in next line, maybe thinks we are not interactive
            eval "grep $greppatt $files " 
            pause
            ;;
        "gitadd")
            eval "git add $files"
            ;;
        "gitcom")
            eval "git commit $files"
            ;;
        *)

            evaluate_command "$menu_text" $files
            [  $? -eq 0 ] && { 
                [[ $menu_text == $EDITOR || $menu_text =~ ^vi ]] && { 
                    last_viewed_files=$files 
                    execute_hooks "fileopen" $files
                    NO_PAUSE=1
                }
                zfm_refresh
            }
            #[[ -n $ZFM_VERBOSE ]] && perror "213: $menu_text , $files"
            #eval "$menu_text $files"
            #[[ "$menu_text" == "${ZFM_RM_COMMAND}" ]] && zfm_refresh
            ;;
    esac
}
##
# calls either multifile or fileopt depending on number of files.
#  this was being done in so many places, so moved to one call.
#
function call_fileoptions() {
    local files
    files=($@)
    [[ -z $files ]] && files=( $selected_files )
    [[ -z $files ]] && perror "$0 got no files, please check caller"
    if [[ $#files -eq 1 ]]; then
        fileopt $files[1]
    elif [[ $#files -gt 1 ]]; then
        multifileopt $files
    elif [[ -n "$file" ]]; then
        fileopt "$selected_file"
    fi
}
## 
## refresh should be done in caller if stat is 0
## need to check for any variables that need to be prompted
function evaluate_command () {
    local menu_text=$1
    shift
    local files _cmd
    files="$@"
    local ret=0

    _cmd=$(get_command_for_title $menu_text)
    pdebug "$0 got command ($_cmd) for ($menu_text)"
    if [[ -n $_cmd ]]; then
        ## check for variables that need to be prompted
        ##  -- I tried doing this in zsh but did not get too far!
        vars=( $( print $_cmd | grep -o '${[^}]*}' ) )
        for var in $vars ; do
            vv=$(print $var | tr -d '${}' )
            vared -c -p "Enter $vv:" $vv
            _cmd=${(S)_cmd//$var/${(P)vv}}
            pdebug "subst: $_cmd"
        done

        ## check for file replacement marker
        if [[ $_cmd = *%%* ]]; then
            _cmd=${(S)_cmd//\%\%/${files:q}}
            eval "$_cmd" 
            ret=$?
            #zfm_exec_binding $_cmd
        else
            ## no marker just send file names as argument to command
            pdebug "passing files as args $_cmd "
            eval "$_cmd $files"
            ret=$?
        fi
    else
        # no translation just use the title as is
        [[ -n $ZFM_VERBOSE ]] && pdebug "213: $menu_text , $files"
        eval "$menu_text $files" 
        ret=$?
    fi
    # calling some external commands like sqlite3 disables C-q c-\ etc and 
    # C-c aborts app.
    stty_settings
    return $ret
}
#
# print a hash with key in bold
# We need to have some options of separator (space, line) and color

function print_hash () {
   local h
   h=( "$@" ) 
   for (( i = 1; i < $#h; i+=2 )); do
       print -n "${COLOR_BOLD}$h[i]${COLOR_DEFAULT} ${COLOR_GREEN}$h[i+1] ${COLOR_DEFAULT}  "
   done
   print
}
function zfm_cmd () {
    local files
    files=($@)
    #[[ -n $ZFM_VERBOSE ]] && pdebug "PATH is ${PATH}"
    command=${command:-""}
    postcommand=${postcommand:-""}
    vared -p "Enter command (first part) : " command
    [[ -z "$command" ]] && { perror "Command blank. No action taken" ; return }
    vared -p "Enter command (second part): " postcommand
    print "$command $files $postcommand"
    eval "$command $files $postcommand" && zfm_refresh
    [[ $command == $EDITOR || $command =~ ^vi ]] && { 
        last_viewed_files=$files 
        execute_hooks "fileopen" $files
    }
}
function zfm_zip () {
    files=($@)
    ddate=$(date +%Y%m%d_%H%M)
    local arch="archive-${ddate}.tgz"
    vared -p "Enter zip file name: " arch
    # if you don't check the first file will get overwritten with the tar file
    if [[ -e "$arch" ]]; then
        perror "$file exists, cannot overwrite"
        return
    fi
    [[ -n "$arch" ]] && eval "${ZFM_ZIP_COMMAND} $arch $files" && zfm_refresh
}
function zfm_mv() {
    files=($@)
    pinfo "Got $#files : $files"
    target=${target:-$HOME/}
    vared -p "Enter target: " target
    [[ -n $target ]] && { 
        [[ -d $target ]] || perror "$target not a directory, mv likely to fail"
        print "[$menu_text] [$files] $target"
        eval "$menu_text $files $target"
        # user may want to cd to that target using GOTO_DIR
        GOTO_PATH=$target
        zfm_refresh
    }
}
function zfm_edit () {
    files=($@)
    eval "$EDITOR $files"
    last_viewed_files=$files 
    execute_hooks "fileopen" $files
}
## convert menu options or titles to a string of hotkeys formenu_loop
function get_hotkeys () {
    local options="$@"
    local title ii
    local opts
    local str=""
    opts=(${=options})
    for title in $opts; do
        ii=$COMMAND_HOTKEYS[$title]
        if [[ -n "$ii" ]]; then
            str+=$ii
        else
            ## take first letter of title, but what if it exists, then use blank
            ii=$title[1]
            if [[ $str[(i)$ii] -le $#str ]]; then
                ii=" "
            fi
            str+=$ii
        fi
    done
    print $str
}
## 
## Takes a key, if ESC tries to take more and returns
#  normal or function or alt keys.
#  I think this could be vastly simplified by taking a read
#    then if its an ESC keep reading with a timeout till non zero ret val.
#    put this into an array and match against the hash for complex keys.
#    Control and Meta/Alt keys can be checked without the hash.
function _read_keys() {

    local key key2 key3 key4
    integer ret
    ckey=

    ## 2013-01-21 - 00:19 trying out -s with M_NO_REPRINT
    read -k -s key
    ret=$?
    reply="${key}"

    ## This is simpler and works. Keep checking for a key until time out
    if [[ '#key' -eq '#\\e' ]]; then
        while (true); do
            read -t $(( KEYTIMEOUT / 1000 )) -k -s key2
            ret=$?
            if [[ $ret -ne 0 ]]; then
                ret=0
                break
            else
                reply+="$key2"
            fi
        done
        resolve_key_codes
        ## the commented portion was unnece complex with several diff portions
        # for diff kinds of keys. 2013-02-15 - 13:29 
    #if [[ '#key' -eq '#\\e' ]]; then
        ## M-...
        #read -t $(( KEYTIMEOUT / 1000 )) -k -s key2
        #ret=$?
        #if [[ "${key2}" == '[' ]]; then
            ## cursor keys
            #read -k -s key3
            #ret=$?
            #if [[ "${key3}" == [0-9] ]]; then
                ## Home, End, PgUp, PgDn ...
                ## F5 etc take a fifth key, so a loop
                ##read -k -s key4
                ##ret=$?
                ##reply="${key}${key2}${key3}${key4}"
                #reply="${key}${key2}${key3}"
                #while (true); do
                    #read -t $(( KEYTIMEOUT / 1000 )) -k -s key4
                    #if [[ $? -eq 0 ]]; then
                        #reply+="$key4"
                    #else
                        #break
                    #fi
                #done
            #else
                ## arrow keys
                #reply="${key}${key2}${key3}"
            #fi
            #resolve_key_codes
        #elif [[ $ret == "1" ]]; then
            ## we have an escape
            #ret=0
        #elif [[ "${key2}" == 'O' ]]; then
            #read -t $(( KEYTIMEOUT / 1000 )) -k -s key3
            #if [[ $? -eq 0 ]]; then
                #reply="${key}${key2}${key3}"
                #resolve_key_codes
            #fi
        #else
            ## alt keys
            #reply="${key}${key2}"
            #if (( key = 27 )); then
                #x=$((#key2))
                #y=${(#)x}
                #ckey="M-$y"
            #fi
        #fi
    else
        reply="${key}"
        ascii=$((#key))
        # ctrl keys
        (( ascii == 0 )) && { ckey="C-SPACE" }
        (( ascii > 0 && ascii < 27 )) && { (( x = ascii + 96 ));  y=${(#)x}; ckey="C-$y"; }
        case $ckey in
            "C-i") ckey="TAB" # 2013-01-28 - 13:07 
                ;;
            "C-j") ckey="ENTER" # 2013-01-28 - 13:07 
                ;;
        esac
    fi
    [[ -n $ckey ]] && reply=$ckey
    case $reply in
        " ") reply="SPACE" # 2013-01-28 - 13:07 , so that they show up on help clearly
            ;;
        "") reply="ESCAPE"
            ;;
        "") reply="BACKSPACE"
            ;;
    esac

    return $ret
}
## This maps a user-friendly string to key codes of some keys
#  You will have to change some of these if you TERM setting differs
#  Sadly, I could not put the codes here are strings as zsh was crashing 
#  out in some cases (PgDn etc) and simply not responding in some (Home End).
#
function init_key_codes() {
# this is for those cases with 3 or 4 keys
    typeset -Ag kh;
    #kh[(27)]="ESCAPE"
    kh[]="ESCAPE"
    KEY_PGDN="[6~"
    KEY_PGUP="[5~"
    ## I needed to replace the O with a [ for this to work
    #  in Vim Home comes as ^[OH whereas on the command line it is correct as ^[[H
    KEY_HOME='[H'
    KEY_END="[F"
    KEY_F1="OP"
    KEY_UP="[A"
    KEY_DOWN="[B"
    #kh[(27 91 54 126)]="PgDn"
    #kh[(27 91 53 126)]="PgUp"
    #kh[(27 91 65)]="UP"
    #kh[(27 91 66)]="DOWN"
    #kh[(27 91 67)]="RIGHT"
    #kh[(27 91 68)]="LEFT"
    #kh[(27 91 72)]="Home"
    #kh[(27 91 70)]="End"
    #kh[(27 79 80)]="F1"
    #kh[(27 79 81)]="F2"
    #kh[(27 79 82)]="F3"
    #kh[(27 79 83)]="F4"
    #kh[(27 91 49 53 126)]="F5"
    #kh[(27 91 49 55 126)]="F6"
    #kh[(27 91 49 56 126)]="F7"
    #kh[(27 91 49 57 126)]="F8"
    #kh[(27 91 50 48 126)]="F9"
    #kh[(27 91 50 49 126)]="F10"

    kh[$KEY_PGDN]="PgDn"
    kh[$KEY_PGUP]="PgUp"
    kh[$KEY_HOME]="Home"
    kh[$KEY_END]="End"
    kh[$KEY_F1]="F1"
    kh[$KEY_UP]="UP"
    kh[$KEY_DOWN]="DOWN"
    KEY_LEFT='[D' 
    KEY_RIGHT='[C' 
    kh+=(
       OQ  F2
       OR  F3
       OS  F4
       $KEY_LEFT LEFT
       $KEY_RIGHT RIGHT
       )
    KEY_F5='[15~'
    KEY_F6='[17~'
    KEY_F7='[18~'
    KEY_F8='[19~'
    KEY_F9='[20~'
    KEY_F10='[21~'
    kh[$KEY_F5]="F5"
    kh[$KEY_F6]="F6"
    kh[$KEY_F7]="F7"
    kh[$KEY_F8]="F8"
    kh[$KEY_F9]="F9"
    kh[$KEY_F10]="F10"

}
## Resolve complex key codes, convert string recieved into indiv codes and then check
# hash for a user-fr string
# if not found should we return UNKNOWN or since ckey is blank, reply will be checked.
#
function resolve_key_codes() {

    [[ -z $kh ]] && init_key_codes

    ## break the string into individual codes and make an array of it.
    #keyarr=()
    #for (( i = 1; i <= $#reply; i++ )); do
        #j=$reply[$i]
        #k=$((#j))
        #keyarr+=($k)
    #done
    #ckey=$kh[($keyarr)]
    ckey=$kh[$reply]
    if [[ -z $ckey ]]; then
        # alt keys
        # there should be only 27 and one more
        # need to check with rbc about these keys, hundreds of other combos in there
        key2=$reply[2]
        # should check reply[1] and not array
        #if (( $keyarr[1] = 27 )); then
            x=$((#key2))
            y=${(#)x}
            ckey="M-$y"
        #else
            #perror "keyarr[1] != 27 $keyarr[1]"
            #pause
        #fi
    fi
}
## puts the first element into reply
#  This is used as an ungetc stack
function pop_key_stack(){
    [[ $#Z_KEY_STACK -eq 0 ]] && { return 0 }
    reply=$Z_KEY_STACK[1]
    Z_KEY_STACK[1]=()
    return 0
}
function push_key_stack(){
    [[ -z $1 ]] && return 1
    Z_KEY_STACK+=($1)
    return 0
}


