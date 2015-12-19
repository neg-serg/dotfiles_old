TRAPUSR1() { rehash }; # rehash on SIGUSR1
[[ -o interactive ]] && TRAPINT() { 
    zle && print -nP %F{blue}%B\^C%s%b
    return $1
}

autoload -U add-zsh-hook
# anything newly intalled from last command?
precmd_install() { [[ $history[$[ HISTCMD -1 ]] == *(apt-get|aptitude|pip|pacman|yaourt)* ]] && killall -u $USER -USR1 zsh }
add-zsh-hook precmd precmd_install # do this on precmd

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

zrcautoload colors && colors

zle -N zle-keymap-select
unset MAILCHECK
# // c-s disabling
# stty eof ''
stty eof  2> /dev/null
stty ixany
stty ixoff -ixon # Disable XON/XOFF flow control; this is required to make C-s work in Vim.

# stty intr "^C" 2> /dev/null
# stty erase "^?" 2> /dev/null
# stty start "undef" 2> /dev/null
# stty stop "undef" 2> /dev/null
# stty susp "^Z" 2> /dev/null
# stty rprnt "^R" 2> /dev/null
# stty werase "^W" 2> /dev/null
# stty lnext "^B" 2> /dev/null
# stty flush "undef" 2> /dev/null
# #stty eol "undef" 2> /dev/null
# #stty eol2 "undef" 2> /dev/null
# #stty swtch "undef" 2> /dev/null
# #stty kill "undef" 2> /dev/null
# #stty quit "undef" 2> /dev/null
# stty time 0 2> /dev/null
# stty min 0 2> /dev/null
# stty line 6 2> /dev/null
# stty speed 4000000 &> /dev/null

[[ -f ~/.config/dircolors/.dircolors ]] && eval $(dircolors ~/.config/dircolors/.dircolors)
# fi=00:di=00;34:mh=00:so=01;38;5;075:bd=38;5;24:cd=38;5;24:ex=04;32:no=00;38;5;244:pi=38;5;126:ln=38;5;05:mh=48;5;233;38;5;7;1;3:ow=48;5;233;38;5;7;1;3:su=38;5;137:st=38;5;86;48;5;234:rs=0:';

# No core dumps for now
ulimit -c 0

setopt append_history
setopt share_history
setopt extended_history
setopt histignorealldups 

setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_verify
setopt hist_ignore_space # reduce whitespace in history
setopt inc_append_history

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace 
setopt auto_cd 
setopt extended_glob 
setopt longlistjobs 
setopt nonomatch 
setopt notify 
setopt hash_list_all 
setopt completeinword 
setopt nohup 
setopt auto_pushd 
setopt pushdminus 
setopt pushdsilent 
setopt pushdtohome 
setopt pushd_ignore_dups 
setopt nobeep # Get rid of beeps
setopt noglobdots 
setopt noshwordsplit 

setopt C_BASES  # print $(( [#16] 0xff ))
setopt prompt_subst # Set the prompt
# make sure to use right prompt only when not running a command
setopt transient_rprompt
setopt interactivecomments # Allow interactive comments

# ~ substitution and tab completion after a = (for --x=filename args)
setopt magicequalsubst

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

# Keeps track of the last used working directory and automatically jumps
# into it for new shells.
export ZSH=~/.zsh
