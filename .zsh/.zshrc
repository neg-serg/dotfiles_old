. ~/.zsh/01-init.zsh
. ~/.zsh/02-zsh-syntax-highlighting.zsh
. ~/.zsh/03-exports.zsh
. ~/.zsh/04-oldprompt.zsh
. ~/.zsh/05-functions.zsh
. ~/.zsh/06-alias.zsh
. ~/.zsh/07-misc.zsh
. ~/.zsh/09-cb.zsh
. ~/.zsh/10-safe-paste.plugin.zsh
. ~/.zsh/10-hashes.zsh
. ~/.zsh/10-jump.zsh
. ~/.zsh/11-open.zsh
. ~/.zsh/12-completion.zsh
. ~/.zsh/12-vi_additions.zsh
. ~/.zsh/13-bindkeys.zsh
. ~/.zsh/14-dirjumps.zsh
. ~/.zsh/20-rehash-hook.zsh
. ~/.zsh/50-title.zsh
. ~/.zsh/50-vicursor.zsh
# . ~/.zsh/65-fastfile.zsh
. ~/.zsh/72-bracket-paste.zsh
. ~/.zsh/72-return.zsh
. ~/.zsh/74-show_mod.zsh
. ~/.zsh/75-urltools.plugun.zsh    #test it
. ~/.zsh/90-systemadmin.zsh        #test it
. ~/.zsh/90-github.plugin.zsh 
. ~/.zsh/96-vcs_info-cdpath.zsh    #test it
. ~/.zsh/97-sprunge.plugin.zsh
# ------------------------------------------
# . ~/.zsh/99-trash.zsh
# . ~/.zsh/99-experimental.zsh
# ------------------------------------------

# jump to previous directory by integer or reg-exp, also list dirs,
# else jump to last visited directory if no argument supplied:
# NOTE: try to remember to use ZSH directory stack instead... ( cd [-|+]^Tab )
function back {
  if [[ $# == 1 ]]; then
    case $1 {
      <->)  pushd -q +$1 >& - ;;
      --)   dirs -lpv|sed '2s|$| \[last\]|' ;;
      *)    [[ -n $(dirs -lpv|grep -i $1|grep -v ${PWD}) ]] && \
              pushd -q +${$(dirs -lpv|grep -i $1|grep -v ${PWD})[1]}
    }
  else pushd -q - >& - ; fi
}

# go up Nth amount of directories:
function up {
  local arg=${1:-1};
  while [ ${arg} -gt 0 ]; do
    cd .. >& -;
    arg=$((${arg} - 1));
  done
}

# copy and follow file(s) to new dir:
function cpf {
  if [[ -d $*[-1] ]]; then
    cp $* && cd $*[-1]
  elif [[ -d ${*[-1]%/*} ]]; then
    cp $* && cd ${*[-1]%/*}
  fi
}

# function to quickly view StarDict word definitions:
function sd {
  case $1 in
    '-ru') sdcv --utf8-output -u "dictd_www.freedict.de_eng-rus" ${@:/$1} 2>/dev/null ;;
    '-re') sdcv --utf8-output -u "Full Russian-English" ${@:/$1} 2>/dev/null ;;
    '-er') sdcv --utf8-output -u "Full English-Russian" ${@:/$1} 2>/dev/null ;;
    '-t') sdcv --utf8-output -u "English Thesaurus" ${@:/$1} 2>/dev/null ;;
    '-w') sdcv --utf8-output -u "WordNet" -u "English Thesaurus" ${@:/$1} 2>/dev/null ;;
    '-a') sdcv --utf8-output ${@:/$1} 2>/dev/null ;;
    *) sdcv --utf8-output -u "WordNet" ${@} 2>/dev/null ;;
  esac
}

# un-smart function for viewing sectioned partitions:
function dfu() {
  local FSTYPES
  FSTYPES=(nilfs2 btrfs ext2 ext3 ext4 jfs xfs zfs reiserfs reiser4 minix ntfs ntfs-3g fat vfat fuse)
  df -hTP -x rootfs -x devtmpfs -x tmpfs -x none ; print
  df -hTP $(for f in $FSTYPES; { print - " -x $f" })
}

# quickly check/initiate pulseaudio and mifo daemons:
function mpx {
  case $1:l {
    stop|disable)
      print - "stopping : pulseaudio"
      pulseaudio -k
      print - "stopping : mifo"
      mifo --quit
    ;;
    *)
      pulseaudio --check
      if [[ $? != 0 ]] {
        print - "initiate : pulseaudio"
        pulseaudio --start --log-target=syslog --daemonize
      } else { print - "running  : pulseaudio" }
      mifo --instance quiet
      if [[ $? != 0 ]] {
        print - "initiate : mifo"
        mifo --init
      } else { print - "running  : mifo" }
    ;;
};}

# one-liners/micro functions:
function startx { [[ ${+DISPLAY} -eq 1 ]] || /usr/bin/xinit ${XDG_CONFIG_DIR:-${HOME}}/xorg/xinitrc -auth ${XDG_CONFIG_DIR:-${HOME}}/xorg/.serverauth.${RANDOM[1,4]} -nolisten tcp -once -retro }
function dropcache { sync && command su -s /bin/zsh -c 'echo 3 > /proc/sys/vm/drop_caches' root }
function flashproc { for f (${$(file /proc/$(pidof dwb)/fd/*|gawk '/\/tmp\/Flash/ { print $1}')//:}){ print - "$f" }}

