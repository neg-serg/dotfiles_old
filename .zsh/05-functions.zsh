function chpwd() {
    [ "$PWD" -ef "$HOME" ] || Z -a "$PWD"
}

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
function cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

function magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

function no-magic-abbrev-expand() {
    LBUFFER+=' '
}

function zc(){
  local cache="$ZSH/cache"
  autoload -U compinit zrecompile
  compinit -d "$cache/zcomp-$HOST"

  for z in $HOME/.zsh/**/**.zsh $HOME/.zshrc; do zcompile $z; echo "Compiled $z"; done
  for f in ~/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc
}

# completion system
if zrcautoload compinit ; then
    compinit || print 'Notice: no compinit available :('
else
    print 'Notice: no compinit available :('
    function zstyle { }
    function compdef { }
fi

# Load is-at-least() for more precise version checks Note that this test will
# *always* fail, if the is-at-least function could not be marked for
# autoloading.
zrcautoload is-at-least || is-at-least() { return 1 }

# utility functions
# this function checks if a command exists and returns either true
# or false. This avoids using 'which' and 'whence', which will
# avoid problems with aliases for which on certain weird systems. :-)
# Usage: check_com [-c|-g] word
#   -c  only checks for external commands
#   -g  does the usual tests and also checks for global aliases
function check_com() {
    emulate -L zsh
    local -i comonly gatoo

    if [[ $1 == '-c' ]] ; then
        (( comonly = 1 ))
        shift
    elif [[ $1 == '-g' ]] ; then
        (( gatoo = 1 ))
    else
        (( comonly = 0 ))
        (( gatoo = 0 ))
    fi

    if (( ${#argv} != 1 )) ; then
        return 1
    fi

    if (( comonly > 0 )) ; then
        [[ -n ${commands[$1]}  ]] && return 0
        return 1
    fi

    if   [[ -n ${commands[$1]}    ]] \
      || [[ -n ${functions[$1]}   ]] \
      || [[ -n ${aliases[$1]}     ]] \
      || [[ -n ${reswords[(r)$1]} ]] ; then

        return 0
    fi

    if (( gatoo > 0 )) && [[ -n ${galiases[$1]} ]] ; then
        return 0
    fi

    return 1
}

# a generic accept-line wrapper

# This widget can prevent unwanted autocorrections from command-name
# to _command-name, rehash automatically on enter and call any number
# of builtin and user-defined widgets in different contexts.
#
# For a broader description, see:
# <http://bewatermyfriend.org/posts/2007/12-26.11-50-38-tooltime.html>
#
# The code is imported from the file 'zsh/functions/accept-line' from
# <http://ft.bewatermyfriend.org/comp/zsh/zsh-dotfiles.tar.bz2>, which
# distributed under the same terms as zsh itself.

# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true

function Accept-Line() {
    setopt localoptions noksharrays
    local -a subs
    local -xi aldone
    local sub
    local alcontext=${1:-$alcontext}

    zstyle -a ":acceptline:${alcontext}" actions subs

    (( ${#subs} < 1 )) && return 0

    (( aldone = 0 ))
    for sub in ${subs} ; do
        [[ ${sub} == 'accept-line' ]] && sub='.accept-line'
        zle ${sub}

        (( aldone > 0 )) && break
    done
}

function Accept-Line-getdefault() {
    emulate -L zsh
    local default_action

    zstyle -s ":acceptline:${alcontext}" default_action default_action
    case ${default_action} in
        ((accept-line|))
            printf ".accept-line"
            ;;
        (*)
            printf ${default_action}
            ;;
    esac
}

function Accept-Line-HandleContext() {
    zle Accept-Line

    default_action=$(Accept-Line-getdefault)
    zstyle -T ":acceptline:${alcontext}" call_default \
        && zle ${default_action}
}

function accept-line() {
    setopt localoptions noksharrays
    local -ax cmdline
    local -x alcontext
    local buf com fname format msg default_action

    alcontext='default'
    buf="${BUFFER}"
    cmdline=(${(z)BUFFER})
    com="${cmdline[1]}"
    fname="_${com}"

    Accept-Line 'preprocess'

    zstyle -t ":acceptline:${alcontext}" rehash \
        && [[ -z ${commands[$com]} ]]           \
        && rehash

    if    [[ -n ${com}               ]] \
       && [[ -n ${reswords[(r)$com]} ]] \
       || [[ -n ${aliases[$com]}     ]] \
       || [[ -n ${functions[$com]}   ]] \
       || [[ -n ${builtins[$com]}    ]] \
       || [[ -n ${commands[$com]}    ]] ; then

        # there is something sensible to execute, just do it.
        alcontext='normal'
        Accept-Line-HandleContext

        return
    fi

    if    [[ -o correct              ]] \
       || [[ -o correctall           ]] \
       && [[ -n ${functions[$fname]} ]] ; then

        # nothing there to execute but there is a function called
        # _command_name; a completion widget. Makes no sense to
        # call it on the commandline, but the correct{,all} options
        # will ask for it nevertheless, so warn the user.
        if [[ ${LASTWIDGET} == 'accept-line' ]] ; then
            # Okay, we warned the user before, he called us again,
            # so have it his way.
            alcontext='force'
            Accept-Line-HandleContext

            return
        fi

        if zstyle -t ":acceptline:${alcontext}" nocompwarn ; then
            alcontext='normal'
            Accept-Line-HandleContext
        else
            # prepare warning message for the user, configurable via zstyle.
            zstyle -s ":acceptline:${alcontext}" compwarnfmt msg

            if [[ -z ${msg} ]] ; then
                msg="%c will not execute and completion %f exists."
            fi

            zformat -f msg "${msg}" "c:${com}" "f:${fname}"

            zle -M -- "${msg}"
        fi
        return
    elif [[ -n ${buf//[$' \t\n']##/} ]] ; then
        # If we are here, the commandline contains something that is not
        # executable, which is neither subject to _command_name correction
        # and is not empty. might be a variable assignment
        alcontext='misc'
        Accept-Line-HandleContext

        return
    fi

    # If we got this far, the commandline only contains whitespace, or is empty.
    alcontext='empty'
    Accept-Line-HandleContext
}

zle -N accept-line
zle -N Accept-Line
zle -N Accept-Line-HandleContext

function ESC_print () { info_print $'\ek' $'\e\\' "$@"  }
function set_title () { info_print  $'\e]0;' $'\a' "$@" }
function info_print () {
    local esc_begin esc_end
    esc_begin="$1"
    esc_end="$2"
    shift 2
    printf '%s' ${esc_begin}
    printf '%s' "$*"
    printf '%s' "${esc_end}"
}

function pk () {
    if [ $1 ] ; then
        case $1 in
            tbz)    tar cjvf $2.tar.bz2 $2                ;;
            tgz)    tar czvf $2.tar.gz  $2                ;;
            tar)    tar cpvf $2.tar  $2                   ;;
            bz2)    bzip $2                               ;;
            gz)     gzip -c -9 -n $2 > $2.gz              ;;
            zip)    zip -r $2.zip $2                      ;;
            7z)     7z a $2.7z $2                         ;;
            *)      echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


function simple-extract() {
    emulate -L zsh
    setopt extended_glob noclobber
    local DELETE_ORIGINAL DECOMP_CMD USES_STDIN USES_STDOUT GZTARGET WGET_CMD
    local RC=0
    zparseopts -D -E "d=DELETE_ORIGINAL"
    for ARCHIVE in "${@}"; do
        case $ARCHIVE in
            *.(tar.bz2|tbz2|tbz))    DECOMP_CMD="tar -xvjf -" USES_STDIN=true USES_STDOUT=false ;;
            *.(tar.gz|tgz))          DECOMP_CMD="tar -xvzf -" USES_STDIN=true USES_STDOUT=false ;;
            *.(tar.xz|txz|tar.lzma)) DECOMP_CMD="tar -xvJf -" USES_STDIN=true USES_STDOUT=false ;;
            *.tar)                   DECOMP_CMD="tar -xvf -" USES_STDIN=true USES_STDOUT=false ;;
            *.rar)                   DECOMP_CMD="unrar x" USES_STDIN=false USES_STDOUT=false ;;
            *.lzh)                   DECOMP_CMD="lha x" USES_STDIN=false USES_STDOUT=false ;;
            *.7z)                    DECOMP_CMD="7z x" USES_STDIN=false USES_STDOUT=false ;;
            *.wim)                   DECOMP_CMD="7z x" USES_STDIN=false USES_STDOUT=false ;;
            *.(zip|jar))             DECOMP_CMD="7z x" USES_STDIN=false USES_STDOUT=false ;;
            *.deb)                   DECOMP_CMD="ar -x" USES_STDIN=false USES_STDOUT=false ;;
            *.bz2)                   DECOMP_CMD="bzip2 -d -c -" USES_STDIN=true USES_STDOUT=true ;;
            *.(gz|Z))                DECOMP_CMD="gzip -d -c -" USES_STDIN=true USES_STDOUT=true ;;
            *.(xz|lzma))             DECOMP_CMD="xz -d -c -" USES_STDIN=true USES_STDOUT=true ;;
            *)
                print "ERROR: '$ARCHIVE' has unrecognized archive type." >&2; RC=$((RC+1)); continue
                ;;
        esac
        if ! check_com ${DECOMP_CMD[(w)1]}; then
            echo "ERROR: ${DECOMP_CMD[(w)1]} not installed." >&2
            RC=$((RC+2))
            continue
        fi
        GZTARGET="${ARCHIVE:t:r}"
        if [[ -f $ARCHIVE ]] ; then
            print "Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} < "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} < "$ARCHIVE"
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} "$ARCHIVE" > $GZTARGET
                else
                    ${=DECOMP_CMD} "$ARCHIVE"
                fi
            fi
            [[ $? -eq 0 && -n "$DELETE_ORIGINAL" ]] && rm -f "$ARCHIVE"
        elif [[ "$ARCHIVE" == (#s)(https|http|ftp)://* ]] ; then
            if check_com curl; then
                WGET_CMD="curl -L -k -s -o -"
            elif check_com wget; then
                WGET_CMD="wget -q -O - --no-check-certificate"
            else
                print "ERROR: neither wget nor curl is installed" >&2
                RC=$((RC+4))
                continue
            fi
            print "Downloading and Extracting '$ARCHIVE' ..."
            if $USES_STDIN; then
                if $USES_STDOUT; then
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD} > $GZTARGET
                    RC=$((RC+$?))
                else
                    ${=WGET_CMD} "$ARCHIVE" | ${=DECOMP_CMD}
                    RC=$((RC+$?))
                fi
            else
                if $USES_STDOUT; then
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE") > $GZTARGET
                else
                    ${=DECOMP_CMD} =(${=WGET_CMD} "$ARCHIVE")
                fi
            fi
        else
            print "ERROR: '$ARCHIVE' is neither a valid file nor a supported URI." >&2
            RC=$((RC+8))
        fi
    done
    return $RC
}

function up-one-dir   { pushd .. > /dev/null; zle redisplay; zle -M `pwd`;  }
function back-one-dir { popd     > /dev/null; zle redisplay; zle -M `pwd`;  }
zle -N up-one-dir
zle -N back-one-dir

function xkcdrandom(){ wget -qO- dynamic.xkcd.com/comic/random|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}
function xkcd(){ wget -qO- http://xkcd.com/|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';}
# just type '...' to get '../..'
function rationalise-dot() {
    local MATCH
    if [[ $LBUFFER =~ '(^|/| |  |'$'\n''|\||;|&)\.\.$' ]]; then
        LBUFFER+=/
        zle self-insert
        zle self-insert
    else
        zle self-insert
    fi
}
zle -N rationalise-dot

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word() {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word

# grep for running process, like: 'any vime
function any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any <keyword>" >&2 ; return 1
    else
        ps xauwww | grep  --color=auto -i "[${1[1]}]${1[2,-1]}"
    fi
}

#f5# Create directory under cursor or the selected area
function inplaceMkDirs() {
    # Press ctrl-xM to create the directory under the cursor or the selected area.
    # To select an area press ctrl-@ or ctrl-space and use the cursor.
    # Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
    # directory does not exist yet -> press ctrl-XM and problem solved
    local PATHTOMKDIR
    if ((REGION_ACTIVE==1)); then
        local F=$MARK T=$CURSOR
        if [[ $F -gt $T ]]; then
            F=${CURSOR}
            T=${MARK}
        fi
        # get marked area from buffer and eliminate whitespace
        PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
        PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
    else
        local bufwords iword
        bufwords=(${(z)LBUFFER})
        iword=${#bufwords}
        bufwords=(${(z)BUFFER})
        PATHTOMKDIR="${(Q)bufwords[iword]}"
    fi
    [[ -z "${PATHTOMKDIR}" ]] && return 1
    PATHTOMKDIR=${~PATHTOMKDIR}
    if [[ -e "${PATHTOMKDIR}" ]]; then
        zle -M " path already exists, doing nothing"
    else
        zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
        zle end-of-line
    fi
}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
    zle reset-prompt
}

# 2011-10-19
# stolen from completion function _tmux
function __tmux-sessions() {
    local expl
    local -a sessions
    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}
compdef __tmux-sessions tm 

function imv() {
    local src dst
    for src; do
        [[ -e $src ]] || { print -u2 "$src does not exist"; continue }
        dst=$src
        vared dst
        [[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
    done
}

function pstop() {
    ps -eo pid,user,pri,ni,vsz,rsz,stat,pcpu,pmem,time,comm --sort -pcpu |
    head "${@:--n 20}"
}

function finfo() {
while [ $# -gt 0 ] ; do
    mime_type=$(file -L -b --mime-type "$1")
    case $mime_type in
        image/svg+xml) inkscape -S "$1" ;;
        video/* | application/vnd.rn-realmedia | audio/* | image/*) mediainfo "$1" ;;
        application/pdf) pdfinfo "$1" ;;
        application/zip) unzip -l "$1" ;;
        application/x-lha) lha -l "$1" ;;
        application/x-rar) unrar lb "$1" ;;
        application/x-bittorrent) aria2c -S "$1" | grep '\./' ;;
        application/x-iso9660-image) isoinfo -J -l -i "$1" ;;
        *)
            case "$1" in
                *.torrent) aria2c -S "$1" | grep '\./' ;;
                *.mkv) mediainfo "$1" ;;
                *.ace) unace l "$1" ;;
                *.icns) icns2png -l "$1" ;;
                *) file -b "$1" ;;
            esac
            ;;
    esac
    shift
done
}

function rfc(){
    [ "$PAGER" ] || PAGER=less
    uri_tmpl='http://www.rfc-editor.org/rfc/rfc%d.txt';
    rfcn=$( printf $1 | sed 's/[^0-9]//g' );
    if [ -z "$rfcn" ]; then
    echo  "Usage: rfc <RFC>";
    exit;
    fi
    uri=$( printf $uri_tmpl $rfcn );
    curl --silent $uri | $PAGER;
}

function myip(){
    if [ -n "$1" ]; then
    sleep $1;
    fi

    if [ -x /usr/bin/dig ]; then
        DNSQUERY=`dig +short myip.opendns.com @resolver1.opendns.com`
    fi

    if [ -n "$DNSQUERY" ]; then
        echo "$DNSQUERY"
    else
        ( wget -O- -T2 -q http://noone.org/cgi-bin/whatsmyip.cgi || \
        wget -O- -T2 -q http://v4.showip.spamt.net/ || \
        wget -O- -T2 -q http://showipv6.de/shortv4only || \
        wget -O- -T2 -q http://checkip.dyndns.org/ | sed -e 's|^.*<body>Current IP Address: ||;s|</body>.*$||;s|^50
    0 .*|N/A|;' || \
        wget -O- -T2 -q http://ente.limmat.ch/myip | fgrep 'Your IP' | sed -e 's|^.*(||;s|).*$||;s|^500 .*|N/A|;' | \
        echo N/A ) | \
        sed -e 's:^$:N/A:'
    fi
}

function eat(){
    # eat - copy to the clipboard the contents of a file

    # Program name from it's filename
    prog=${0##*/}

    # Text color variables
    bldblu='\e[1;34m'         # blue
    bldred='\e[1;31m'         # red
    bldwht='\e[1;37m'         # white
    txtbld=$(tput bold)       # bold
    txtund=$(tput sgr 0 1)    # underline
    txtrst='\e[0m'            # text reset
    info=${bldwht}*${txtrst}
    pass=${bldblu}*${txtrst}
    warn=${bldred}!${txtrst}

    filename=$@

    # Display usage if full argument isn't given
    if [[ -z $filename ]]; then
        echo " $prog <filename> - copy a file to the clipboard"
        exit
    fi

    # Check that file exists
    if [[ ! -f $filename ]]; then
    echo -e "$warn File ${txtund}$filename${txtrst} doesn't exist"
    exit
    fi

    # Check user is not root (root doesn't have access to user xorg server)
    if [[ $(whoami) == root ]]; then
    echo -e "$warn Must be regular user to copy a file to the clipboard"
    exit
    fi

    # Copy file to clipboard, give feedback
    xclip -in -selection c < "$filename"
    echo -e "$pass ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

function fg-widget() {
    stty icanon echo -inlcr < /dev/tty
    stty lnext '^V' quit '^\' susp '^Z' < /dev/tty
    zle reset-prompt
    if jobs %- >/dev/null 2>&1; then
        fg %-
    else
        fg
    fi
}
zle -N fg-widget


function expand-or-complete-and-highlight() {
    zle expand-or-complete
    _zsh_highlight
}

zle -N expand-or-complete-and-highlight expand-or-complete-and-highlight

function pcp(){
    #pcp - copy files matching pattern $1 to $2
    find . -regextype awk -iregex ".*$1.*" -print0 | xargs -0 cp -vR -t "$2"
}

# usage: *(o+rand) or *(+rand)
function rand() { REPLY=$RANDOM; (( REPLY > 16383 )) }

fasd_cache="$HOME/bin/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias vv='f -e vim'

function copy-to-clipboard() {
    (( $+commands[xclip] )) || return
    echo -E -n - "$BUFFER" | xclip -i
}
zle -N copy-to-clipboard

# expand-or-complete, but sets buffer to "cd" if it's empty
function expand-or-complete-or-cd() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="cd "
        CURSOR=3
        # don't want that after all
        # zle menu-expand-or-complete
        zle menu-expand-or-complete
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-cd

function accept-line-rdate() {
    local old=$RPROMPT
    RPROMPT=$(date +%T 2>/dev/null)
    zle reset-prompt
    RPROMPT=$old
    zle accept-line
};
zle -N accept-line-rdate

function ff() {
    find . -iregex ".*$@.*" -printf '%P\0' | xargs -r0 ls --color=auto -1d
}

function magnet_to_torrent() {
    [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
    hashh=${match[1]}
    if [[ "$1" =~ dn=([^\&/]+) ]];then
      filename=${match[1]}
    else
      filename=$hashh
    fi
    echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}

function hi2() {
    if [ ! -x $(which pygmentize) ]; then
        echo package \'pygmentize\' is not installed!
        exit -1
    fi

    if [ $# -eq 0 ]; then
        pygmentize -g $@
    fi

    for FNAME in $@
    do
        filename=$(basename "$FNAME")
        lexer=`pygmentize -N \"$filename\"`
        if [ "Z$lexer" != "Ztext" ]; then
            pygmentize -l $lexer "$FNAME"
        else
            pygmentize -g "$FNAME"
        fi
    done
}

# un-smart function for viewing sectioned partitions:
function dfu() {
  local FSTYPES
  FSTYPES=(nilfs2 btrfs ext2 ext3 ext4 jfs xfs zfs reiserfs reiser4 minix ntfs ntfs-3g fat vfat fuse)
  df -hTP -x rootfs -x devtmpfs -x tmpfs -x none ; print
  df -hTP $(for f in $FSTYPES; { print - " -x $f" })
}

function doc2pdf () { curl -# -F inputDocument=@"$1" http://www.doc2pdf.net/convert/document.pdf > "${1%.*}.pdf" }

function discover () {
    keyword=$(echo "$@" |  sed 's/ /.*/g' | sed 's:|:\\|:g' | sed 's:(:\\(:g' | sed 's:):\\):g')
    locate -ir $keyword
}

function sprunge() {
    if [ -t 0 ]; then
      echo Running interactively, checking for arguments... >&2
      if [ "$*" ]; then
        echo Arguments present... >&2
        if [ -f "$*" ]; then
          echo Uploading the contents of "$*"... >&2
          cat "$*"
        else
          echo Uploading the text: \""$*"\"... >&2
          echo "$*"
        fi | curl -F 'sprunge=<-' http://sprunge.us
      else
        echo No arguments found, printing USAGE and exiting. >&2
        usage
      fi
    else
      echo Using input from a pipe or STDIN redirection... >&2
      curl -F 'sprunge=<-' http://sprunge.us
    fi
}

function XC () { xclip -in -selection clipboard <(history | tail -n1 | cut -f2) }
# un-smart function for viewing/editing history file (still use 'fc/history'):
function zhist {
    if [[ $# -ge 1 ]]; then
    case $1 {
        '-a'|'-all') <${ZDOTDIR:-${HOME}/zsh}/.history | ${PAGER:-less} ;;
        '-e'|'--edit') ${EDITOR:-/usr/bin/vim} ${ZDOTDIR:-${HOME}/zsh}/.history ;;
        '-f'|'--find') [[ -n $2 ]] && <${ZDOTDIR:-${HOME}/zsh}/.history|grep -i "${${@:/$1}// /\|}" ;;
    }
    else
        print - "options: -e (edit), -f (find), -a (all)"
    fi
}

# slow output
function slow_output() { while IFS= read -r -N1; do printf "%c" "$REPLY"; sleep ${1:-.02}; done; }
# change terminal title
function tname() { printf "%b" "\e]0;${1:-$TERM}\a"; }
# function dropcache { sync && command su -s /bin/zsh -c 'echo 3 > /proc/sys/vm/drop_caches' root }

# un-smart function for viewing/editing history file (still use 'fc/history'):
function zhist {
  if [[ $# -ge 1 ]]; then
    case $1 {
      '-a'|'-all') <~/.zsh_history | ${PAGER:-less} ;;
      '-e'|'--edit') ${EDITOR:-/usr/bin/vim} ~/.zsh_history ;;
      '-f'|'--find') [[ -n $2 ]] && <~/.zsh_history|grep -i "${${@:/$1}// /\|}" ;;
    }
  else
    print - "options: -e (edit), -f (find), -a (all)"
  fi
}

function capture() {
   ffcast -w ffmpeg -f alsa -ac 2 -i hw:0,2 -f x11grab -s %s -i %D+%c -acodec pcm_s16le -vcodec huffyuv $@
}
