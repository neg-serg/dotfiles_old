#------------------------------------------------------------------------------------------------
# . ~/.zsh/10-syntax.zzz
# . ~/.zsh/additional-prompts.zsh
# . ~/.zsh/urls.zsh
# It can be used to remove trash like ~/.*~un
# . ~/.zsh/purge.zsh
# . ~/.zsh/predict.zsh
# . ~/.zsh/lsdisk.zsh

# . ~/.zsh/vi-mode.zsh
# . ~/.zsh/vi-mode2.zsh
# . ~/.zsh/zsh-history-substring-search.zsh
# . ~/.zsh/additional-keys.zsh
# . ~/.zsh/00-completion.zsh
# . ~/.zsh/02-abbrevations.bookmarks.zsh
#------------------------------------------------------------------------------------------------
# . ~/.zsh/01-fortune.zsh
# It has some bugs ;( but interesting
# . ~/.zsh/dirpersist.zsh
# lsr() {
#     local p=$argv[-1]
#     [[ -d $p ]] && { argv[-1]=(); } || p='.'
#     find $p ! -type d | sed 's:^./::' | egrep "${@:-.}"
# }
#
# # [~] >> px fire
# # USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
# # neg       1459  4.3  5.7 1382832 463468 ?      Sl   10:31   8:42 firefox
# px() {
#     ps uwwp ${$(pgrep -d, "${(j:|:)@}"):?no matches}
# }
 
 
# # Interactive zsh, but automatically execute given command.
# # zsh -is eval $COMMAND
# # c.f. http://www.zsh.org/mla/users/2005/msg00599.html
# # 12jan2013  +chris+
# if [[ $1 == eval ]]; then
#   shift
#   ICMD="$@"
#   set --
#   zle-line-init() {
#     BUFFER="$ICMD"
#     zle accept-line
#     zle -D zle-line-init
#   }
#   zle -N zle-line-init
# fi

# which() {
#   IFS="$(printf '\n\t')"
#   printf '\e[?7t'
#   builtin which "$@" \
#     && builtin type "$@" \
#     && whereis "$@" \
#     && file $(builtin type "$@" | awk '{print $3}') 2> /dev/null
#   printf '\e[?7t'
#
# # {{{ Rip Audio CDs to MP3
# ripdatshit() {
#   echo "MP3 VBR quality setting: [0-9]"
#   read $q
#   mkdir $HOME/tmp/rip
#   cd $HOME/tmp/rip
#   cdparanoia -B
#   for i in *.wav; do
#     lame -V $q $i mp3/${i%.*.*}.mp3
#   done
#   echo "Tag mp3 files with Easytag? [y/n]"
#   read $yn
#   if [[ "$yn" == "y" ]]; then
#     easytag $HOME/tmp/rip
#   fi
# } # }}}
# --------------[ dmenu wrap ]-------------------
#    #!/bin/bash
# dmenu wrapper, assign some options if they weren't given.

# main() {
#    local ARGS=
#    local FONT=
#    [[ "$@" != *-fn ]] && FONT="-*-terminus-*-r-*-*-16-*-*-*-*-*-*-*"
#    [[ "$@" != *-p ]] && ARGS="$ARGS -p exec:"
#    [[ "$@" != *-nb ]] && ARGS="$ARGS -l 25"
#    [[ "$@" != *-nb ]] && ARGS="$ARGS -nb #151617"
#    [[ "$@" != *-nf ]] && ARGS="$ARGS -nf #d8d8d8"
#    [[ "$@" != *-sb ]] && ARGS="$ARGS -sb #d8d8d8"
#    [[ "$@" != *-sf ]] && ARGS="$ARGS -sf #151617"
#    [[ -n "$FONT" ]] && {
#       /usr/bin/dmenu -fn "$FONT" $ARGS "$@"; return;
#    } || { /usr/bin/dmenu $ARGS "$@"; return; }
# }
# main "$@"
#
#
# help_zle_parse_keybindings() {
#     emulate -L zsh
#     setopt extendedglob
#     unsetopt ksharrays  #indexing starts at 1
# 
#     #v1# choose files that help-zle will parse for keybindings
#     ((${+HELPZLE_KEYBINDING_FILES})) || HELPZLE_KEYBINDING_FILES=( /etc/zsh/zshrc ~/.zshrc.pre ~/.zshrc ~/.zshrc.local )
# 
#     if [[ -r $HELP_ZLE_CACHE_FILE ]]; then
#         local load_cache=0
#         for f ($HELPZLE_KEYBINDING_FILES) [[ $f -nt $HELP_ZLE_CACHE_FILE ]] && load_cache=1
#         [[ $load_cache -eq 0 ]] && . $HELP_ZLE_CACHE_FILE && return
#     fi
# 
#     #fill with default keybindings, possibly to be overwriten in a file later
#     #Note that due to zsh inconsistency on escaping assoc array keys, we encase the key in '' which we will remove later
#     local -A help_zle_keybindings
#     help_zle_keybindings['<Ctrl>@']="set MARK"
#     help_zle_keybindings['<Ctrl>x<Ctrl>j']="vi-join lines"
#     help_zle_keybindings['<Ctrl>x<Ctrl>b']="jump to matching brace"
#     help_zle_keybindings['<Ctrl>x<Ctrl>u']="undo"
#     help_zle_keybindings['<Ctrl>_']="undo"
#     help_zle_keybindings['<Ctrl>x<Ctrl>f<c>']="find <c> in cmdline"
#     help_zle_keybindings['<Ctrl>a']="goto beginning of line"
#     help_zle_keybindings['<Ctrl>e']="goto end of line"
#     help_zle_keybindings['<Ctrl>t']="transpose charaters"
#     help_zle_keybindings['<Alt>t']="transpose words"
#     help_zle_keybindings['<Alt>s']="spellcheck word"
#     help_zle_keybindings['<Ctrl>k']="backward kill buffer"
#     help_zle_keybindings['<Ctrl>u']="forward kill buffer"
#     help_zle_keybindings['<Ctrl>y']="insert previously killed word/string"
#     help_zle_keybindings["<Alt>'"]="quote line"
#     help_zle_keybindings['<Alt>"']="quote from mark to cursor"
#     help_zle_keybindings['<Alt><arg>']="repeat next cmd/char <arg> times (<Alt>-<Alt>1<Alt>0a -> -10 times 'a')"
#     help_zle_keybindings['<Alt>u']="make next word Uppercase"
#     help_zle_keybindings['<Alt>l']="make next word lowercase"
#     help_zle_keybindings['<Ctrl>xd']="preview expansion under cursor"
#     help_zle_keybindings['<Alt>q']="push current CL into background, freeing it. Restore on next CL"
#     help_zle_keybindings['<Alt>.']="insert (and interate through) last word from prev CLs"
#     help_zle_keybindings['<Alt>,']="complete word from newer history (consecutive hits)"
#     help_zle_keybindings['<Alt>m']="repeat last typed word on current CL"
#     help_zle_keybindings['<Ctrl>v']="insert next keypress symbol literally (e.g. for bindkey)"
#     help_zle_keybindings['!!:n*<Tab>']="insert last n arguments of last command"
#     help_zle_keybindings['!!:n-<Tab>']="insert arguments n..N-2 of last command (e.g. mv s s d)"
#     help_zle_keybindings['<Alt>h']="show help/manpage for current command"
# 
#     #init global variables
#     unset help_zle_lines help_zle_sln
#     typeset -g -a help_zle_lines
#     typeset -g help_zle_sln=1
# 
#     local k v
#     local lastkeybind_desc contents     #last description starting with #k# that we found
#     local num_lines_elapsed=0            #number of lines between last description and keybinding
#     #search config files in the order they a called (and thus the order in which they overwrite keybindings)
#     for f in $HELPZLE_KEYBINDING_FILES; do
#         [[ -r "$f" ]] || continue   #not readable ? skip it
#         contents="$(<$f)"
#         for cline in "${(f)contents}"; do
#             #zsh pattern: matches lines like: #k# ..............
#             if [[ "$cline" == (#s)[[:space:]]#\#k\#[[:space:]]##(#b)(*)[[:space:]]#(#e) ]]; then
#                 lastkeybind_desc="$match[*]"
#                 num_lines_elapsed=0
#             #zsh pattern: matches lines that set a keybinding using bindkey or compdef -k
#             #             ignores lines that are commentend out
#             #             grabs first in '' or "" enclosed string with length between 1 and 6 characters
#             elif [[ "$cline" == [^#]#(bindkey|compdef -k)[[:space:]](*)(#b)(\"((?)(#c1,6))\"|\'((?)(#c1,6))\')(#B)(*)  ]]; then
#                 #description prevously found ? description not more than 2 lines away ? keybinding not empty ?
#                 if [[ -n $lastkeybind_desc && $num_lines_elapsed -lt 2 && -n $match[1] ]]; then
#                     #substitute keybinding string with something readable
#                     k=${${${${${${${match[1]/\\e\^h/<Alt><BS>}/\\e\^\?/<Alt><BS>}/\\e\[5~/<PageUp>}/\\e\[6~/<PageDown>}//(\\e|\^\[)/<Alt>}//\^/<Ctrl>}/3~/<Alt><Del>}
#                     #put keybinding in assoc array, possibly overwriting defaults or stuff found in earlier files
#                     #Note that we are extracting the keybinding-string including the quotes (see Note at beginning)
#                     help_zle_keybindings[${k}]=$lastkeybind_desc
#                 fi
#                 lastkeybind_desc=""
#             else
#               ((num_lines_elapsed++))
#             fi
#         done
#     done
#     unset contents
#     #calculate length of keybinding column
#     local kstrlen=0
#     for k (${(k)help_zle_keybindings[@]}) ((kstrlen < ${#k})) && kstrlen=${#k}
#     #convert the assoc array into preformated lines, which we are able to sort
#     for k v in ${(kv)help_zle_keybindings[@]}; do
#         #pad keybinding-string to kstrlen chars and remove outermost characters (i.e. the quotes)
#         help_zle_lines+=("${(r:kstrlen:)k[2,-2]}${v}")
#     done
#     #sort lines alphabetically
#     help_zle_lines=("${(i)help_zle_lines[@]}")
#     [[ -d ${HELP_ZLE_CACHE_FILE:h} ]] || mkdir -p "${HELP_ZLE_CACHE_FILE:h}"
#     echo "help_zle_lines=(${(q)help_zle_lines[@]})" >| $HELP_ZLE_CACHE_FILE
#     zcompile $HELP_ZLE_CACHE_FILE
# }
# typeset -g help_zle_sln
# typeset -g -a help_zle_lines

# # use it e.g. via 'Restart apache2'
# #m# f6 Start() \kbd{/etc/init.d/\em{process}}\quad\kbd{start}
# #m# f6 Restart() \kbd{/etc/init.d/\em{process}}\quad\kbd{restart}
# #m# f6 Stop() \kbd{/etc/init.d/\em{process}}\quad\kbd{stop}
# #m# f6 Reload() \kbd{/etc/init.d/\em{process}}\quad\kbd{reload}
# #m# f6 Force-Reload() \kbd{/etc/init.d/\em{process}}\quad\kbd{force-reload}
# if [[ -d /etc/init.d || -d /etc/service ]] ; then
#     __start_stop() {
#         local action_="${1:l}"  # e.g Start/Stop/Restart
#         local service_="$2"
#         local param_="$3"
# 
#         local service_target_="$(readlink /etc/init.d/$service_)"
#         if [[ $service_target_ == "/usr/bin/sv" ]]; then
#             # runit
#             case "${action_}" in
#                 start) if [[ ! -e /etc/service/$service_ ]]; then
#                            $SUDO ln -s "/etc/sv/$service_" "/etc/service/"
#                        else
#                            $SUDO "/etc/init.d/$service_" "${action_}" "$param_"
#                        fi ;;
#                 # there is no reload in runits sysv emulation
#                 reload) $SUDO "/etc/init.d/$service_" "force-reload" "$param_" ;;
#                 *) $SUDO "/etc/init.d/$service_" "${action_}" "$param_" ;;
#             esac
#         else
#             # sysvinit
#             $SUDO "/etc/init.d/$service_" "${action_}" "$param_"
#         fi
#     }
# 
#     _grmlinitd() {
#         local -a scripts
#         scripts=( /etc/init.d/*(x:t) )
#         _describe "service startup script" scripts
#     }
# 
#     for i in Start Restart Stop Force-Reload Reload ; do
#         eval "$i() { __start_stop $i \"\$1\" \"\$2\" ; }"
#         compdef _grmlinitd $i
#     done
# fi
#
#
# 
# #f1# Provides (partially autogenerated) help on keybindings and the zsh line editor
# help-zle() {
#     emulate -L zsh
#     unsetopt ksharrays  #indexing starts at 1
#     #help lines already generated ? no ? then do it
#     [[ ${+functions[help_zle_parse_keybindings]} -eq 1 ]] && {help_zle_parse_keybindings && unfunction help_zle_parse_keybindings}
#     #already displayed all lines ? go back to the start
#     [[ $help_zle_sln -gt ${#help_zle_lines} ]] && help_zle_sln=1
#     local sln=$help_zle_sln
#     #note that help_zle_sln is a global var, meaning we remember the last page we viewed
#     help_zle_sln=$((help_zle_sln + HELP_LINES_PER_PAGE))
#     zle -M "${(F)help_zle_lines[sln,help_zle_sln-1]}"
# }
# #k# display help for keybindings and ZLE (cycle pages with consecutive use)
# zle -N help-zle && bindkey '^xz' help-zle

# # After resuming from suspend, system is paging heavily, leading to very bad interactivity.
# # taken from $LINUX-KERNELSOURCE/Documentation/power/swsusp.txt
# [[ -r /proc/1/maps ]] && \
# deswap() {
#     print 'Reading /proc/[0-9]*/maps and sending output to /dev/null, this might take a while.'
#     sudo zsh -c cat $(sed -ne 's:.* /:/:p' /proc/[0-9]*/maps | sort -u | grep -v '^/dev/')  > /dev/null
#     print 'Finished, running "swapoff -a; swapon -a" may also be useful.'
# }
# 

# function qe(){
#     local q=$(eval '*(/om[1])')
#     [[ -d $q ]] && cd "$q"
# }
#
#
# alias cpf='rsync -aP'
# alias history='fc -l 1'
# 
# # generate alias named "$KERNELVERSION-reboot" so you can use boot with kexec:
# if [[ -x /sbin/kexec ]] && [[ -r /proc/cmdline ]] ; then
#     alias "$(uname -r)-reboot"="kexec -l --initrd=/boot/initrd.img-"$(uname -r)" --command-line=\"$(cat /proc/cmdline)\" /boot/vmlinuz-"$(uname -r)""
# fi
# 
#
#
# # if cdrecord is a symlink (to wodim) or isn't present at all warn:
# if [[ -L /usr/bin/cdrecord ]] || ! check_com -c cdrecord; then
#     if check_com -c wodim; then
#         cdrecord() {
#             cat <<EOMESS
# cdrecord is not provided under its original name by Debian anymore.
# See #377109 in the BTS of Debian for more details.
# 
# Please use the wodim binary instead
# EOMESS
#             return 1
#         }
#     fi
# fi
# 
# we don't want to quote/espace URLs on our own...
# if autoload -U url-quote-magic ; then
#    zle -N self-insert url-quote-magic
#    zstyle ':url-quote-magic:*' url-metas '*?[]^()~#{}='
# else
#    print 'Notice: no url-quote-magic available :('
# fi
#
#
# #       in zsh-help() below.
# [[ $NOPRECMD -eq 0 ]] && precmd () {
#     [[ $NOPRECMD -gt 0 ]] && return 0
#     # update VCS information
#     (( ${+functions[vcs_info]} )) && vcs_info
# 
#     if [[ $TERM == screen* ]] ; then
#         if [[ -n ${vcs_info_msg_1_} ]] ; then
#             ESC_print ${vcs_info_msg_1_}
#         else
#             ESC_print "zsh"
#         fi
#     fi
#     # just use DONTSETRPROMPT=1 to be able to overwrite RPROMPT
#     if [[ ${DONTSETRPROMPT:-} -eq 0 ]] ; then
#         if [[ $BATTERY -gt 0 ]] ; then
#             # update battery (dropped into $PERCENT) information
#             battery
#             RPROMPT="%(?..:() ${PERCENT}"
#         else
#             RPROMPT="%(?..:() "
#         fi
#     fi
#     # adjust title of xterm
#     # see http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
#     [[ ${NOTITLE:-} -gt 0 ]] && return 0
#     case $TERM in
#         (xterm*|rxvt*)
#             set_title ${(%):-"%n@%m: %~"}
#             ;;
#     esac
# }
# 
# EXITCODE="%(?..%?%1v )"
#
#
#_pre() {
#  pickyfont set '-jmk-neep-medium-r-normal--11-100-75-75-c-60-iso8859-1'        normal
#  pickyfont set '-jmk-neep-bold-r-normal--11-100-75-75-c-60-iso8859-1'          bold
#  pickyfont set '-jmk-neep-medium-r-semicondensed--11-100-75-75-c-50-iso8859-1' italic
#  setty foreground c1dae4
#  setty background 202020
#  setty wrap
#}

#_restore() {
#  pickyfont set '-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252' normal
#  pickyfont set '-windows-montecarlo-bold-r-normal--11-110-72-72-c-60-microsoft-cp1252'   bold
#  pickyfont set '-nil-profont-medium-r-normal--10-100-72-72-c-50-iso8859-1'               italic
#  setty foreground e5e5e5
#  setty background 121212
#  setty wrap
#}

#_tmux_it() {
  #tmux -f $HOME/etc/tmux.conf                        \
    #new-session  -d  '/usr/local/bin/ncmpcpp'     \; \
    #split-window -d  -p 1 -l 20 'pimpd2 -sh; zsh' \; \
    #selectp -t 1                                  \; \
    #split-window -d -h 'zsh'                      \; \
    #attach
#}

#_pre && _tmux_it
#_restore

#unset abk[V]
#unalias    'V'      &> /dev/null
#unfunction vman     &> /dev/null
#unfunction viless   &> /dev/null
#unfunction 2html    &> /dev/null

## manpages are not in grmlsmall
#unfunction manzsh   &> /dev/null
#unfunction man2     &> /dev/null

# _ssh_hosts=()
# _etc_hosts=()
# hosts=(
#     $(hostname)
#     "$_ssh_hosts[@]"
#     "$_etc_hosts[@]"
#     localhost
# )
# zstyle ':completion:*:hosts' hosts $hosts
# TODO: so, why is this here?
#  zstyle '*' hosts $hosts

# # especially for roadwarriors using GNU screen and ssh:
# if ! check_com asc &>/dev/null ; then
#   asc() { autossh -t "$@" 'screen -RdU' }
#   compdef asc=ssh
# fi
# find -iname '*.mp3' -print0 | xargs -0 mid3iconv -eCP1251 --remove-v1
#
#
# rationalise-dot() { if [[ $LBUFFER = *.. ]]; then   LBUFFER+=/..;  else  LBUFFER+=. fi }
# zle -N rationalise-dot
##-----------flac rename--------------
#for i in `ls split-track*flac`; do mv $i "$(echo -n $i | sed 's/split-track//' | sed 's/\.flac//'; echo -n " - "; metaflac --show-tag=TITLE $i | sed 's/.*=//'| tr "\r\n" " "; echo -n "("; metaflac --show-tag=ALBUM $i | sed 's/.*=//' | tr "\r\n" ")"; echo -n ".flac")"; done
#
# # {{{ Setup empty github repo
# mkgit() {
#   mkdir $1
#   cd $1
#   git init
#   touch README.markdown
#   git add README.markdown
#   git commit -m 'inital setup - automated'
#   git remote add origin git@github.com:neg/$1.git
#   git push origin master
# } # }}}
#
# regcheck() {
#     emulate -L zsh
#     zmodload -i zsh/pcre
#     pcre_compile $1 && \
#     pcre_match $2 && echo 'matches' || echo 'no match'
# }
# 
#
# After resuming from suspend, system is paging heavily, leading to very bad interactivity.
# taken from $LINUX-KERNELSOURCE/Documentation/power/swsusp.txt
# [[ -r /proc/1/maps ]] && \
# deswap() {
#     print 'Reading /proc/[0-9]*/maps and sending output to /dev/null, this might take a while.'
#     sudo zsh -c 'cat $(sed -ne 's:.* /:/:p' /proc/[0-9]*/maps | sort -u | grep -v '^/dev/')  > /dev/null'
#     print 'Finished, running "swapoff -a; swapon -a" may also be useful.'
# }

# #f# display contents of assoc array $abk
# help-show-abk()
# {
#   zle -M "$(print "Type ,. after these abbreviations to expand them:"; print -a -C 2 ${(kv)abk})"
# }
# #k# Display list of abbreviations that expand when followed by ,.
# zle -N help-show-abk && bindkey '^xb' help-show-abk
#
# Download a file and display it locally
# uopen() {
#     emulate -L zsh
#     if ! [[ -n "$1" ]] ; then
#         print "Usage: uopen \$URL/\$file">&2
#         return 1
#     else
#         FILE=$1
#         MIME=$(curl --head $FILE | \
#                grep Content-Type | \
#                cut -d ' ' -f 2 | \
#                cut -d\; -f 1)
#         MIME=${MIME%$'\r'}
#         curl $FILE | see ${MIME}:-
#     fi
# }

# directory based profiles

# chpwd() { local -ax my_stack; my_stack=( ${PWD} ${dirstack} ); builtin print -l ${(u)my_stack} >! ${DIRSTACKFILE} }
# # directory based profiles
# chpwd_functions=( ${chpwd_functions} chpwd_profiles )
# CHPWD_PROFILE='default'
# function chpwd_profiles() {
#     local -x profile
#     zstyle -s ":chpwd:profiles:${PWD}" profile profile || profile='default'
#     if (( ${+functions[chpwd_profile_$profile]} )) ; then
#         chpwd_profile_${profile}
#     fi
#     CHPWD_PROFILE="${profile}"
#     return 0
# }
# 

# typeset -Ag FX FG BG
# 
# FX=(
#     reset     "%{[00m%}"
#     bold      "%{[01m%}" no-bold      "%{[22m%}"
#     italic    "%{[03m%}" no-italic    "%{[23m%}"
#     underline "%{[04m%}" no-underline "%{[24m%}"
#     blink     "%{[05m%}" no-blink     "%{[25m%}"
#     reverse   "%{[07m%}" no-reverse   "%{[27m%}"
# )
# 
# for color in {000..255}; do
#     FG[$color]="%{[38;5;${color}m%}"
#     BG[$color]="%{[48;5;${color}m%}"
# done
#
# Show all 256 colors with color number
# function spectrum_ls() {
#   for code in {000..255}; do
#     print -P -- "$code: %F{$code}Test%f"
#   done
# }

# Remove these functions again, they are of use only in these
# setup files. This should be called at the end of .zshrc.
# xunfunction() {
#     emulate -L zsh
#     local -a funcs
#     funcs=(xunfunction zrcautoload)
# 
#     for func in $funcs ; do
#         [[ -n ${functions[$func]} ]] \
#             && unfunction $func
#     done
#     return 0
# }
# 
#
# mil() { mediainfo --Info-Parameters }
# mi() { mediainfo "--Inform=General;%$@%" }
# 
# function ESC_print () { info_print $'\ek' $'\e\\' "$@"  }
# function set_title () { info_print  $'\e]0;' $'\a' "$@" }
# 
# function info_print () {
#     local esc_begin esc_end
#     esc_begin="$1"
#     esc_end="$2"
#     shift 2
#     printf '%s' ${esc_begin}
#     printf '%s' "$*"
#     printf '%s' "${esc_end}"
# }
# 
# # run command line as user root via sudo:
# sudo-command-line() {
#     [[ -z $BUFFER ]] && zle up-history
#     if [[ $BUFFER != sudo\ * ]]; then
#         BUFFER="sudo $BUFFER"
#         CURSOR=$(( CURSOR+5 ))
#     fi
# }
#
# function xephyr {
#     Xephyr -ac -br -noreset -screen 1024x768 :1 &
#     sleep 2
#     DISPLAY=:1.0 $@
# }
# 
#
# catch-pic(){ grep -Roh "https?://([a-z0-9]\.?)+/(.*/?)+.*\.(png|jpe?g|gif)" .xchat2/xchatlogs/* | uniq -u }
# function iploc(){
#     myip=$(dig myip.opendns.com @resolver1.opendns.com +short)
#     loc=$(geoiplookup $myip | awk -F' ' '{print $4}' | sed '$s/,$//')
#     echo "IP: $myip";
#     echo -en "country:\e[01;35m $loc\e[0m\n";
#     exit 0
# }
# 
#
# (( ${QT_XFT} ))      || export QT_XFT=1
# (( ${GDK_USE_XFT} )) || export GDK_USE_XFT=1
# GTK_IM_MODULE=xim
# QT_IM_MODULE=xim

# export VDPAU_NVIDIA_NO_OVERLAY=1
# nvidia-settings -a GlyphCache=1
# nvidia-settings -a InitialPixmapPlacement=2

#xset fp $(echo "$HOME/.fonts
                #$HOME/.fonts/elite
                #$HOME/.fonts/monobook-font-0.22/pcf
                #/usr/share/fonts/{TTF,artwiz-fonts,local,misc}" | perl -pe 's/[\n\s]+//g')
#fc-cache

#GTK2_RC_FILES="${HOME}/.themes/Zukitwo-Resonance/gtk-2.0/gtkrc" /usr/bin/firefox $@

# mv $HOME/Downloads/* $HOME/dw && rm -r $HOME/Desktop $HOME/Downloads $HOME/gtk-3.0 $HOME/intel
# font='fixed'
#
#
#
###################################################################################################
#
#
#
## prompts
# LPROMPT () {
# PS1="┌─[%{$fg[cyan]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
# └─╼ "
# }
# 
# # Show vi mode
# function zle-line-init zle-keymap-select {
#     RPS1="%{$fg[magenta]%}${${KEYMAP/vicmd/%B Command Mode %b}/(main|viins)/ }"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# 
# zle -N zle-line-init
# zle -N zle-keymap-select
# 
# LPROMPT
# 
# ######## Pacman ########
# # update 
# alias pacup="sudo pacman -Syu"
# 
# # Remove orphans
# alias orphans="pacman -Qtdq"
# 
# # sudo pacman backup packages to Dropbox
# alias pacback='pacman -Qqe | grep -v "$(pacman -Qmq)" > ~/Dropbox/Archer/pklist-new.txt'
# 
# 
# ### Mounts ### 
# alias centurion="sudo mount.nfs 192.168.1.100:/home/jason /media/Centurion"
# alias sentinel="sudo mount.nfs 192.168.1.200:/home/jason/Backups /media/Sentinel"
# 
# # to run bash functions
# autoload bashcompinit
# bashcompinit
# 
# # source zsh functions file
# source "$HOME/.config/zsh/functions"
# 
# # command not found hook
# source "/usr/share/doc/pkgfile/command-not-found.zsh"
# 
# # source highlighting
# source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# 
# # history options
# export HISTFILE=~/.config/zsh/histfile
# export HISTSIZE=10000
# export SAVEHIST=$((HISTSIZE/2))
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt HIST_SAVE_NO_DUPS
# setopt HIST_VERIFY
# setopt INC_APPEND_HISTORY
# setopt EXTENDED_HISTORY
#
#
# history options
# export HISTFILE=~/.config/zsh/histfile
# export HISTSIZE=10000
# export SAVEHIST=$((HISTSIZE/2))
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt HIST_SAVE_NO_DUPS
# setopt HIST_VERIFY
# setopt INC_APPEND_HISTORY
# setopt EXTENDED_HISTORY
#
#
# export PS1="%{${fg[gray]}%}{%40<..<%~$NO_COLOUR%{${fg[gray]}%}} %{${fg_bold[green]}%}>> $NO_COLOUR"
#
# pb() { wget -U Mozilla -qO - "http://thepiratebay.org/search/'$@'/0/7/0" | grep -o 'http\:\/\/torrents\.thepiratebay\.org\/.*\.torrent' } 

# linux_changelog() {
#     local uri="http://www.kernel.org/pub/linux/kernel/v${@%%.*}.0/ChangeLog-$@"
#     curl -s "$uri" | grep -A 2 '^Date:' | grep ' \+[^:]\+: ' | sed 's/^ \+//'
# }
#
# isdarwin(){
#     [[ $OSTYPE == darwin* ]] && return 0
#     return 1
# }

function open() { xdg-open $1 &> /dev/null &disown; }
function lt() { ls -ltrsa "$@" | tail; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }

conf() {
  case $1 in
    xmonad)		vim ~/.xmonad/xmonad.hs ;;
    conky)		vim ~/.xmonad/.conky_dzen ;;
    homepage)	olddir=$(pwd) && cd ~/scripts/homepage.py && vim homepage.py && ./homepage.py; cd $olddir ;;
    menu)		vim ~/scripts/menu ;;
    mpd)		vim ~/.mpdconf ;;
    mutt)		vim ~/.mutt/acct/wei001 ;;
    ncmpcpp)	vim ~/.ncmpcpp/config ;;
    pacman)		svim /etc/pacman.conf ;;
    ranger)		vim ~/.config/ranger/rc.conf ;;
    rifle)		vim ~/.config/ranger/rifle.conf ;;
    tmux)		vim ~/.tmux.conf ;;
    vim)		vim ~/.vimrc ;;
    xinit)		vim ~/.xinitrc ;;
    xresources)	vim ~/.Xresources && xrdb ~/.Xresources ;;
    zathura)	vim ~/.config/zathura/zathurarc ;;
    theme2)		vim ~/.themes/FlatStudioCustom/gtk-2.0/gtkrc ;;
    theme3)		vim ~/.themes/FlatStudioCustom/gtk-3.0/gtk.css ;;
    gtk2)		vim ~/.gtkrc-2.0 ;;
    gtk3)		vim ~/.config/gtk-3.0/settings.ini ;;
      tint2)		vim ~/.config/tint2/xmonad.tint2rc ;;
    zsh)		vim ~/.zshrc && source ~/.zshrc ;;
    *)			echo "Unknown application: $1" ;;
  esac
}

#!/bin/sh
dir="$HOME/Dropbox/irssi/"

while inotifywait -qqre attrib "$dir" >/dev/null 2>&1; do
    echo "IRC: You have been pinged..." | dzen2 -p 3
done


# typeset -ga ls_options
# typeset -ga grep_options
# if ls --help 2> /dev/null | grep -q GNU; then
#     ls_options=( --color=auto )
# elif [[ $OSTYPE == freebsd* ]]; then
#     ls_options=( -G )
# fi
# if grep --help 2> /dev/null | grep -q GNU || \
#    [[ $OSTYPE == freebsd* ]]; then
#     grep_options=( --color=auto )
# fi
#
#
# set prompt
# if zrcautoload promptinit && promptinit 2>/dev/null ; then
#     promptinit # people should be able to use their favourite prompt
# else
#     print 'Notice: no promptinit available :('
# fi
#
#
#zmodload -i zsh/complist
# eval $(dircolors ~/.dircolors-256)
# eval $(dircolors ~/.dircolors-8)
# eval  $(dircolors ~/.LS_COLORS)
#alias libr='GTK2_RC_FILES="/usr/share/themes/Adwaita/gtk-2.0/gtkrc" libreoffice'
#alias pq='GTK2_RC_FILES="/home/neg/.themes/Aquanumb II Pack/Aquanumb II/gtk-2.0/gtkrc" pavucontrol'
#
#m# k ESC-h Call \kbd{run-help} for the 1st word on the command line
# alias run-help >&/dev/null && unalias run-help
# for rh in run-help{,-git,-svk,-svn}; do
#     zrcautoload $rh
# done; unset rh

# #f1# helper function for help-zle, actually generates the help text
# # make sure our environment is clean regarding colors
# for color in BLUE RED GREEN CYAN YELLOW MAGENTA WHITE ; unset $color
# 
# # use colors when GNU grep with color-support
# #a2# Execute \kbd{grep -{}-color=auto}
# (( $#grep_options > 0 )) && alias grep='grep '${grep_options:+"${grep_options[*]} "}

# #f1# helper function for help-zle, actually generates the help text
# # make sure our environment is clean regarding colors
# for color in BLUE RED GREEN CYAN YELLOW MAGENTA WHITE ; unset $color
# 
# # use colors when GNU grep with color-support
# #a2# Execute \kbd{grep -{}-color=auto}
# (( $#grep_options > 0 )) && alias grep='grep '${grep_options:+"${grep_options[*]} "}

# prompts
LPROMPT () {
PS1="┌─[%{$fg[cyan]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
└─╼ "
}

# Show vi mode
function zle-line-init zle-keymap-select {
    RPS1="%{$fg[magenta]%}${${KEYMAP/vicmd/%B Command Mode %b}/(main|viins)/ }"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

LPROMPT


#alias  ncmpcpp='colorcoke -r 105 -g 30 -b 50 -s 0 -e 15&&ncmpcpp; \
#                  cc-x-color-scheme-trapd00r'
# --[ pickyfont aliases ]-------------------------
# alias   2='pickyfont speedy2'
# alias   3='pickyfont progsole'
# alias  pf='pickyfont ter7'
# alias  jj='pickyfont terminus2'
# alias   j='pickyfont terminus1'
# alias   k='pickyfont proggy1'
# alias lll='pickyfont profont4'
# alias  ll='pickyfont profont2'
# alias  hh='pickyfont fixed7'
# alias  kk='pickyfont clea3'
# alias   f='pickyfont monte1 normal \
#             && pickyfont monte2 bold \
#             && pickyfont pro1 italic'
 
#--------- [ pimpd ] ------------
# alias          np='pimpd2 -i'
# alias         psh='pimpd2 -sh'
# alias         sdb='pimpd2 --search-db'
# alias         spl='pimpd2 --search-playlist'
# alias         sar='pimpd2 --search-artist'
# alias         sal='pimpd2 --search-album'
# alias         set='pimpd2 --search-title'
# alias         add='pimpd2 --add'
# alias        play='pimpd2 --play'
# alias        stop='pimpd2 --kill'
# alias        next='pimpd2 --next && pimpd2 -np'
# alias        prev='pimpd2 --prev && pimpd2 -np'
# alias        crop='pimpd2 --crop'
# alias        love='pimpd2 --love'
# alias       slove='pimpd2 --slove'
# alias      unlove='pimpd2 --unlove'
# alias        rand='pimpd2 --randomize'
# alias       randa='pimpd2 --random-album 10|pimpd2 --add && pimpd2 -play'
# alias        copy='pimpd2 --copy'
# alias       copya='pimpd2 --copy-album'
# alias       queue='pimpd2 --queue'
# alias       songs='pimpd2 --songs'
# alias      albums='pimpd2 --albums'
# alias   splaylist='pimpd2 --splaylist'
# alias   playlists='pimpd2 --playlists'

# alias 1='pickyfont elite1'
# alias 2='pickyfont -f ter3'
# alias 3='pickyfont -f ter1'
#
#
# alias lsa='ls -a .*(.)'                # only show dot-files
# alias lsl='ls -l *(@)'                 # only symlinks
# alias lsx='ls -l *(*)'                 # only executables
# alias lsd='ls -d *(/)'                 
# alias lss='ls -l *(s,S,t)'             # only files with setgid/setuid/sticky flag
# alias lsbig="ls -flh *(.OL[1,10])"     # display the biggest files
# #alias lsd='ls -ld *(-/DN)'            # only show directories
# alias lse='ls -d *(/^F)'               # only show empty directories

# function nokia(){sshfs -o modules=iconv,from_code=UTF8,to_code=KOI8-R root@nokia:/ /mnt/nokia}
# function droid(){sshfs -o modules=iconv,from_code=UTF8,to_code=KOI8-R,umask=022 root@droid:/mnt/sdcard /mnt/droid; cd /mnt/droid}
# alias play='audacious2 -i gtkui'


# alias "ping=ping -c 4"
# alias "wifi=wicd-curses"
# alias "search=tracker-search"
#
# alias   share='perl $HOME/dev/CPAN::Mirror::Server::HTTP/bin/cpanmirrorhttpd -root . -port 8080 --verbose'
#
# alias scat='source-highlight -o STDOUT -f esc -i'

# alias     rec='ffmpeg -f x11grab -s 3360x1050 -r 150 -i :0.0 -sameq /tmp/foo.mpg'
# alias     rampeak='dd if=/dev/mem|\cat|strings'

# shell aliases used for ES querying
# function dpaste ()            { zsh <(curl -s p.draines.com/sh) $1 }
# function draines ()           { curl -s p.draines.com/$1 | zsh }
# function indices ()           { curl -s p.draines.com/indices.sh | zsh }
# function indices15 ()         { curl -s p.draines.com/indices.sh | zsh -s 15 }
# function shards ()            { curl -s p.draines.com/shards.sh | zsh }
# function cluster ()           { curl -s p.draines.com/cluster.sh | zsh }
# function health ()            { curl -s p.draines.com/1336417317985b7d30212.txt | zsh }
# function health-nocolor ()    { curl -s p.draines.com/health.sh | zsh }
# function jstk ()              { sudo -u nobody jstack $1 >jstack-$(date +%s).txt }
# function red ()               { curl -s p.draines.com/willbered.sh | zsh -s $1 }
# function disk ()              { curl -s p.draines.com/disk.sh | zsh }
# function make-clean-shards () { curl -s p.draines.com/clean-shards.sh | zsh }
# function escolor ()           { es indices > >(fgrep red | wc -l | awk '{ print "red: " $0 }') > >(fgrep yellow | wc -l | awk '{ print "yellow: " $0 }') > >(fgrep green | wc -l | awk '{ print "green: " $0 }') }
#
# alias pnm2ps='pnmtops -width 8.26 -height 11.69'
# alias gif2ps='(giftopnm | pnm2ps)'
# alias jpeg2ps='(djpeg    | pnm2ps)'
# alias png2ps='(pngtopnm | pnm2ps)'
# alias ps2psbook="(psbook | psnup -2 | tumble)"
# alias ps2A5-haefte="(psbook -s8 | psnup -4 )"
# alias sho='xdvi -s 2 -expert -geometry 1010x900+30+1030'
# alias _dvishow='xdvi -s 3 -expert -geometry 990x990'
# Disable globbing.
#
#
stty intr "^C" 2> /dev/null
stty erase "^?" 2> /dev/null
stty eof "^D" 2> /dev/null
stty start "undef" 2> /dev/null
stty stop "undef" 2> /dev/null
stty susp "^Z" 2> /dev/null
stty rprnt "^R" 2> /dev/null
stty werase "^W" 2> /dev/null
stty lnext "^B" 2> /dev/null
stty flush "undef" 2> /dev/null
#stty eol "undef" 2> /dev/null
#stty eol2 "undef" 2> /dev/null
#stty swtch "undef" 2> /dev/null
#stty kill "undef" 2> /dev/null
#stty quit "undef" 2> /dev/null
stty time 0 2> /dev/null
stty min 0 2> /dev/null
stty line 6 2> /dev/null
stty speed 4000000 &> /dev/null


# typeset -ga ls_options
# typeset -ga grep_options
# if ls --help 2> /dev/null | grep -q GNU; then
#     ls_options=( --color=auto )
# elif [[ $OSTYPE == freebsd* ]]; then
#     ls_options=( -G )
# fi
# if grep --help 2> /dev/null | grep -q GNU || \
#    [[ $OSTYPE == freebsd* ]]; then
#     grep_options=( --color=auto )
# fi
#
#
# alias mp="mplayer -fs -slave -input file=~/.mplayer/mplayer.fifo" 
# alias mpa="mplayer -fs -ao null"
#!/bin/bash
# convert videos to x264 + aac
# http://rodrigopolo.com/ffmpeg/cheats.html

#ffmpeg -y -i $1 -r 30000/1001 -b:v 1M -bt 2M -vcodec libx264 -pass 1 -flags +loop -me_method dia -g 250 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -bf 16 -b_strategy 1 -i_qfactor 0.71 -cmp +chroma -subq 1 -me_range 16 -coder 1 -sc_threshold 40 -flags2 -bpyramid-wpred-mixed_refs-dct8x8+fastpskip -keyint_min 25 -refs 1 -trellis 0 -directpred 1 -partitions -parti8x8-parti4x4-partp8x8-partp4x4-partb8x8 -an output.mp4

#ffmpeg -y -i $1 -r 30000/1001 -b:v 1M -bt 2M -vcodec libx264 -pass 2 -flags +loop -me_method umh -g 250 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -bf 16 -b_strategy 1 -i_qfactor 0.71 -cmp +chroma -subq 8 -me_range 16 -coder 1 -sc_threshold 40 -flags2 +bpyramid+wpred+mixed_refs+dct8x8+fastpskip -keyint_min 25 -refs 4 -trellis 1 -directpred 3 -partitions +parti8x8+parti4x4+partp8x8+partb8x8 -acodec aac -ac 2 -ar 44100 -ab 128k -strict -2 output.mp4

#ffmpeg -y -i "$1" -r 30000/1001 -b:v 1M -bt 2M -vcodec libx264 -flags +loop -me_method umh -g 250 -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -bf 16 -b_strategy 1 -i_qfactor 0.71 -cmp +chroma -subq 8 -me_range 16 -coder 1 -sc_threshold 40 -flags2 +bpyramid+wpred+mixed_refs+dct8x8+fastpskip -keyint_min 25 -refs 4 -trellis 1 -directpred 3 -partitions +parti8x8+parti4x4+partp8x8+partb8x8 -acodec aac -ac 2 -ar 44100 -ab 61.1k -strict -2 "${1%.rmvb}.mp4"
#
#
# dehdr() {
#     CFLAGS="-Werror -Wfatal-errors" deheader "$@" | sed -n 's/.*: *remove *\(.*\) *from *\(.*\)/\2: \1/p'
# }
# vgrep() {
# for pro in $(grep -l $1 /proc/[0-9]*/environ 2>/dev/null); do
#   dir=$(dirname $pro)
#   printf "\033[38;5;78m[%0.4d]\033[38;5;111m %s\n" \
#       $(basename $dir) "$(cat $dir/cmdline 2>/dev/null)"
#   list="$(grep --binary-files=text -o "[A-Z0-9_]*$1[A-Z0-9_]*" \
#       $pro 2>/dev/null)"
#   echo -en "   \033[38;5;229m"
#   for entry in $list; do
#     echo -n " $entry"
#   done
#   echo -e "\033[0m"
# done
# }
# function urldecode(){
#     #f5# RFC 2396 URL encoding in Z-Shell
#     emulate -L zsh
#     setopt extendedglob
#     input=( ${(s::)1} )
#     print ${(j::)input/(#b)([^A-Za-z0-9_.!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
# }

#f# display contents of assoc array $abk
# help-show-abk()
# { zle -M "$(print "Type ,. after these abbreviations to expand them:"; print -a -C 2 ${(kv)abk})" }
#k# Display list of abbreviations that expand when followed by ,.

# 
# 
# whatwhen()  {
#     emulate -L zsh
#     local usage help ident format_l format_s first_char remain first last
#     usage='USAGE: whatwhen [options] <searchstring> <search range>'
#     help='Use `whatwhen -h'\'' for further explanations.'
#     ident=${(l,${#${:-Usage: }},, ,)}
#     format_l="${ident}%s\t\t\t%s\n"
#     format_s="${format_l//(\\t)##/\\t}"
#     # Make the first char of the word to search for case
#     # insensitive; e.g. [aA]
#     first_char=[${(L)1[1]}${(U)1[1]}]
#     remain=${1[2,-1]}
#     # Default search range is `-100'.
#     first=${2:-\-100}
#     # Optional, just used for `<first> <last>' given.
#     last=$3
#     case $1 in
#         ("")
#             printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
#             printf '%s\n%s\n\n' ${usage} ${help} && return 1
#         ;;
#         (-h)
#             printf '%s\n\n' ${usage}
#             print 'OPTIONS:'
#             printf $format_l '-h' 'show help text'
#             print '\f'
#             print 'SEARCH RANGE:'
#             printf $format_l "'0'" 'the whole history,'
#             printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
#             printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
#             printf '\n%s\n' 'EXAMPLES:'
#             printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -100 by default.'
#             printf $format_l 'whatwhen zsh -250'
#             printf $format_l 'whatwhen foo 1 99'
#         ;;
#         (\?)
#             printf '%s\n%s\n\n' ${usage} ${help} && return 1
#         ;;
#         (*)
#             # -l list results on stout rather than invoking $EDITOR.
#             # -i Print dates as in YYYY-MM-DD.
#             # -m Search for a - quoted - pattern within the history.
#             fc -li -m "*${first_char}${remain}*" $first $last
#         ;;
#     esac
# }
#
# prep() { # [pattern] [filename unless STDOUT]
#     perl -nle 'print if /'"$1"'/;' $2
# }
# say() { print "$1\n" }
# 
#
# # Find out which libs define a symbol
# lcheck() {
#     if [[ -n "$1" ]] ; then
#         nm -go /usr/lib/lib*.a 2>/dev/null | grep ":[[:xdigit:]]\{8\} . .*$1"
#     else
#         echo "Usage: lcheck <function>" >&2
#     fi
# }
# 
#
# press esc-m for inserting last typed word again (thanks to caphuso!)
# insert-last-typed-word() { zle insert-last-word -- 0 -1 };
# zle -N insert-last-typed-word

# function cp_progress(){
#     for pid in $(pgrep -x cp) ; do
#         for fd in 4 3 ; do
#             symlink="/proc/${pid}/fd/${fd}"
#             if [ -L "$symlink" ] ; then
#                 ls -sh "$(readlink "$symlink")"
#             fi
#         done
#     done
# }
# 
#
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
# function cbf() { cat "$1" | cb; }  
# Copy SSH public key
# alias cbssh="cb ~/.ssh/id_rsa.pub"  
# Copy current working directory
# alias cbwd="pwd | cb"  
# Copy most recent command in bash history
# alias cbhs="cat $HISTFILE | tail -n 1 | cb"  
# ---- helper --------------------------------
# :h () {
#     vim +":h '$1'" +":resize"
# }
# #
#
# eval "insert-cycledleft () { zle push-line; LBUFFER='pushd -q +1'; zle accept-line }"
# zle -N insert-cycledleft
# bindkey "^[9" insert-cycledleft
# eval "insert-cycledright () { zle push-line; LBUFFER='pushd -q -0'; zle accept-line }"
# zle -N insert-cycledright
# bindkey "^[0" insert-cycledright
#----------------------------------------------------------------------------------------------------
#
# # Initialization
#
# # add a function path
# fpath=($ZSH/functions $ZSH/subs/**/functions(N) $fpath)
# path+=($ZSH/bin)
#
# [[ -d $ZSH/subs/zsh-completions/src ]] && fpath+=( $ZSH/subs/zsh-completions/src )
#
# if [[ ! -a $ZSH/subs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
#     echo 'Missing subs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh, and probably others.'
#     echo 'Did you git submodule init && git submodule update ?'
# fi
#
# # load all config files from config/, module/ and local/ we do some sorting
# # magic here: the files from all three directories are ordered by their
# # filename without regard to their path, meaning it's possible to specify at
# # what point the files in local/ will be loaded. if two filenames are the same,
# # the one in local/ will be loaded first. the ^-@ ignores dead symlinks, which
# # are probably the result of missing submodles.
# for config_file in $ZSH/(local|config|modules|lib)/*.zsh(Noe!'REPLY=${REPLY:t}'!oe!'[[ $REPLY == *local* ]] && REPLY=0 || REPLY=1'!^-@); source $config_file
#----------------------------------------------------------------------------------------------------
#Usage: find [dir] [mask1] [mask2]...
# #where maskN will become <<-iname '*maskN*'>> param for 'find'
# #'dir' should be an existing directory. otherwise it will be recognized as mask.
# function findm {
#         local HLCOLOR="\x1b[30;47m"
#         local NOCOLOR="\x1b[0m"
#
#         local it cl sp;
#         [ -d "$1" ] && cl="'$1'" && shift;
#         for it in "$@"; do
#                 cl="${cl} -iname '*${it}*' -or";
#                 sp="${sp}${it}\\|";
#         done;   
#         cl="${cl%-or}";
#         sp="s/\\(${sp%\\|}\\)/${HLCOLOR}\\0${NOCOLOR}/ig";
#         eval find ${cl} | sed -e "${sp}";
# }
#
# #
#
# function _backward_kill_default_word() {
#     WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' zle backward-kill-word
# }
#
# alias kqed='mp -cache-min 4 http://kqed-ice.streamguys.org:80/kqedradio-ew-e1'
# alias ipr='mp -cache-min 4 http://voxsc1.somafm.com:8070'
# alias npr='mp -cache-min 4 http://npr.ic.llnwd.net/stream/npr_live24'

#

# change the cursor color with vi mode, not widely tested but works on a few
# setups at least...

# relies on zle_keymap_select_functions being run properly.

# if [[ $TERM == rxvt* || $TERM == xterm* || -n $TMUX ]]; then
#
#     # this is a fairly new tmux feature
#     [[ -n $TMUX ]] && [[ ${"$(tmux -V)"#tmux } -lt 1.8 ]] && return
#
#     # note for tmux in rxvt-unicode this requires this addition to terminal-overrides:
#     # 'rxvt-unicode*:Cc=\E]12;%p1%s\E\\'
#
#     zle-keymap-select-vicursor () {
#         if [[ $KEYMAP == vicmd ]]; then
#             echo -ne "\033]12;red\033\\"
#         else
#             echo -ne "\033]12;grey\033\\"
#         fi
#     }
#
#     zle_keymap_select_functions+=( zle-keymap-select-vicursor )
#     # make sure it's correct at the beginning, too!
#     zle_line_init_functions+=( zle-keymap-select-vicursor )
#
# fi
