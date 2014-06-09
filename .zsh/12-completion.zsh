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
    zstyle ':completion:*:-tilde-:*'       group-order 'named-directories'
    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false
    # activate menu
    zstyle ':completion:*:history-words'   menu yes
    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes
    # match uppercase from lowercase
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''
    zstyle ':completion:*'                 menu select=5
    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'
    zstyle ':completion:*:options'         description 'yes'

    zstyle ':completion:*:*:-subscript-:*'  tag-order indexes parameters
    zstyle ':completion:*'                  verbose true
    zstyle ':completion:*:-command-:*:'     verbose false
    zstyle ':completion:*:warnings'         format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
    zstyle ':completion:*:*:zcompile:*'     ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'           prompt 'correct to: %e'
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
    zstyle ':completion:*:manuals'          separate-sections true
    zstyle ':completion:*:manuals.*'        insert-sections   true
    zstyle ':completion:*:man:*'            menu yes select
    zstyle ':completion:*'                  special-dirs ..
    zstyle ':completion:*'                  use-perl 'yes'
    # mplayer                                                                    {{{
    zstyle ':completion:*:(mv|cp|file|m|mplayer|mp|mpv):*'  ignored-patterns '(#i)*.(url|mht)'
    zstyle ':completion:*:*:mplayer:*'      tag-order files
    zstyle ':completion:*:*:mplayer:*'      file-sort name
    zstyle ':completion:*:*:mplayer:*'      menu select auto

    zstyle ':completion:*:*:mpv:*'          tag-order files
    zstyle ':completion:*:*:mpv:*'          file-sort name
    zstyle ':completion:*:*:mpv:*'          menu select auto
    
    zstyle ':completion:*:*:(*mplayer*|*mpv*):*' file-patterns '(#i)*.(rmvb|mkv|vob|mp4|m4a|iso|wmv|webm|flv|ogv|avi|mpg|mpeg|iso|nrg|mp3|flac|rm|wv|m4v):files:mplayer\ play *(-/):directories:directories'
    zstyle ':completion:*:default' list-colors ${${(s.:.)LS_COLORS}%ec=*}
    #----------------CLEAR OLD STUFF!!!!!!1
    zstyle ':completion:*:descriptions' format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%}%{${reset_color}%}"
    zstyle ':completion:*:messages'     format "- %{${fg[cyan]}%}%d%{${reset_color}%} -"
    zstyle ':completion:*:corrections'  format "%{${fg[blue]}%}--%{${reset_color}%} %d%{${reset_color}%} - (%{${fg[cyan]}%}errors %e%{${reset_color}%})"
    zstyle ':completion:*:default'      \
        select-prompt \
        "%{${fg[cyan]}%}Match %{${fg_bold[cyan]}%}%m%{${fg_no_bold[cyan]}%}  Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[blue]}%}  %p%{${reset_color}%}"
        zstyle ':completion:*:default'      \
        list-prompt   \
        "%{${fg[cyan]}%}Line %{${fg_bold[cyan]}%}%l%{${fg_no_bold[cyan]}%}  Continue?%{${reset_color}%}"
        zstyle ':completion:*:warnings'     \
        format        \
        "- %{${fg_no_bold[blue]}%}no match%{${reset_color}%} - %{${fg_no_bold[cyan]}%}%d%{${reset_color}%}"
    zstyle ':completion:*' group-name ''
    ### manual pages are sorted into sections
    zstyle ':completion:*:manuals'        separate-sections true
    zstyle ':completion:*:manuals.(^1*)'  insert-sections   true
    zstyle ':completion:*:wine:*'         file-patterns '*.(exe|EXE):exe'
    ### highlight parameters with uncommon names
        zstyle ':completion:*:parameters' list-colors "=[^a-zA-Z]*=$color[blue]"
    ### highlight aliases
        zstyle ':completion:*:aliases'    list-colors "=*=$color[green]"
    ## show that _* functions are not for normal use
    ## (not needed, since I don't complete _* functions at all)
    zstyle ':completion:*:functions'      list-colors "=_*=$color[blue]"
    ### highlight the original input.
    zstyle ':completion:*:original'       list-colors "=*=$color[blue];$color[bold]"
    ### highlight words like 'esac' or 'end'
    zstyle ':completion:*:reserved-words' list-colors "=*=$color[blue]"
    ### colorize processlist for 'kill'
    zstyle ':completion:*:*:kill:*:processes' \
        list-colors "=(#b) #([0-9]#) #([^ ]#)*=$color[cyan]=$color[yellow]=$color[green]"
    zstyle ':completion:*:*:perl:*'        file-patterns '*'
    zstyle ':completion:*:*:zathura:*'     tag-order files
    zstyle ':completion:*:*:zathura:*'     file-patterns '*(/)|*.{pdf,djvu}'
    # make them a little less short, after all (mostly adds -l option to the whatis calll)
    zstyle ':completion:*:command-descriptions' command '_call_whatis -l -s 1 -r .\*; _call_whatis -l -s 6 -r .\* 2>/dev/null'
    zstyle :complete-recent-args use-histbang yes
    #-------new ----------------------
    # command completion: highlight matching part of command, and 
    zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;248'\'' )'

    # This is needed to workaround a bug in _setup:12, causing almost 2 seconds delay for bigger LS_COLORS
    # UPDATE: not sure if this is required anymore, with the -command- style above.. keeping it here just to be sure
    zstyle ':completion:*:*:-command-:*' list-colors ''
    # run rehash on completion so new installed program are found automatically:
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }
    ## correction
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

() {
    local -a coreutils
    coreutils=(
        # /bin
        cat chgrp chmod chown cp date dd df dir ln ls mkdir mknod mv readlink
        rm rmdir vdir sleep stty sync touch uname mktemp
        # /usr/bin
        install hostid nice who users pinky stdbuf base64 basename chcon cksum
        comm csplit cut dircolors dirname du env expand factor fmt fold groups
        head id join link logname md5sum mkfifo nl nproc nohup od paste pathchk
        pr printenv ptx runcon seq sha1sum sha224sum sha256sum sha384sum
        sha512sum shred shuf sort split stat sum tac tail tee timeout tr
        truncate tsort tty unexpand uniq unlink wc whoami yes arch touch
    )

    for i in $coreutils; do
        # all which don't already have one
        # at time of this writing, those are:
        # /bin
        #   chgrp chmod chown cp date dd df ln ls mkdir rm rmdir stty sync
        #   touch uname
        # /usr/bin
        #   nice comm cut du env groups id join logname md5sum nohup printenv
        #   sort stat unexpand uniq whoami
        (( $+_comps[$i] )) || compdef _gnu_generic $i 
    done

}

mycompletion

__archive_or_uri(){
    _alternative \
        'files:Archives:_files -g "*.(#l)(tar.bz2|tbz2|tbz|tar.gz|tgz|tar.xz|txz|tar.lzma|tar|rar|lzh|7z|zip|jar|deb|bz2|gz|Z|xz|lzma)"' \
        '_urls:Remote Archives:_urls'
}
_simple_extract(){
    _arguments \
        '-d[delete original archivefile after extraction]' \
        '*:Archive Or Uri:__archive_or_uri'
}
compdef _simple_extract simple-extract

autoload -U select-word-style backward-kill-word-match backward-word-match forward-word-match
select-word-style shell

zle -N backward-kill-word-match
zle -N backward-word-match
zle -N forward-word-match

# for backward-kill, all but / are word chars (ie, delete word up to last directory)
zstyle ':zle:backward-kill-word*' word-style standard
zstyle ':zle:*kill*' word-chars '*?_-.[]~=&;!#$%^(){}<>'
