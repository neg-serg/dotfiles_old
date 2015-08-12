0=zsh
SHELL=$(which zsh)
export ZSHDIR=${HOME}/.zsh

unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export PYTHONIOENCODING='utf-8'
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

for cmd in vim nvim vi; { [[ -n $commands[(I)$cmd] ]] \
    && export EDITOR=$cmd; break}
export VISUAL="atom"

export INPUTRC=${HOME}/.config/inputrc

export BROWSER="firefox"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
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

export NCURSES_ASSUMED_COLORS=3,0
export NCURSES_NO_MAGIC_COOKIES=1
export NCURSES_NO_PADDING=1

export BIN_HOME=${HOME}/bin

path_dirs=(
    /usr/{s,}bin
    /usr/lib64/notion/bin
    {/usr/local,}/{s,}bin
	/usr/bin/{site,vendor,core}_perl
	${HOME}/.rvm/bin
	${BIN_HOME}/{,go/bin}
    $(ruby -e 'puts Gem.user_dir')/bin
)

export PATH=${(j_:_)path_dirs}

export PERLBREW_ROOT=${HOME}/.perl5

if [ -x "`which "vimpager" 2>/dev/null`" ]; then
    export PAGER="vimpager" SDCV_PAGER=${PAGER}
    alias less=${PAGER}
    alias zless=${PAGER}
else
    export PAGER="less"
fi

export X_OSD_COLOR='#00ffff'


export LESSCHARSET=UTF-8
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

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000
export SAVEHIST=100000 # useful for setopt append_history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*"
export HISTCONTROL=ignoreboth:erasedups # ignoreboth (= ignoredups + ignorespace)

export COLORTERM="yes"

export ACK_COLOR_MATCH="cyan bold"
export ACK_COLOR_FILENAME="cyan bold on_black"
export ACK_COLOR_LINENO="bold green"
export LS_COLORS GREP_COLORS

export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

fpath=(${HOME}/.zsh/zsh-completions/src $fpath)

# dirstack handling
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${HOME}/.zsh/99-zdirs

if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    # "cd -" won't work after login by just setting $OLDPWD, so
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=${HOME}/bin/go
export GOMAXPROCS=4
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export OSSLIBDIR=/usr/lib/oss

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1

export FZF_DEFAULT_COMMAND='find'

export PULSE_LATENCY_MSEC=60
export NVIM_TUI_ENABLE_TRUE_COLOR=1
