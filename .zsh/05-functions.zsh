# Dir reload
.() { [[ $# = 0 ]] && cd . || builtin . "$@"; }
function chpwd() {
    if [ -x ${BIN_HOME}/Z ]; then
        [ "${PWD}" -ef "${HOME}" ] || Z -a "${PWD}"
    fi
    if [[ ${_zsh_oldprompt_is_sourced} == "true" ]]; then
        export PS1="${_neg_user_pretok}%40<..<$(${ZSH}/neg-prompt)"
    fi
}

# Rename pictures based on information found in exif headers
function jpegrename(){
    if [[ $# -lt 1 ]] ; then
        echo 'Usage: jpgrename $FILES' >& 2
        return 1
    else
        echo -n 'Checking for jhead with version newer than 1.9: '
        jhead_version=$(jhead -h | \
                    grep 'used by most Digital Cameras.  v.*' | \
                    awk '{print $6}' | tr -d v)
        if [[ ${jhead_version} -gt '1.9' ]]; then
            echo 'success - now running jhead.'
            jhead -n%Y-%m-%d_%Hh%M_%f $*
        else
            echo 'failed - exiting.'
        fi
    fi
}


function magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

function no-magic-abbrev-expand() { LBUFFER+=' ' }

function zc(){
  local cache="${ZSH}/cache"
  autoload -U compinit zrecompile
  compinit -d "${cache}/zcomp-${HOST}"
  for z in ${ZSH}/*.zsh ${HOME}/.zshrc; do 
      zcompile ${z}; 
      echo $(_zpref) $(_zfwrap "${z}"); 
  done
  for f in ${HOME}/.zshrc "${cache}/zcomp-${HOST}"; do
      zrecompile -p ${f} && command rm -f ${f}.zwc.old
  done
  source ${HOME}/.zshrc
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

function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0 
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) [ -z $commands[pigz] ] && tar zxvf "$1" || pigz -dc "$1" | tar xv ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) [ -z $commands[pigz] ] && gunzip "$1" || pigz -d "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip|*.war|*.jar|*.sublime-package) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar x -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*) 
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1 
      ;; 
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

function up-one-dir   { pushd .. > /dev/null; zle redisplay; zle -M $(pwd);  }
function back-one-dir { popd     > /dev/null; zle redisplay; zle -M $(pwd);  }
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

# jump behind the first word on the cmdline.
# useful to add options.
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
        if [ ! -x `which peco` ]; then
            echo "any - grep for process(es) by keyword" >&2
            echo "Usage: any <keyword>" >&2 ; return 1
        else
            ps xauwww | peco --layout=bottom-up
        fi
    else
        ps xauwww | grep  --color=auto -i "[${1[1]}]${1[2,-1]}"
    fi
}

function inplace_mk_dirs() {
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

function imv() {
    local src dst
    for src; do
        [[ -e ${src} ]] || { print -u2 "${src} does not exist"; continue }
        dst=${src}
        vared dst
        [[ ${src} != ${dst} ]] && mkdir -p ${dst:h} && mv -n ${src} ${dst}
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
    uri_tmpl='http://www.rfc-editor.org/rfc/rfc%d.txt';
    rfcn=$( printf $1 | sed 's/[^0-9]//g' );
    [[ -z "${rfcn}" ]] && echo  "Usage: rfc <RFC>"; exit;
    uri=$( printf ${uri_tmpl} ${rfcn} )
    curl --silent ${uri} | ${PAGER}
}

function myip(){
    [[ -n "$1" ]] && sleep $1;
    [[ -x $(which dig) ]] && DNSQUERY=$(dig +short myip.opendns.com @resolver1.opendns.com)

    if [[ -n "$DNSQUERY" ]]; then
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


#pcp - copy files matching pattern $1 to $2
function pcp(){ find . -regextype awk -iregex ".*$1.*" -print0 | xargs -0 cp -vR -t "$2" }

fasd_cache="$HOME/bin/.fasd-init-cache"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

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

function ff() { find . -iregex ".*$@.*" -printf '%P\0' | xargs -r0 ls --color=auto -1d }

function magnet_to_torrent() {
    [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
    hashh=${match[1]}
    if [[ "$1" =~ dn=([^\&/]+) ]];then
      filename=${match[1]}
    else
      filename=${hashh}
    fi
    echo "d10:magnet-uri${#1}:${1}e" > "${filename}.torrent"
}

function hi2() {
    if [ ! -x $(which pygmentize) ]; then
        echo package \'pygmentize\' is not installed!
        exit -1
    fi

    if [ $# -eq 0 ]; then
        pygmentize -g $@
    fi

    for file_name in "$@"; do
        filename=$(basename "${file_name}")
        lexer=$(pygmentize -N \"$filename\")
        if [ "Z$lexer" != "Ztext" ]; then
            pygmentize -l $lexer "${file_name}"
        else
            pygmentize -g "${file_name}"
        fi
    done
}

function doc2pdf () { curl -\# -F inputDocument=@"$1" http://www.doc2pdf.net/convert/document.pdf > "${1%.*}.pdf" }

function discover () {
    keyword=$(echo "$@" |  sed 's/ /.*/g' | sed 's:|:\\|:g' | sed 's:(:\\(:g' | sed 's:):\\):g')
    locate -ir ${keyword}
}

function sprunge() {
    if [[ -t 0 ]]; then
      echo Running interactively, checking for arguments... >&2
      if [[ "$*" ]]; then
        echo Arguments present... >&2
        if [[ -f "$*" ]]; then
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

function slow_output() { while IFS= read -r -N1; do printf "%c" "$REPLY"; sleep ${1:-.02}; done; }
function dropcache { sync && command su -s /bin/zsh -c 'echo 3 > /proc/sys/vm/drop_caches' root }

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

function search() {
    emulate -L zsh

    # define search engine URLS
    typeset -A urls
    urls=(
        google      "https://www.google.com/search?q="
        bing        "https://www.bing.com/search?q="
        yahoo       "https://search.yahoo.com/search?p="
        duckduckgo  "https://www.duckduckgo.com/?q="
        yandex      "https://yandex.ru/yandsearch?text="
    )

    # define the open command
    case "${OSTYPf}E" in
        darwin*)  open_cmd="open" ;;
        cygwin*)  open_cmd="cygstart" ;;
        linux*)   open_cmd="xdg-open" ;;
        *)        echo "Platform $OSTYPE not supported"
                return 1
                ;;
    esac

    # check whether the search engine is supported
    if [[ -z "${urls}[$1]" ]]; then
        echo "Search engine $1 not supported."
        return 1
    fi

    # search or go to main page depending on number of arguments passed
    if [[ $# -gt 1 ]]; then
        # build search url:
        # join arguments passed with '+', then append to search engine URL
        url="${urls[$1]}${(j:+:)@[2,-1]}"
    else
        # build main page url:
        # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
        url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi

    nohup ${open_cmd} "${url}" &>/dev/null
}

function hugepage_disable(){
    echo 'echo "madvise" >> /sys/kernel/mm/transparent_hugepage/defrag' | sudo -s
    cat /sys/kernel/mm/transparent_hugepage/defrag
}

function teapot_xterm(){ curl http://www.dim13.org/tek/teapot.tek }

function bookmarks_export(){
    printf "----[ 10 days history ]----\n"
    limit="10 days"
    places=$(find ${HOME}/.mozilla/ -name "places.sqlite" | head -1)
    sql="SELECT url FROM moz_places, moz_historyvisits \
    WHERE moz_places.id = moz_historyvisits.place_id \
    and visit_date > strftime('%s','now','-$limit')*1000000 \
    ORDER by visit_date;"
    sqlite3 ${places} ${sql}

    printf "----[ All history ]----\n"
    sqlite3 ~/.mozilla/firefox/*/places.sqlite "
    select moz_places.url, moz_bookmarks.title from moz_places, moz_bookmarks
    where moz_bookmarks.fk = moz_places.id and moz_bookmarks.type = 1
    and length(moz_bookmarks.title) > 0 order by moz_bookmarks.dateAdded"
}

function chrome_history(){
  export CONF_COLS=$[ COLUMNS/2 ]
  export CONF_SEP='{::}'

  cp -f ${XDG_CONFIG_HOME}/chromium/Default/History /tmp/h

  sqlite3 -separator $CONF_SEP /tmp/h 'select title, url from urls order by last_visit_time desc' \
      | ruby -ne '
  cols = ENV["CONF_COLS"].to_i
  title, url = $_.split(ENV["CONF_SEP"])
  puts "\x1b[33m#{title.ljust(cols)}\x1b[0m #{url}"' \
      | fzf --ansi --multi --no-hscroll --tiebreak=index \
      | grep --color=never -o 'https\?://.*'

  unset CONF_COLS CONF_SEP
}

function cache_list(){
    dirlist=(
        ${HOME}/.w3m/*
        ${XDG_DATA_HOME}/recently-used.xbel
        ${XDG_CACHE_HOME}/mc/*
        ${XDG_DATA_HOME}/mc/history
        ${HOME}/.viminfo
        ${HOME}/.adobe/
        ${HOME}/.macromedia/
        ${XDG_CACHE_HOME}/mozilla/
        ~/.thumbnails/
    )
    du -shc ${dirlist}
}

function toggle_mpdsc(){
    local is_run="active (running)"
    if [[ "$(systemctl --user status mpdscribble.service|grep -o "${is_run}")" == "${is_run}" ]]; then
        systemctl --user stop mpdscribble
        =mpdscribble --conf ${XDG_CONFIG_HOME}/mpdscribble/hextrick.conf --no-daemon &!
    else
        pkill mpdscribble
        systemctl --user start mpdscribble
    fi
    echo $(_zpref) $(_zfwrap "$(any mpdscribble | awk  '{print substr($0, index($0,$11))}'|
                                sed "s|${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")")
    unset is_run
}

function clock(){
    while sleep 1; do 
        tput sc
        tput cup 0 $(($(tput cols)-29))
        date
        tput rc
    done &
}

function soneeded() { readelf -d $1 | awk '/NEEDED/ {gsub(/[\[\]]/, "", $5); print $5}' }

function mdel(){
    pattern="$1"
    mpc --format "%position% %artist% %album% %title%" playlist \
        | grep -iP $pattern \
        | awk '{print $1}'  \
        | mpc del
}

function mkeep(){
    pattern="$1"
    mpc --format "%position% %artist% %album% %title%" playlist \
        | ${BIN_HOME}/scripts/negrep ${pattern} \
        | awk '{print $1}'  \
        | mpc del
}

function pid2xid(){ wmctrl -lp | awk "\$3 == $(pgrep $1) {print \$1}" }

# Change to repository root (starting in parent directory), using the first
# entry of a recursive globbing.
function RR() {
  setopt localoptions extendedglob
  local a
  # note: removed extraneous / ?!
  a=( (../)#.(git|hg|svn|bzr)(:h) )
  if (( $#a )); then
    cd $a[1]
  fi
}

function adbpush() {
  for i; do
    echo "[>>] -> Pushing ${i} to /sdcard/${i:t}"
    adb push ${i} /sdcard/${i:t}
  done
}

function toxrdb(){
    local cpt=0
    while read hexcode; do
        printf '*color%d: %s\n' "$cpt" "$hexcode"
        cpt=$(expr $CPT + 1)
    done | column -t
}

function count_music_trash(){
    find ~/music/ -regextype posix-egrep \
        -regex ".*\.(jpg|png|gif|jpeg|tif|tiff|m3u|log|pdf)$" -exec du -sch {} +
}

function consn() { 
    echo :: consnumber :: 
    netstat -nat |awk '{print $6}'|sort|uniq -c|sort -rn
    echo :: consip ::
    netstat -ntu | tail -n +3 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n 
}
# gather external ip address
function geteip() { curl http://ifconfig.me }
# Clear zombie processes
function clrz() { ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9 }

function suscp() {
    for arg in "$@"; do
        case "$arg" in
            [!-]*:*) ssh -axqt "$(echo $arg|sed -e 's/:.*//')" sudo -v -p "\"%u@%h's sudo password:\"" || exit ;;
        esac
    done
    args=-P
    [ "$basename" = suscp ] && args=-P
    sudo -p "%u@%h's sudo password:" rsync $args -e "ssh -axtF $HOME/.ssh/config -i $HOME/.ssh/id_rsa" --rsync-path="sudo rsync" "$@"
}

_echo() {
    if [ "X$1" = "X-n" ]; then
        shift
        printf "%s" "$*"
    else
        printf "%s\n" "$*"
    fi
}

spark() {
    local n numbers=

    # find min/max values
    local min=0xffffffff max=0

    for n in ${@//,/ }; do
        # on Linux (or with bash4) we could use `printf %.0f $n` here to
        # round the number but that doesn't work on OS X (bash3) nor does
        # `awk '{printf "%.0f",$1}' <<< $n` work, so just cut it off
        n=${n%.*}
        (( n < min )) && min=$n
        (( n > max )) && max=$n
        numbers=$numbers${numbers:+ }$n
    done
    local ticks=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █) # print ticks
    local f=$(( (($max-$min)<<8)/(${#ticks[@]}-1) ))
    (( f < 1 )) && f=1

    for n in $numbers; do
        _echo -n ${ticks[$(( ((($n-$min)<<8)/$f) ))]}
    done
    _echo
}

function sp() {
    setopt extendedglob bareglobqual
    du -sch -- ${~^@:-"*"}(D) | sort -h
}

function resolve_file {
    if [[ -f "$1" ]]; then
        echo $(readlink -f "$1")
    elif [[ "${1#/}" == "$1" ]]; then
        echo "$(pwd)/$1"
    else
        echo $1
    fi
}

function ta {
    local tmp_list=/tmp/torr_list_$$
    local torrent_dir=${HOME}/torrent
    local torrent_handler=transmission-remote-cli
    for i in $@; echo $i >> ${tmp_list}
        while read line; do
            local file_name="$(resolve_file ${line})"
            local base_name="$(basename ${file_name})"
            command mv ${file_name} ${torrent_dir}/${base_name} && \
            ${torrent_handler} ${torrent_dir}/${base_name} > /dev/null &&
            echo "$(_zpref) -> $fg[white] ${base_name} $fg[blue]added $fg[green]"
        done < ${tmp_list}
    rm ${tmp_list}
    unset file_name tmp_list
}

function w7run {
    qemu-system-x86_64 \
    -m 4096 \
    -enable-kvm \
    -cpu host \
    -machine type=pc,accel=kvm \
    -net nic -net user,smb=/mnt/qemu \
    -drive file=~/1st_level/vm/w7.qcow2 \
    -vga qxl -spice port=5900,addr=127.0.0.1,disable-ticketing \
    -device virtio-serial-pci \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -chardev spicevmc,id=spicechannel0,name=vdagent \
    -qmp unix:${HOME}/1st_level/qmp.socket,server --monitor stdio \
    -boot d
    ${BIN_HOME}/scripts/qmp/qmp-shell ${HOME}/1st_level/qmp.socket
}


if [ -z "\${which tree}" ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

# Delete 0 byte file
d0() { find "$(retval $1)" -type f -size 0 -exec rm -rf {} \; }

function g() {
    if [[ $# > 0 ]]; then
        git $@
    else
        git status
    fi
}

function sls(){
    steamcmd '+apps_installed +quit' |\
        awk '/AppID/ {
                id = $2;
                name = substr($0, index($0, " : ") + 3);
                sub(" : .*", "", name);
                print id ": " name;
            }'
}

function record(){
    local rpath
    test -n "$2" && rpath=$2 || rpath=$1

    PIDNAME=recorder
    FRAMERATE=25
    RESOLUTION=$(wattr wh $(lsw -r) | tr \  x)
    AREA=":0.0"

    case $1 in
        f) FRAMERATE=50; shift 1 ;;
        k) kill $(pidof -s $PIDNAME); exit 0 ;;
        s) 
            eval $(slop -t 2 -b $BW '215,215,215,0.9')
            RESOLUTION=$(echo $W x $H | sed 's# ##g')
            AREA=$(echo "$AREA+$X,$Y")
            ;;
        p|pfw) 
            W=$(wattr w $(pfw))
            H=$(wattr h $(pfw))
            X=$(wattr x $(pfw))
            Y=$(wattr y $(pfw))
            RESOLUTION=$(echo $W x $H | sed 's# ##g')
            AREA=$(echo "$AREA+$X,$Y")
    esac

    ffmpeg -f x11grab -s ${RESOLUTION} -an -r ${FRAMERATE} -i ${AREA} -c:v libvpx \
    -b:v 10M -crf 10 -quality realtime -y -loglevel quiet ${rpath}.webm
}

# shameless stolen from http://ft.bewatermyfriend.org/comp/data/zsh/zfunct.html
# MISC: zurl() create small urls via tinyurl.com needs wget, grep and sed. yes, it's a hack ;)
function zurl() {
    [[ -z ${1} ]] && print "please give an url to shrink." && return 1
        local url=${1}
        local tiny="http://tinyurl.com/create.php?url="
        # print "${tiny}${url}" ; return
        wget -O- -o /dev/null "${tiny}${url}"|grep -Eio "copy\('http://tinyurl.com/.*'"|grep -o "http://.*"|sed s/\'//
}
