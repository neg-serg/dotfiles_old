(){
    local p=$(cope_path)
    for i in `\ls $p -1|sed 's/*$//'`; alias $i=\"$p/$i\"
    alias df="$p/df -h"
}

alias '?=bc -l <<<'
# alias gvim="STTY='intr \^C' gvim" # C-x mapping fucks up gvim
alias stderred="LD_PRELOAD=/home/neg/bin/lib/libstderred.so${LD_PRELOAD:+:\$LD_PRELOAD}"
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'
alias eix='noglob eix'
alias	mmv='noglob mmv'
alias "zmv=noglob zmv -v"
alias	wget='noglob wget'
alias	clive='noglob clive'
alias	clivescan='noglob clivescan'
alias	'youtube-dl'='noglob youtube-dl'
alias	translate='noglob translate'
alias	links='noglob links'
alias	links2='noglob links2'
alias	xlinks2='noglob xlinks2'
alias	lynx='noglob lynx'
alias fevil='find . -regextype posix-extended -regex'
alias sp='du -shc ./* | sort -h'

if [[ $UID != 0 ]]
then
    if [ -f "$HOME/.ssh/config" ]
    then
    for host in $(
        perl -ne 'print "$1\n" if /\A[Hh]ost\s+(.+)$/' $HOME/.ssh/config
        ); do
    alias $host="ssh $host '$@'"
        done
    fi

    alias cclive='cclive --config-file $XDG_CONFIG_HOME/ccliverc -f best'
    alias bigloo='rlwrap bigloo'
    alias clisp=' rlwrap clisp'
    alias irb=' rlwrap irb-1.8'
fi
# alias vpad="vim +set\ buftype=nofile +startinsert"
alias lss='ls -sShr'
alias ls="ls --color=auto"   # do we have GNU ls with color-support?
alias primusrun="vblank_mode=0 primusrun"

alias gps='ps -eo cmd,fname,pid,pcpu,time --sort=-pcpu | head -n 11 && echo && ps -eo cmd,fname,pid,pmem,rss --sort=-rss | head -n 9'

# see http://www.cl.cam.ac.uk/~mgk25/unicode.html#term for details
alias term2iso="echo 'Setting terminal to iso mode' ; print -n '\e%@'"
alias term2utf="echo 'Setting terminal to utf-8 mode'; print -n '\e%G'"

alias magnet2torrent="aria2c -q --bt-metadata-only --bt-save-metadata"

# my new aliases
alias mk="mkdir -p"
alias mp="mpv"
alias mpa="mpv -fs -ao null"
alias mpr="~/bin/mpv.rb" 
alias i="ipython"
alias grep="grep --color=auto"
#vim aliases
alias v='gvim --remote-silent'
alias vim='gvim --remote-silent'
alias vi='gvim --remote-silent'
alias vz="v ~/.zshrc"
# alias vv="v ~/.vimrc"
# alias vw="(cd ~/.notion; v cfg_notion.lua)"
#alias vi="~/bin/v"
#alias v="~/bin/v"
alias D0='DISPLAY=":0"'
alias D1='DISPLAY=":1"'
alias m="sudo mount"
alias u="sudo umount"
#alias z="urxvtc -e"
alias s="sudo"
alias l="ls++"
#alias e="okular"
alias e="zathura"
alias rd="rmdir"
alias la="l -a"

# aliases

# general
#a2# Execute \kbd{du -sch}
#alias da='du -sch'
#a2# Execute \kbd{jobs -l}
alias j='jobs -l'

# alias ls='ls++'
# alias sl='ls++'
alias sl='ls'
alias lad='ls -d .*(/)'                # only show dot-directories
alias lsd='ls -d *(/)'                 
# some useful aliases
#a2# Remove current empty directory. Execute \kbd{cd ..; rmdir $OLDCWD}
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'

#a2# ssh with StrictHostKeyChecking=no \\&\quad and UserKnownHostsFile unset
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias insecscp='scp -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'

# simple webserver
check_com -c python && alias http="python -m SimpleHTTPServer"
alias ple='perl -wlne'

alias "ftp=lftp"
alias "now=date +'[%H:%M] %A %e %B %G'"
alias "mv=mv -vi"
alias "mvv=\mv"
#alias "ls=ls++ -XA"
#alias "du=du -chL"
#alias "cdu=cdu -si -dh"
#alias "du=cdu -si -dh"

alias "mount=sudo mount"
alias "umount=sudo umount"
alias "skillall=sudo killall"
alias "skill=sudo kill"
alias "chmod=sudo chmod"
alias "chown=sudo chown"
alias "reboot=sudo reboot"
alias "halt=sudo halt"
alias "lsm=cat /proc/mounts"
alias "ifconfig=sudo ifconfig"
alias "ip=sudo ip"
alias "apt-get=sudo apt-get"

alias "dpkg=sudo dpkg"
alias "ifup=sudo ifup"
alias "ifdown=sudo ifdown"
alias "smbclient=sudo smbclient"

alias "tree=tree --dirsfirst -C"

#alias "see=~/bin/see"
alias "acpi=acpi -V"
alias "youtube-dl=tsocks youtube-dl"
#alias "mutt=tsocks mutt"
#alias "sv=sudo ~/bin/v"
alias "vncviewer=vncviewer -passwd ~/.vnc/passwd"
alias se=simple-extract

alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
alias    mgcc='gcc -ansi -pedantic -Wextra -Wempty-body -Wfloat-equal -Wignored-qualifiers -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wold-style-declaration -Woverride-init -Wsign-compare -Wstrict-prototypes -Wtype-limits -Wuninitialized -fstack-protector-all -D_FORTIFY_SOURCE=2'
alias   mgccc='gcc -ansi -pedantic -Wall'
alias csyntax='gcc -fsyntax-only'

alias     gs='git status --short -b'
alias     gt='git tag|sort --reverse'
alias     gp='git push'
alias    gdd='git diff'
alias     gc='git commit'
alias    glp='gl -p'
alias    gcu='git commit -m "updates"'
#alias     gd='PAGER="" git diff $ | skate --language diff -'A
alias       R='rehash'

alias       :q='exit'

alias   iostat='iostat -mtx'
alias     cpuu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias memusage='ps -e -orss=,args= | sort -b -k1,1n|pr -TW$COLUMNS' 
alias yt="youtube-dl -c -t -f best --no-part"

# generate alias named "$KERNELVERSION-reboot" so you can use boot with kexec:
if [[ -x /sbin/kexec ]] && [[ -r /proc/cmdline ]] ; then
    alias "$(uname -r)-reboot"="kexec -l --initrd=/boot/initrd.img-"$(uname -r)" --command-line=\"$(cat /proc/cmdline)\" /boot/vmlinuz-"$(uname -r)""
fi
# alias asdf='setxkbmap -keycodes xfree86+mikachu+labtec -compat complete+mikachu -symbols se_dvorak -types complete+mikachu'
alias qe='cd *(/om[1])'
alias hi='_v'

alias wine="LANG=ru_RU.utf-8 wine"
#-----------[fasd]---------------
alias a='fasd -a'
# alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'

alias ym='~/bin/scripts/yandex.mount > /dev/null'
alias ftpfs='curlftpfs -o codepage=cp1251 ftp://192.168.1.1 /media/ftp'
alias td='[ -z $(pidof transmission-daemon) ] && transmission-daemon'
