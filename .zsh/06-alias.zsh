(){
    if [[ -x `which cope_path 2> /dev/null` ]]; then
        local p=$(cope_path)
        for i in `\ls $p -1|sed 's/*$//'`; alias $i=\"$p/$i\"
        alias df="$p/df -hT"
    else
        alias df="df -hT"
    fi
}
alias pstree="pstree -U "$@" | sed '
	s/[-a-zA-Z]\+/\x1B[32m&\x1B[0m/g
	s/[{}]/\x1B[31m&\x1B[0m/g
	s/[─┬─├─└│]/\x1B[34m&\x1B[0m/g'"

alias '?=bc -l <<<'
alias stderred="LD_PRELOAD=${HOME}/bin/lib/libstderred.so${LD_PRELOAD:+:\$LD_PRELOAD}"

# If noglob (for zsh) is not available, just make it a noop
if ! type noglob >/dev/null 2>&1; then
    alias noglob=''
fi
NOGLOB_LIST=( \
    fc find ftp sftp lftp history locate rake rsync scp \
    eix mmv wget clive clivescan youtube-dl \
    translate links links2 xlinks2 lynx \
    you-get bower
)
for i in ${NOGLOB_LIST[@]}; alias ${i}="noglob ${i}";

alias "zmv=noglob zmv -v"
alias fevil='find . -regextype posix-extended -regex'

function sp() {
  setopt extendedglob bareglobqual
  du -sch -- ${~^@:-"*"}(D) | sort -h
}
alias sp='noglob sp'
alias cdu=cdu -idh

if [[ $UID != 0 ]]; then
    if [ -f "$HOME/.ssh/config" ]; then
        for host in $( perl -ne 'print "$1\n" if /\A[Hh]ost\s+(.+)$/' ${HOME}/.ssh/config);
            alias $host="ssh $host '$@'";
    fi
    alias bigloo='rlwrap bigloo'
    alias clisp= 'rlwrap clisp'
    alias irb=   'rlwrap irb-1.8'
fi

alias ls="ls --color=auto"   # do we have GNU ls with color-support?
if [[ ! -x "${HOME}/bin/l" ]]; then
    if  [[ -x "${HOME}/bin/lsp" ]]; then
        alias l="lsp"
        if [[ -x "/usr/bin/vendor_perl/ls++" ]]; then 
            alias l="ls++"; 
        else 
            alias l="ls -aChkopl --group-directories-first --color=auto";
        fi
    fi
fi
alias l.='ls -d .*'

alias primusrun="vblank_mode=0 primusrun"
alias gps='ps -eo cmd,fname,pid,pcpu,time --sort=-pcpu | head -n 11 && echo && ps -eo cmd,fname,pid,pmem,rss --sort=-rss | head -n 9'
# see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term for details
alias term2iso="echo 'Setting terminal to iso mode' ; print -n '\e%@'"
alias term2utf="echo 'Setting terminal to utf-8 mode'; print -n '\e%G'"

alias magnet2torrent="aria2c -q --bt-metadata-only --bt-save-metadata"

alias mk="mkdir -p"
alias mp="mpv"
alias mpa="mpv -fs -ao null"
alias mpl="mplayer -ao pulse -vo gl_nosw -really-quiet -double -cache 500 -cache-min 3 -framedrop -utf8  -autoq 100 -bpp 32 -subfont PragmataPro"
alias grep="grep --color=auto"

alias mutt="dtach -A ${HOME}/.mutt/mutt.session mutt"

alias u="sudo umount"
alias s="sudo"
alias e="open"
alias rd="rmdir"

alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

alias ple='perl -wlne'

alias "ftp=lftp"
alias "now=date +'[%H:%M] %A %e %B %G'"
alias "mv=mv -vi"
alias "mvv=\mv"

sudo_list=( \
    mount umount chmod chown
)
for i in ${sudo_list[@]}; alias ${i}="sudo ${i}";

if [[ -x /usr/bin/systemctl ]]; then
    alias reboot="sudo systemctl reboot"
    alias poweroff="sudo systemctl poweroff"
    alias halt="sudo systemctl halt"
else
    alias "reboot=sudo reboot"
    alias "halt=sudo halt"
    alias "poweroff=sudo poweroff"
fi

alias tree="tree --dirsfirst -C"
alias acpi="acpi -V"
alias se=extract
alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'

alias gs='git status --short -b'
alias gt='git tag|sort --reverse'
alias gp='git push'
alias gdd='git diff'
alias gc='git commit'
alias glp='gl -p'
alias gcu='git commit -m "updates"'

alias :q='exit'

alias iostat='iostat -mtx'
alias cpuu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias memusage='ps -e -orss=,args= | sort -b -k1,1n|pr -TW$COLUMNS' 
# alias yt="tsocks youtube-dl  -o '%(autonumber)s_%(title)s.%(ext)s' -c -t -f best --no-part --restrict-filenames 'url'"
# alias yt='cert exec -f ~/.certificates/google.com.crt -- youtube-dl --user-agent Mozilla/5.0'; TCOMP youtube-dl yt
alias yt="tsocks you-get"
alias yr="tsocks youtube-viewer --video-player=mpv -C"

alias qe='cd *(/om[1])'
alias hi='_v'

alias wine="LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"

alias ym="${HOME}/bin/scripts/yandex.mount > /dev/null"
alias td='[ -z $(pidof transmission-daemon) ] && transmission-daemon'

alias awk="$(whence gawk || whence awk)"
alias history='history 0'
alias sniff='sudo ngrep -d "enp6s0" -t "^(GET|POST) " "tcp and port 80"'

alias wd="${HOME}/bin/wd.sh"

alias pastebinit='pastebinit -a "Neg" -b "http://paste2.org" -t "Neg is here"'

alias objdump='objdump -M intel -d'
alias glog="git log --graph --pretty=format:'%Cgreen%h%Creset -%C(yellow)%d%Creset %s %Cred(%cr)%Creset%C(yellow)<%an>'"
alias memgrind='valgrind --tool=memcheck "$@" --leak-check=full'

alias cal='~/bin/scripts/dzen-time-date'
alias lk="[[ -x `which glances`  ]] && glances"

function resolve_file {
  if [ -f "$1" ]; then
    echo $(readlink -f "$1")
  elif [[ "${1#/}" == "$1" ]]; then
    echo "$(pwd)/$1"
  else
    echo $1
  fi
}

function ta {
    tmp_list=/tmp/torr_list
    sleep .2s
    for i in $@; echo $i >> $tmp_list
        while read line; do
            file_name="$(resolve_file $line)"
            base_name="$(basename $file_name)"
            \mv $file_name ~/torrent/$base_name && \
            transmission-remote-cli ~/torrent/$base_name > /dev/null &&
                echo "$fg[blue][$fg[white]>>$fg[blue]] -> $fg[white] $base_name $fg[blue]added $fg[green]"
        done < $tmp_list
    rm $tmp_list
    file_name=
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
    # ${HOME}/bin/scripts/qmp/qmp-shell ${HOME}/1st_level/qmp.socket
}

user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment)

sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment)

for c in $user_commands; do; alias sc-$c="systemctl $c"; done
for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done

if [ -z "\${which tree}" ]; then
  tree () {
      find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

# Delete 0 byte file
d0() { find "$(retval $1)" -type f -size 0 -exec rm -rf {} \; }

alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

alias google='web_search google'

function sls(){
    steamcmd '+apps_installed +quit' |\
        awk '/AppID/ {
                id = $2;
                name = substr($0, index($0, " : ") + 3);
                sub(" : .*", "", name);
                print id ": " name;
            }'
}

# URL Tools
# Adds handy command line aliases useful for dealing with URLs
#
# Taken from:
# http://ruslanspivak.com/2010/06/02/urlencode-and-urldecode-from-a-command-line/

if [[ $(whence $URLTOOLS_METHOD) = "" ]]; then
    URLTOOLS_METHOD=""
fi

if [[ $(whence node) != "" && ( "x$URLTOOLS_METHOD" = "x"  || "x$URLTOOLS_METHOD" = "xnode" ) ]]; then
    alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
    alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
elif [[ $(whence python) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xpython" ) ]]; then
    alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
    alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
elif [[ $(whence xxd) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xshell" ) ]]; then
    function urlencode() {echo $@ | tr -d "\n" | xxd -plain | sed "s/\(..\)/%\1/g"}
    function urldecode() {printf $(echo -n $@ | sed 's/\\/\\\\/g;s/\(%\)\([0-9a-fA-F][0-9a-fA-F]\)/\\x\2/g')"\n"}
elif [[ $(whence ruby) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xruby" ) ]]; then
    alias urlencode='ruby -r cgi -e "puts CGI.escape(ARGV[0])"'
    alias urldecode='ruby -r cgi -e "puts CGI.unescape(ARGV[0])"'
elif [[ $(whence php) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xphp" ) ]]; then
    alias urlencode='php -r "echo rawurlencode(\$argv[1]); echo \"\n\";"'
    alias urldecode='php -r "echo rawurldecode(\$argv[1]); echo \"\\n\";"'
elif [[ $(whence perl) != "" && ( "x$URLTOOLS_METHOD" = "x" || "x$URLTOOLS_METHOD" = "xperl" ) ]]; then
    if perl -MURI::Encode -e 1&> /dev/null; then
        alias urlencode='perl -MURI::Encode -ep "uri_encode($ARGV[0]);"'
        alias urldecode='perl -MURI::Encode -ep "uri_decode($ARGV[0]);"'
    elif perl -MURI::Escape -e 1 &> /dev/null; then
        alias urlencode='perl -MURI::Escape -ep "uri_escape($ARGV[0]);"'
        alias urldecode='perl -MURI::Escape -ep "uri_unescape($ARGV[0]);"'
    else
        alias urlencode="perl -e '\$new=\$ARGV[0]; \$new =~ s/([^A-Za-z0-9])/sprintf(\"%%%02X\", ord(\$1))/seg; print \"\$new\n\";'"
        alias urldecode="perl -e '\$new=\$ARGV[0]; \$new =~ s/\%([A-Fa-f0-9]{2})/pack(\"C\", hex(\$1))/seg; print \"\$new\n\";'"
    fi
fi

unset URLTOOLS_METHOD

setopt extendedglob
setopt interactivecomments
declare -A abk
abk=(
    'A'    '|& ack -i '
    'G'    '|& grep -i '
    'C'    '| wc -l'
    'H'    '| head'
    'T'    '| tail'
    'N'    '&>/dev/null'
    'S'    '| sort -h '
    'W'    '|& ls_color'
    'V'    '|& vim -'
    "jj"   "!$"
    "jk"   "!-2$"
    "jjk"  "!-3$"
    "jkk"  "!-4$"
    "kk"   "!-5$"
    "kj"   "!-6$"
)

zleiab() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}

zle -N zleiab
