# export PULSE_LATENCY_MSEC=60
unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'
export LESSCHARSET=UTF-8

export PYTHONIOENCODING='utf-8'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

export EDITOR="vim"
export VISUAL="gvim -f --remote-silent"

export INPUTRC=${HOME}/.config/inputrc

export BROWSER="firefox"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DOWNLOAD_DIR="${HOME}/dw"
export XDG_MUSIC_DIR="${HOME}/music"
export XDG_DESKTOP_DIR="${HOME}/.local/desktop"
export XDG_TEMPLATES_DIR=${XDG_DESKTOP_DIR}
export XDG_DOCUMENTS_DIR="${HOME}/doc/"
export XDG_PICTURES_DIR="${HOME}/pic"
export XDG_VIDEOS_DIR="${HOME}/vid"

export ACKRC="${XDG_CONFIG_HOME}/ackrc"
export GIMP2_DIRECTORY=${XDG_CONFIG_HOME}/gimp-2.8
export CLIVE_CONFIG="${XDG_CONFIG_HOME}/cliverc"

export VAGRANT_HOME="/mnt/home/vagrant"

export ESCDELAY=1

export NCURSES_ASSUMED_COLORS=3,0
export NCURSES_NO_MAGIC_COOKIES=1
export NCURSES_NO_PADDING=1

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/platform-tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/vmware/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME.gem/ruby/2.1.0:$HOME/.cabal/bin:/opt/math/bin:/opt/java6/bin:/opt/intel/pkg_bin:/opt/sage:$HOME/bin/rtags/bin:$HOME/bin:${HOME}/bin/go/bin"
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/platform-tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/vmware/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME.gem/ruby/2.1.0:$HOME/.cabal/bin:/opt/math/bin:/opt/java6/bin:/opt/intel/pkg_bin:/opt/sage:$HOME/bin/rtags/bin:$HOME/bin"

# PATH="/home/neg/.perl5/bin${PATH+:}${PATH}"; export PATH;
# PERL5LIB="/home/neg/.perl5/lib/perl5"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/home/neg/.perl5"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/home/neg/.perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/home/neg/.perl5"; export PERL_MM_OPT;
export PERLBREW_ROOT=/home/neg/.perl5

export PAGER="vimpager"
export SDCV_PAGER=$PAGER
alias less=$PAGER
alias zless=$PAGER

if [ -x ~/bin/_v ]; then
    export NULLCMD=~/bin/_v
    export READNULLCMD=~/bin/_v
else 
    if [ -x =vimpager ]; then
        export READNULLCMD=vimpager
    fi
fi


# export MAIL="/home/neg/.local/mail/gmail/[Gmail].All Mail"
# export MAIL=${MAIL:-/home/neg/.local/mail}
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

export PWS="$XDG_DATA_HOME/safe/pws"
export TEXINPUTS=".:$XDG_DATA_HOME/texmf//:"

export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"
export COLORTERM="yes"

export ACK_COLOR_MATCH="cyan bold"
export ACK_COLOR_FILENAME="cyan bold on_black"
export ACK_COLOR_LINENO="bold green"
export LS_COLORS GREP_COLORS

export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
# export WORDCHARS="${WORDCHARS:s#/#}"

fpath=(${HOME}/.zsh/zsh-completions/src $fpath)

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

## shell functions
#v1# set number of lines to display per page
HELP_LINES_PER_PAGE=20
#v1# set location of help-zle cache file
HELP_ZLE_CACHE_FILE=${HOME}/.cache/zsh_help_zle_lines.zsh

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=${HOME}/bin/go
# allow to use ,<key> more fast
export KEYTIMEOUT=5 
export OSSLIBDIR=/usr/lib/oss


export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=true' 
export JAVA_FONTS=/usr/share/fonts/TTF
