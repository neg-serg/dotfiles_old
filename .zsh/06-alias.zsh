(){
    if [[ -x `which cope_path 2> /dev/null` ]]; then
        local p=$(cope_path)
        for i in `\ls $p -1|sed 's/*$//'`; alias $i=\"$p/$i\"
        alias df="$p/df -hT"
    else
        alias df="df -hT"
    fi
}

alias '?=bc -l <<<'
alias stderred="LD_PRELOAD=/home/neg/bin/lib/libstderred.so${LD_PRELOAD:+:\$LD_PRELOAD}"

NOGLOB_LIST=( fc find ftp history locate rake rsync scp sftp eix mmv wget clive clivescan youtube-dl \
    translate links links2 xlinks2 lynx)
for i in ${NOGLOB_LIST[@]}; alias ${i}="noglob ${i}";

alias "zmv=noglob zmv -v"

alias fevil='find . -regextype posix-extended -regex'

alias sp='du -shc ./* | sort -h'
alias cdu=cdu -idh

if [[ $UID != 0 ]]
then
    if [ -f "$HOME/.ssh/config" ]; then
        for host in $( perl -ne 'print "$1\n" if /\A[Hh]ost\s+(.+)$/' ${HOME}/.ssh/config);
            alias $host="ssh $host '$@'";
    fi

    alias cclive='cclive --config-file $XDG_CONFIG_HOME/ccliverc -f best'
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
alias lad='ls -d .*(/)' 
alias lsd='ls -d *(/)'
alias lss='ls -sShr'
alias la="l -a"

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
alias mpl="mplayer -ao pulse -vo gl_nosw -really-quiet -double -cache 500 -cache-min 3 -framedrop -utf8  -autoq 100 -bpp 32 -subfont pragmatapro"
alias mpr="~/bin/mpv.rb" 
alias i="ipython"
alias grep="grep --color=auto"

alias mutt="dtach -A ${HOME}/.mutt/mutt.session mutt"

# -- tmux fix ---------------------------------------
# -- recreate tmux socket if it loss ----------------
# killall -s SIGUSR1 tmux
# tmux attach
# ---------------------------------------------------

function v {
    wid=$(xdotool search --classname wim)
    if [ -z "$wid" ]; then
      urxvtc -fn 'xft:PragmataPro for Powerline:pixelsize=20,xft:dejavu sans mono:size=16:antialias=true' -name 'wim' -e bash -c 'tmux -S /home/neg/1st_level/vim.socket new "vim --servername VIM" && tmux -S /home/neg/1st_level/vim.socket switch-client -t vim' && \
      notionflux -e "app.byinstance('', 'URxvt', 'wim')"
      file_name=`readlink -f "$@"`
      echo vim --servername VIM --remote-silent "$file_name" > /tmp/tmux_run
      sleep .8s
      tmux -S ~/1st_level/vim.socket run "`cat /tmp/tmux_run`"
      filename=
    else  
      notionflux -e "app.byinstance('', 'URxvt', 'wim')"
      file_name=`readlink -f "$@"`
      echo vim --servername VIM --remote-silent "$file_name" > /tmp/tmux_run
      sleep .5s
      tmux -S ~/1st_level/vim.socket run "`cat /tmp/tmux_run`"
      filename=
    fi
}

function remotevim() {
    vim --servername VIM --remote-send "${1}"
    notionflux -e "app.byinstance('', 'URxvt', 'wim')"
}

function vg {
  if [ ! -z $DISPLAY ]; then
    if [ -z $(pidof gvim) ] ; then
      gvim --servername GVIM --remote-silent $@
      sleep .4
      notionflux -e "app.byclass('gvim', 'Gvim')" 
    else  
      notionflux -e "app.byclass('gvim', 'Gvim')" 
      gvim --servername GVIM --remote-silent $@
    fi
  else 
    vim $@
  fi
}

alias vz="v ~/.zshrc"
alias vpad="vim +set\ buftype=nofile +startinsert"

alias D0='DISPLAY=":0"'
alias D1='DISPLAY=":1"'

alias m="sudo mount"
alias u="sudo umount"
alias s="sudo"
alias e="zathura"
alias rd="rmdir"

alias j='jobs -l'

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

alias "mount=sudo mount"
alias "umount=sudo umount"
alias "chmod=sudo chmod"
alias "chown=sudo chown"

if [[ -x /usr/bin/systemctl ]]; then
    alias reboot="sudo systemctl reboot"
    alias poweroff="sudo systemctl poweroff"
    alias halt="sudo systemctl halt"
else
    alias "reboot=sudo reboot"
    alias "halt=sudo halt"
    alias "poweroff=sudo poweroff"
fi

alias "lsm=cat /proc/mounts"

alias "ifconfig=sudo ifconfig"
alias "ip=sudo ip"
alias "ifup=sudo ifup"
alias "ifdown=sudo ifdown"

alias "apt-get=sudo apt-get"
alias "pacman=sudo pacman"
alias "dpkg=sudo dpkg"

alias "smbclient=sudo smbclient"

alias "tree=tree --dirsfirst -C"

alias "acpi=acpi -V"
alias "youtube-dl=tsocks youtube-dl"
alias "vncviewer=vncviewer -passwd ~/.vnc/passwd"
alias se=simple-extract

alias url-quote='autoload -U url-quote-magic ; zle -N self-insert url-quote-magic'
alias mgcc='gcc -ansi -pedantic -Wextra -Wempty-body -Wfloat-equal -Wignored-qualifiers -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wold-style-declaration -Woverride-init -Wsign-compare -Wstrict-prototypes -Wtype-limits -Wuninitialized -fstack-protector-all -D_FORTIFY_SOURCE=2'

alias gs='git status --short -b'
alias gt='git tag|sort --reverse'
alias gp='git push'
alias gdd='git diff'
alias gc='git commit'
alias glp='gl -p'
alias gcu='git commit -m "updates"'

alias R='rehash'
#alias gd='PAGER="" git diff $ | skate --language diff -'A

alias :q='exit'

alias iostat='iostat -mtx'
alias cpuu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias memusage='ps -e -orss=,args= | sort -b -k1,1n|pr -TW$COLUMNS' 
# alias yt="youtube-dl -c -t -f best --no-part"
alias yt="you-get"
alias yr="youtube-viewer --video-player=mpv -C"

# generate alias named "$KERNELVERSION-reboot" so you can use boot with kexec:
if [[ -x /sbin/kexec ]] && [[ -r /proc/cmdline ]] ; then
    alias "$(uname -r)-reboot"="kexec -l --initrd=/boot/initrd.img-"$(uname -r)" --command-line=\"$(cat /proc/cmdline)\" /boot/vmlinuz-"$(uname -r)""
fi
# alias asdf='setxkbmap -keycodes xfree86+mikachu+labtec -compat complete+mikachu -symbols se_dvorak -types complete+mikachu'
alias qe='cd *(/om[1])'
alias hi='_v'

alias wine="LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
#-----------[fasd]---------------
alias a='fasd -a'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'

alias ym='~/bin/scripts/yandex.mount > /dev/null'
alias ftpfs='curlftpfs -o codepage=cp1251 ftp://192.168.1.1 /media/ftp'
alias td='[ -z $(pidof transmission-daemon) ] && transmission-daemon'

alias sdmesg='while true; do sudo dmesg -c; sleep 1; done'

alias -- -='cd -'
alias awk="$(whence gawk || whence awk)"
alias history='history 0'
alias l.='ls -d .*'
alias sniff='sudo ngrep -d "en0" -t "^(GET|POST) " "tcp and port 80"'

alias wd="${HOME}/bin/wd.sh"

# cli pastebin client
alias pastebinit='pastebinit -a "Neg" -b "http://paste2.org" -t "Neg is here"'

alias pbdump='pbpaste | pastebinit | pbcopy'    # dump text to pastebin server

alias objdump='objdump -M intel -d'
alias glog="git log --graph --pretty=format:'%Cgreen%h%Creset -%C(yellow)%d%Creset %s %Cred(%cr)%Creset%C(yellow)<%an>'"
alias memgrind='valgrind --tool=memcheck $@ --leak-check=full'
