#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort type
zstyle ':completion:*:processes-names' command 'ps xho command'
 
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

 # offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters


 # Filename suffixes to ignore during completion (except after rm command)
  zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~'  '*?.old' '*?.pro'
 # formatting and messages
 zstyle ':completion:*' verbose yes
 zstyle ':completion:*:descriptions' format '%B%d%b'
 zstyle ':completion:*:messages' format '%d'
 zstyle ':completion:*:warnings' format 'No matches for: %d'
 zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
 zstyle ':completion:*' group-name ''

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' menu yes select
zstyle ':completion::complete:*' use-cache 1

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
#zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
#zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'

# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

#zstyle ':completion:*:history-words' stop yes
#zstyle ':completion:*:history-words' remove-all-dups yes
#zstyle ':completion:*:history-words' list false
#zstyle ':completion:*:history-words' menu yes


# Read in local overrides
if [ -f ${ZSHROOT_HOSTSPEC}/zcompletion ]; then
  source ${ZSHROOT_HOSTSPEC}/zcompletion
fi

#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#zstyle ':completion:*:processes' command 'ps -xuf'
#zstyle ':completion:*:processes-names' command 'ps xho command'

zstyle ':completion:*' sort type
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*:cd:*' ignore-parents parent pwd
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:hosts' use-ip 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # ignore case

#zstyle ':completion:*:default' list-colors '~/.dir_colors'
#zstyle ':completion:*' old-menu false
#zstyle ':completion:*' original true
#zstyle ':completion:*' substitute 1
#zstyle ':completion:*' use-compctl true
#zstyle ':completion:*' verbose true
#zstyle ':completion:*' word true
# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
# Completion for zsh

bindkey -e
zle -C complete complete-word complete-files
bindkey '^X\t' complete

complete-files () { compadd - * }

# Set up command completions
compctl -A shift
compctl -a {,un}alias
#compctl -/ {c,push,pop}d
compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd popd rmdir dircmp
compctl -c exec
compctl -c man
compctl -caF type whence which where
compctl -c -x 'C[-1,-*k]' -A - 'C[-1,-*K]' -F -- compctl
compctl -c unhash
compctl -x 'w[1,-d] p[2]' -n - 'w[1,-d] p[3]' -g '*(-/)' - \
  'p[1]' -c - 'p[2]' -g '*(-x)' -- hash
compctl -x 'C[-1,-*e]' -c - 'C[-1,-[ARWI]##]' -f -- fc
compctl -x 'p[1]' - 'p[2,-1]' -l '' -- sched
compctl -x 'C[-1,[+-]o]' -o - 'c[-1,-A]' -A -- set
compctl -F functions unfunction
compctl -o {,un}setopt
compctl -E {,un}setenv
compctl -E printenv
compctl -b bindkey
compctl -b -x 'w[1,-N] p[3]' -F -- zle
compctl -z -P '%' bg
compctl -j -P '%' fg jobs disown
compctl -j kill
compctl -j -P '%' + -s '`ps -ax | tail +2 | cut -c1-5`' wait
compctl -u chown
compctl -v getln getopts read unset vared
compctl -v -S '=' -q declare export integer local readonly typeset
compctl -eB -x 'p[1] s[-]' -k '(a f m r)' - \
  'C[1,-*a*]' -ea - 'C[1,-*f*]' -eF - 'C[-1,-*r*]' -ew -- disable
compctl -dB -x 'p[1] s[-]' -k '(a f m r)' - \
  'C[1,-*a*]' -da - 'C[1,-*f*]' -dF - 'C[-1,-*r*]' -dw -- enable
compctl -k "(`limit | cut -d' ' -f1`)" limit unlimit
compctl -l '' -x 'p[1]' -f -- . source
compctl -s '${^module_path}/*(N:t:r)' -x \
  'W[1,-*(a*u|u*a)*],W[1,-*a*]p[3,-1]' -B - \
  'W[1,-*u*]' -s '$(zmodload)' -- zmodload
compctl -s '$(setopt 2>/dev/null)' + -o + -x 's[no]' -o -- unsetopt
compctl -s '$(unsetopt 2>/dev/null)' + -o + -x 's[no]' -o -- setopt
compctl -s '${^fpath}/*(N:t)' autoload

# Anything after nohup is a command by itself with its own completion
compctl -l '' nohup noglob exec nice eval - time rusage
compctl -l '' -x 'p[1]' -eB -- builtin
compctl -l '' -x 'p[1]' -em -- command
compctl -x 'p[1]' -c - 'p[2,-1]' -k signals -- trap

# Autocomplete for current dir on filetypes
compctl -g '*.Z *.gz *.tgz' + -g '*' zcat zless zgrep zcmp gunzip gzip
compctl -g '*.bz2' + -g '*' bzip2
compctl -g '*.tar.Z *.tar.gz *.tgz *.tar.bz2' + -g '*' tar
compctl -g '*.zip *.ZIP' + -g '*' unzip zip
compctl -g '*(-/) *.pl *.PL *.cgi *.pm *.PM *.t *.xpl' perl miniperl
compctl -g '*(-/) *.pl *.PL *.pm *.PM *.pod' -K _perl_inc perldoc pod
compctl -g '*(-/) *.rb' ruby
compctl -g '*(-/) *.py *.pyc' python
compctl -g '*(-/) *.c' lint

# autocomplete hosts
hosts=(	hostname )
compctl -k hosts telnet scp ssh sftp ftp ping

# Completions for misc commands

#!# screen
compctl -Q -S '' -k '( if= of= bs= skip= count= )' \
  -x 'S[(if|of)=]' -f \
  -  's[bs=]' -k '( 256 512 1024 2048 4096 8192 16384 32768 65535 )' \
  -- dd
listscreens () {
  reply=(`screen -ls | grep 'tached' | sed -e 's/	//' | sed -e 's/	.*//'`)
}
compctl -K listscreens screen

#!# mount
mounttab () { reply=( ` egrep "^/.*" /etc/fstab | awk '{print $1}' ` ) }
compctl -K mounttab mount
#!# smb
smbtab () { reply=( `find $smb -maxdepth 2 | sed 's/\/mnt\/smb/\//g'` ) }
compctl -K smbtab smb
#!# umount
umounttab () { reply=( `mount | cut -d' ' -f3`) }
compctl -K //umounttab umount

#!# ssh slogin sftp scp
remote_files () {
  local a
  read -cA a
  reply=(`ssh ${a[-1]%%:*} "echo ${a[-1]#*:]*/(/N) ${a[-1]#*:}*(.N)"`)
}
sshhosts () {
  reply=(`cut -d' ' -f1 ~/.ssh/known_hosts | cut -d, -f1`)
}
compctl -K sshhosts -k hosts -x 'c[-1,-1]' -u -- ssh slogin sftp
compctl \
  -k sshhosts -S ':' \
  -g '*(-/) *' -S ' ' \
  -u -S '@' \
  -x 'n[-1,@]' -K sshhosts -S ':' \
  - 's[-]' -k '(a A q Q p r v B C L S o P c i)' \
  - 'c[-1,-S]' -X '' -f \
  - 'c[-1,-l]' -u \
  - 'c[-1,-o]' -X '' \
  - 'c[-1,-P]' -X '' \
  - 'c[-1,-c]' -X '' -k '(idea blowfish des 3des arcfour tss none)' \
  - 'c[-1,-i]' -X '' -f \
  - 'n[-1,:]' -S '' -K remote_files \
  - 'C[0,[./]*] ' -f  \
  -g '*(-/) *' -S ' ' -- scp

#!# man whatis apropos
man_glob () {
  local a
  read -cA a
  case $a[2] in
    1|2|3|4|5|6|7|8|9)
      reply=(${^manpath}/man$a[2]/$1*$2(N:t:fr))
      ;;
    *)
      reply=(${^manpath}/man*/$1*$2(N:t:fr))
      ;;
  esac
}
compctl -K man_glob man whatis apropos

#!# make
makeentry () {
  local a
  local mfile
  read -cA a
  mfile=(GNUmakefile makefile Makefile)
  while [ ! -z $a[0] ]; do
    shift a
    case $a[0] in
      -f)	shift a;
        mfile=$(a[0])
        ;;
    esac
  done
  while [ ! -z "$mfile[0]" ]; do
    if [ -f $mfile[0] ]; then
      reply=(`egrep '^[^#. ][^=       ]*:' $mfile[0] | cut -d: -f1`)
      break
    else
      shift mfile
    fi
  done
}
compctl -K makeentry -x 'c[-1,-f]' -f -- make

#!# kill
compctl -j -P '%' + -s '`ps ax | tail +2 | cut -c1-5`' + \
  -x 's[-] p[1]' -k "($signals[1,-3])" -- kill

#!# chgrp
listgroups=(`egrep '^#.*' /etc/group | cut -d: -f1`)
compctl -f -x 'p[1] n[-1,:], p[2] C[-1,-*] n[-1,:]' -k listgroups \
  - 'p[1], p[2] C[-1,-*]' -u -- chgrp

#!# chown
compctl -f -x 'p[1] n[-1,:], p[2] C[-1,-*] n[-1,:]' -k listgroups \
  - 'p[1], p[2] C[-1,-*]' -u -S ':' -- chown

#!# su
compctl -u -x 'w[2,-c] p[3,-1]' -l '' -- su

#!# openssl
compctl -k '(asn1parse ca ciphers crl crl2pkcs7 dgst dh dhparam dsa dsaparam \
  enc errstr gendh gendsa genrsa nseq passwd pkcs12 pkcs7 pkcs8 \
  rand req rsa rsautl s_client s_server s_time sess_id smime speed \
  spkac verify version x509)' openssl

#!# host
compctl -K sshhosts -x 's[-t]' \
  -k '(A AAAA CNAME HINFO MINFO MX NS PTR SOA TXT UINFO WKS)' \
  -- host

#!# nslookup
compctl -K sshhosts -x 's[-type=]' \
  -k '(A AAAA CNAME HINFO MINFO MX NS PTR SOA TXT UINFO WKS)' \
  -- nslookup

#!# Apache
compctl -k '(configtest fullstatus help graceful restart start startssl status stop)' apachectl

#!# ISC BIND
compctl -k '(reload refresh stats querylog dumpdb stop halt)' ndc rndc

#!# MySQL
compctl -x 'c[-1,-u]' -u -- mysql mysql4
compctl -k '(create drop extended-status flush-hosts flush-logs flush-tables \
  flush-privileges kill password ping processlist reload refresh \
  shutdown status variables version)' mysqladmin myadmin mysqladmin4

#!# id finger passwd
compctl -u id finger passwd

#!# sudo
compctl -m sudo

# OS-specific completions
case `uname` in
  FreeBSD)
#!# kldload kldunload
    kern_modules () {
      __filelist=(`sysctl kern.module_path | awk '{print $2}' | sed -e 's%;%%g'`)
      reply=(`/bin/ls -1 $__filelist`)
    }
    compctl -K kern_modules kldload kldunload
#!# rmuser
    compctl -u rmuser

#!# sysctl
    listsysctls () { set -A reply $(sysctl -AN ${1%.}) }
    compctl -K listsysctls sysctl
    ;;
  Darwin)
    unfunction mounttab umounttab
#!# sysctl
    listsysctls () {
      reply=(`sysctl -a | egrep -v '^[\s\t\<]' | egrep '^.+: ' | cut -d: -f1`)
    }
    compctl -K listsysctls sysctl
    ;;
  *)
    ;;
esac

