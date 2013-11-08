# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ "$zcompdump" -nt "${zcompdump}.zwc" || ! -s "${zcompdump}.zwc" ]]; then
    zcompile "$zcompdump"
  fi

  # Set environment variables for launchd processes.
  if [[ "$OSTYPE" == darwin* ]]; then
    for env_var in PATH MANPATH; do
      launchctl setenv "$env_var" "${(P)env_var}"
    done
  fi
} &!

# autoload wrapper - use this one instead of autoload directly
# We need to define this function as early as this, because autoloading
# 'is-at-least()' needs it.
function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( found = 0 ))
    for fdir in ${fpath} ; do
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 ))
    done

    (( ffound == 0 )) && return 1
    autoload -U ${ffile} || return 1
    return 0
}


if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P37c7c99" #brown
    echo -en "\e]PB9e9ecb" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear
fi


# DIRSTACKSIZE=8
# setopt autopushd pushdminus pushdsilent pushdtohome
# 
# # Restore directory stack
# source ~/.dirstack
#
# ----------------------------------------------------------------- new

zle -N zle-keymap-select
unset MAILCHECK
# // c-s disabling
stty eof ''
stty ixany
stty ixoff -ixon

[[ -f ~/.dircolors ]] && eval $(dircolors ~/.dircolors)

# No core dumps for now
# ulimit -c 0

setopt append_history \
       share_history \
       extended_history \
       histignorealldups 
# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace \
       auto_cd \
       extended_glob \
       longlistjobs \
       nonomatch \
       notify \
       hash_list_all \
       completeinword \
       nohup \
       auto_pushd \
       nobeep \
       pushd_ignore_dups \
       noglobdots \
       noshwordsplit 

setopt C_BASES  # print $(( [#16] 0xff ))
setopt prompt_subst
# make sure to use right prompt only when not running a command
setopt transient_rprompt
 
# watch for everyone but me and root
watch=(notme root)

# automatically remove duplicates from these arrays
#typeset -U path cdpath fpath manpath

# autoloading
zrcautoload zmv    # who needs mmv or rename?
zrcautoload history-search-end
zrcautoload zargs

fpath=(~/.zsh/compdef $fpath) 
# completion system
if zrcautoload compinit ; then
    compinit || print 'Notice: no compinit available :('
else
    print 'Notice: no compinit available :('
    function zstyle { }
    function compdef { }
fi

zrcautoload zed # use ZLE editor to edit a file or function

for mod in complist deltochar mathfunc ; do
    zmodload -i zsh/${mod} 2>/dev/null || print "Notice: no ${mod} available :("
done

# autoload zsh modules when they are referenced
zmodload -a  zsh/stat    zstat
zmodload -a  zsh/zpty    zpty
zmodload -ap zsh/mapfile mapfile


# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
#isgrmlcd && limit core 0 # important for a live-cd-system
limit -s

