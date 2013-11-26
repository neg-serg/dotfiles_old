# completion system
#===============================================================================================================================
# note: use 'zstyle' for getting current settings
#         press ^xh (control-x h) for getting tags in context; ^x? (control-x ?) to run complete_debug with trace output
mycompletion() {
    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'
    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true
    # activate color-completion
    # zstyle ':completion:*' list-colors ${${(s.:.)LS_COLORS}%ec=*}
    # zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}
    # format on completion
    # zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%} completing %B%d%b% {\e[0m%}'
    zstyle ':completion:*:-tilde-:*' group-order 'named-directories'
    # zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
    # zstyle ':completion:*:descriptions' format "%B---- %d%b"
    # zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
    # zstyle ':completion:*:warnings' format '%B%F{9}---- no match for: %d%f%b'
    # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    # zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false
    # activate menu
    zstyle ':completion:*:history-words'   menu yes
    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes
    # match uppercase from lowercase
#   zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    # separate matches into groups
    zstyle ':completion:*:matches'           group 'yes'
    zstyle ':completion:*'                   group-name ''
    zstyle ':completion:*'                   menu select=5
    zstyle ':completion:*:messages'          format '%d'
    zstyle ':completion:*:options'           auto-description '%d'
    zstyle ':completion:*:options'           description 'yes'
    # zstyle ':completion:*:processes'       command 'ps -au$USER'
    # zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=00;04=0=01'
    zstyle ':completion:*:*:kill:*:processes' menu interactive=3
    zstyle ':completion:*:*:*:*:processes'    command "ps -u `whoami` -o pid,user,comm -w -w"
    zstyle ':completion:*:*:-subscript-:*'    tag-order indexes parameters
    zstyle ':completion:*'                    verbose true
    zstyle ':completion:*:-command-:*:'       verbose false
    zstyle ':completion:*:warnings'           format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
    zstyle ':completion:*:*:zcompile:*'       ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'             prompt 'correct to: %e'
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
    zstyle ':completion:*:manuals'            separate-sections true
    zstyle ':completion:*:manuals.*'          insert-sections   true
    zstyle ':completion:*:man:*'              menu yes select
    zstyle ':completion:*'                    special-dirs ..
    zstyle ':completion:*'                    use-perl 'yes'
    # mplayer                                                                    {{{
    zstyle ':completion:*:(mv|cp|file|m|mplayer|mpv):*'  ignored-patterns '(#i)*.(url|mht)'
    zstyle ':completion:*:*:mplayer:*'           tag-order files
    zstyle ':completion:*:*:mplayer:*'           file-sort name
    zstyle ':completion:*:*:mplayer:*'           menu select auto

    zstyle ':completion:*:*:mpv:*'               tag-order files
    zstyle ':completion:*:*:mpv:*'               file-sort name
    zstyle ':completion:*:*:mpv:*'               menu select auto
    
    zstyle ':completion:*:*:(*mplayer*|m|ms):*' file-patterns '(#i)*.(rmvb|mkv|vob|mp4|m4a|iso|wmv|webm|flv|ogv|avi|mpg|mpeg|iso|nrg|mp3|flac|rm|wv):files:mplayer\ play *(-/):directories:directories'
    zstyle ':completion:*:*:(*mpv*):*' file-patterns '(#i)*.(rmvb|mkv|vob|mp4|m4a|iso|wmv|webm|flv|ogv|avi|mpg|mpeg|iso|nrg|mp3|flac|rm|wv):files:mpv\ play *(-/):directories:directories'
    zstyle ':completion:*:default' list-colors ${${(s.:.)LS_COLORS}%ec=*}
    #----------------CLEAR OLD STUFF!!!!!!1
    zstyle ':completion:*:descriptions' format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%}%{${reset_color}%}"
    zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
    zstyle ':completion:*:corrections'  format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%})"
    # zstyle ':completion:*:descriptions' format "%{${fg[cyan]}%}[%{${reset_color}%} - %d%{${reset_color}%} - %{${fg[cyan]}%}]%{${reset_color}%}"
    # zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
    # zstyle ':completion:*:corrections'  format "%{${fg[cyan]}%}[ %{${reset_color}%} - %d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%}) %{${fg[cyan]}%}]%{${reset_color}%}"
    # zstyle ':completion:*:descriptions' format "%{${fg[cyan]}%}[%{${reset_color}%}%d%{${reset_color}%}%{${fg[cyan]}%}]%{${reset_color}%}"
    # zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
    # zstyle ':completion:*:corrections'  format "%{${fg[cyan]}%}[ %{${reset_color}%}%d%{${reset_color}%}(%{${fg[cyan]}%}errors %e%{${reset_color}%}) %{${fg[cyan]}%}]%{${reset_color}%}"
    # zstyle ':completion:*:descriptions' format "%{${fg[cyan]}%}[%{${reset_color}%} - %{${fg[white]}%}%d%{${reset_color}%} - %{${fg[cyan]}%}]%{${reset_color}%}"
    # zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
    # zstyle ':completion:*:corrections'  format "%{${fg[cyan]}%}[ %{${reset_color}%} - %{${fg[white]}%}%d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%}) %{${fg[cyan]}%}]%{${reset_color}%}"
    zstyle ':completion:*:default'      \
    select-prompt \
    "%{${fg[cyan]}%}Match %{${fg_bold[cyan]}%}%m%{${fg_no_bold[cyan]}%}  Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[red]}%}  %p%{${reset_color}%}"
    zstyle ':completion:*:default'      \
    list-prompt   \
    "%{${fg[cyan]}%}Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[cyan]}%}  Continue?%{${reset_color}%}"
    zstyle ':completion:*:warnings'     \
    format        \
    "- %{${fg_no_bold[red]}%}no match%{${reset_color}%} - %{${fg_no_bold[cyan]}%}%d%{${reset_color}%}"
    zstyle ':completion:*' group-name ''
    ### manual pages are sorted into sections
    zstyle ':completion:*:manuals'       separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections   true
    zstyle ':completion:*:wine:*' file-patterns '*.(exe|EXE):exe'
    ### highlight parameters with uncommon names
        zstyle ':completion:*:parameters' \
            list-colors "=[^a-zA-Z]*=$color[red]"
    ### highlight aliases
        zstyle ':completion:*:aliases' \
            list-colors "=*=$color[green]"
    ## show that _* functions are not for normal use
    ## (not needed, since I don't complete _* functions at all)
    zstyle ':completion:*:functions' \
        list-colors "=_*=$color[red]"
    ### highlight the original input.
        zstyle ':completion:*:original' \
            list-colors "=*=$color[red];$color[bold]"
    ### highlight words like 'esac' or 'end'
        zstyle ':completion:*:reserved-words' \
            list-colors "=*=$color[red]"
    ### colorize processlist for 'kill'
        zstyle ':completion:*:*:kill:*:processes' \
            list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[cyan]=$color[yellow]=$color[green]"
    zstyle ':completion:*:*:perl:*'        file-patterns '*'
    zstyle ':completion:*:*:zathura:*'       tag-order files
    zstyle ':completion:*:*:zathura:*'       file-patterns '*(/)|*.{pdf,djvu}'
    # run rehash on completion so new installed program are found automatically:
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }
    ## correction
    # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
    if [[ "$NOCOR" -gt 0 ]] ; then
        zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
        setopt nocorrect
    else
        # try to be smart about when to use what completer...
        setopt correct
        zstyle -e ':completion:*' completer '
            if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
                _last_try="$HISTNO$BUFFER$CURSOR"
                reply=(_complete _match _ignored _prefix _files)
            else
                if [[ $words[1] == (rm|mv) ]] ; then
                    reply=(_complete _files)
                else
                    reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
                fi
            fi'
    fi

    # command for process lists, the local web server details and host completion
    # zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'
    # caching
    [[ -d $ZSHDIR/cache ]] && zstyle ':completion:*' use-cache yes && \
                            zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/
    # use generic completion system for programs not yet defined; (_gnu_generic works
    # with commands that provide a --help option with "standard" gnu-like output.)
    for compcom in cp deborphan df feh fetchipac head hnb ipacsum mv \
                   pal stow tail uname ; do
        [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
    done; unset compcom
    # see upgrade function in this file
    # compdef _hosts upgrade
}
mycompletion


__archive_or_uri()
{
    _alternative \
        'files:Archives:_files -g "*.(#l)(tar.bz2|tbz2|tbz|tar.gz|tgz|tar.xz|txz|tar.lzma|tar|rar|lzh|7z|zip|jar|deb|bz2|gz|Z|xz|lzma)"' \
        '_urls:Remote Archives:_urls'
}

_simple_extract() {
    _arguments \
        '-d[delete original archivefile after extraction]' \
        '*:Archive Or Uri:__archive_or_uri'
}
compdef _simple_extract simple-extract
