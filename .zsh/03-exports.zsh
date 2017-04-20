source ~/.zsh/03-helpers.zsh
source ~/.zsh/03-xdg_vars.zsh

0=zsh
SHELL=$(which zsh)

path_dirs=(
    /usr/{s,}bin
    /usr/lib64/notion/bin
    {/usr/local,}/{s,}bin
	/usr/bin/{site,vendor,core}_perl
	${HOME}/.rvm/bin
	${BIN_HOME}/{,go/bin,local,wm/bin}
    /opt/android-sdk/platform-tools
    /mnt/home/.local/bin
    /opt/cuda/bin
)

whence ruby >/dev/null && \
    path_dirs+=$($(whence ruby) -e 'puts Gem.user_dir')/bin

export PATH=${(j_:_)path_dirs}

# Add RVM to PATH for scripting
export PATH="${PATH}:${HOME}/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && \
    source "${HOME}/.rvm/scripts/rvm"
eval $(perl -I /one/dev/perl5/lib/perl5 -Mlocal::lib=/one/dev/perl5)

unset SSH_ASKPASS
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export AURDEST=~/tmp/pacaur

export PYTHONIOENCODING='utf-8'
export GREP_COLOR='37;45'
export GREP_COLORS='ms=0;32:mc=1;33:sl=:cx=:fn=1;32:ln=1;36:bn=36:se=1;30'

for q in vim nvim vi; 
    { [[ -n ${commands}[(I)${q}] ]] \
    && export EDITOR=${q}; break }
export VISUAL="${SCRIPT_HOME}/v_standalone"

export INPUTRC=${HOME}/.config/inputrc

export BROWSER="firefox"

export ACKRC="${XDG_CONFIG_HOME}/ackrc"
export GIMP2_DIRECTORY=${XDG_CONFIG_HOME}/gimp-2.8
export CLIVE_CONFIG="${XDG_CONFIG_HOME}/cliverc"

export VAGRANT_HOME="/mnt/home/vagrant"

export NCURSES_ASSUMED_COLORS=3,0
export NCURSES_NO_MAGIC_COOKIES=1
export NCURSES_NO_PADDING=1

export PERLBREW_ROOT=${HOME}/.perl5

if [[ -x "$(which "vimpager" 2>/dev/null)" ]]; then
    export PAGER="vimpager -u ~/.vim/vimpagerrc" SDCV_PAGER=${PAGER}
    alias less=${PAGER}
    alias zless=${PAGER}
else
    export PAGER="less"
fi

export X_OSD_COLOR='#00ffff'

export LESSCHARSET=UTF-8
export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)" # begin blinking
export LESS_TERMCAP_md="$(tput bold)"               # begin bold
export LESS_TERMCAP_me="$(tput sgr0)"               # end mode
export LESS_TERMCAP_so="$(tput bold; tput setaf 6)" # begin standout - info box
export LESS_TERMCAP_se="$(tput sgr0)"               # end standout
export LESS_TERMCAP_us="$(tput bold; tput setaf 2)" # begin underline
export LESS_TERMCAP_ue="$(tput sgr0)"               # end underline

export PWS="${XDG_DATA_HOME}/safe/pws"
export TEXINPUTS=".:${XDG_DATA_HOME}/texmf//:"

# history
export HISTFILE=${HOME}/.zsh/zsh_history
export SAVEHIST=100000 # useful for setopt append_history
export HISTSIZE=$(( $SAVEHIST * 1.10 ))
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd*:gs:gd"
export HISTCONTROL=ignoreboth:erasedups # ignoreboth (= ignoredups + ignorespace)

local -a timefmt_=(
    $(_zwrap "$(_zfwrap "%J")") 
    $(_zwrap "%U")
    $(_zwrap "user %S") 
    $(_zwrap "system %P") 
    $(_zwrap "cpu %*E total")
    $(_zwrap "-||-") 
    $(_zwrap "Mem: %M kb max")
)
export TIMEFMT="${timefmt_[@]}"

export COLORTERM="yes"

export ACK_COLOR_MATCH="cyan bold"
export ACK_COLOR_FILENAME="cyan bold on_black"
export ACK_COLOR_LINENO="bold green"
export LS_COLORS GREP_COLORS

export WORDCHARS='*?_-.[]~&;!#$%^(){}<>~` '

# dirstack handling
DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${HOME}/.zsh/.99-zdirs

if [[ -f ${DIRSTACKFILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] ; then
    dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
    # "cd -" won't work after login by just setting $OLDPWD, so
    [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

export MPV_HOME="${HOME}/.config/mpv"
export MANWIDTH=${MANWIDTH:-80}
export GOPATH=${HOME}/bin/go
export GOMAXPROCS=8
export KEYTIMEOUT=5 # allow to use ,<key> more fast
export ESCDELAY=1

export OSSLIBDIR=/usr/lib/oss

export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
_SILENT_JAVA_OPTIONS="${_JAVA_OPTIONS}"
unset _JAVA_OPTIONS

(( 0 != 0 )) && {
    if which drip > /dev/null 2>&1; then
        export DRIP_SHUTDOWN=30
        export JAVACMD=$(which drip)
    fi
}

export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"

export SKIM_DEFAULT_COMMAND='ag -l -g ""'
export SKIM_DEFAULT_OPTIONS="${SKIM_DEFAULT_OPTS} --color=16"

export PULSE_LATENCY_MSEC=60
export NVIM_TUI_ENABLE_TRUE_COLOR=0

export STEAM_RUNTIME=1

local audio_card_="alsa_output.usb-E-MU_Systems__Inc._E-MU_0204___USB_E-MU-A8-3F19-07DC0212-089A1-8740AT2A-00.analog-stereo"
export QEMU_AUDIO_DRV=pa
export QEMU_PA_SOURCE=input
export QEMU_PA_SINK="${audio_card_}"

export SXHKD_FIFO="/tmp/sxhkd_fifo"
export SXHKD_SHELL="zsh"

export VIDEO_PLAYER_="mpv"

export AUTOPAIR_INHIBIT_INIT=1

export vim_server_name="VIM"
export wim_font="PragmataPro for Powerline"
export wim_font_s="Mensch:size=14"
export wim_font_size=20
export wim_sock_path="${HOME}/1st_level/vim.socket"
export wim_timer=".1s"

export nwim_font="${wim_font}"
export nwim_font_s="${wim_font_s}"
export nwim_font_size=${wim_font_size}
export nwim_timer=".1s"
export nvim_server_name="NVIM"
export nwim_sock_path="${HOME}/1st_level/nvim.socket"
export NVIM_LISTEN_ADDRESS="${HOME}/1st_level/nwim.socket"

(){
    local _home="/mnt/home"
    local _dev="/one/dev"
    hash -d dev=${_dev}
    hash -d doc="${_home}/doc"
    hash -d nv="${_dev}/src/1st_level/neovim"
    hash -d torrent="${_home}/torrent"
    hash -d v="${_home}/vid"
    hash -d z="${_dev}/src"
    hash -d p='/home/neg/pic'
}
