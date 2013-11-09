# XDG_DESKTOP_DIR="/home/user/"
# XDG_TEMPLATES_DIR="/home/user/dir"
# XDG_PUBLICSHARE_DIR="/home/user/dir"
# XDG_DOCUMENTS_DIR="/home/user/dir"
# XDG_PICTURES_DIR="/home/user/dir"
# XDG_VIDEOS_DIR="/home/user/dir"

# Don't change. The following determines where YADR is installed.
# export PERLBREW_ROOT=${HOME}/bin/perl5/perlbrew
# export yadr=$HOME/.yadr 
unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'
export LESSCHARSET=UTF-8

export PWS="$HOME/.safe/pws"
export PYTHONIOENCODING='utf-8'
export TEXINPUTS=".:$XDG_DATA_HOME/texmf//:"
# export GREP_COLORS='ms=1;33:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'
export GREP_COLORS="38;5;230:sl=38;5;240:cs=38;5;100:mt=38;5;161;1:fn=38;5;197:ln=38;5;212:bn=38;5;44:se=38;5;166"

export EDITOR="vim"
export VISUAL="gvim --remote-silent"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/dw"
export XDG_MUSIC_DIR="${HOME}/music"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/platform-tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/vmware/bin:$HOME/bin:/home/neg/.gem/ruby/2.0.0/bin:/home/neg/.cabal/bin:/opt/intel/bin:/opt/math/bin:/opt/java6/bin"
#export PAGER="vimpager"
#export MAIL=${MAIL:-/var/mail/$USER}
export SHELL='/bin/zsh'
export X_OSD_COLOR='#00ffff'
# support colors in less
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin blinking
export LESS_TERMCAP_md=$'\e[1;35m'     # begin bold
export LESS_TERMCAP_me=$'\e[0m'        # end mode
export LESS_TERMCAP_so=$'\e[1;40;36m'  # begin standout - info box
export LESS_TERMCAP_se=$'\e[0m'        # end standout
export LESS_TERMCAP_us=$'\e[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\e[0m'        # end underline

export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"
export COLORTERM="yes"

export ACK_COLOR_MATCH="cyan bold"
export ACK_COLOR_FILENAME="cyan bold on_black"
export ACK_COLOR_LINENO="bold green"
export LS_COLORS GREP_COLORS

export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
#export WORDCHARS="${WORDCHARS:s#/#}"

fpath=(~/.zsh/zsh-completions/src $fpath)

#export EXT_LLVM_DIR=/home/neg/build/git/extempore/llvm-3.0/Build
ZSHDIR=$HOME/.zsh

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=100000 # useful for setopt append_history

# dirstack handling

DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${DIRSTACKFILE:-${HOME}/.zsh/99-zdirs}

if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    # "cd -" won't work after login by just setting $OLDPWD, so
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi


# set colors for use in prompts
if zrcautoload colors && colors 2>/dev/null ; then
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg_bold[red]}%}"
    GREEN="%{${fg[green]}%}"
    CYAN="%{${fg[cyan]}%}"
    MAGENTA="%{${fg[magenta]}%}"
    YELLOW="%{${fg[yellow]}%}"
    WHITE="%{${fg[white]}%}"
    NO_COLOUR="%{${reset_color}%}"
fi

# setting some default values
NOCOR=${NOCOR:-0}
NOMENU=${NOMENU:-0}
COMMAND_NOT_FOUND=${COMMAND_NOT_FOUND:-0}
BATTERY=${BATTERY:-0}
ZSH_NO_DEFAULT_LOCALE=${ZSH_NO_DEFAULT_LOCALE:-0}

## shell functions
#v1# set number of lines to display per page
HELP_LINES_PER_PAGE=20
#v1# set location of help-zle cache file
HELP_ZLE_CACHE_FILE=~/.cache/zsh_help_zle_lines.zsh

export MPV_HOME="~/.config/mpv"
