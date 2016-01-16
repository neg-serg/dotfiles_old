#!/bin/zsh

ZSH_HIGHLIGHT_STYLES+=(
    default                        'none'
    #unknown-token                 'fg=88,bg=234'
    suffix-alias                    fg=green,underline
    reserved-word                  'fg=004'
    alias                          'fg=green'
    builtin                        'fg=green'
    function                       'fg=green,underline'
    command                        'fg=green'

    #precommand                    'fg=green,underline'
    #path                          'underline'
    #path_prefix                   'fg=underline'
    #path_approx                   'fg=yellow,underline'

    hashed-command                 'fg=green'
    globbing                       'fg=110'
    history-expansion              'fg=blue'
    single-hyphen-option           'fg=242'
    double-hyphen-option           'fg=244'
    # comment                      'fg=222'
    # redirection                  'none'
    # commandseparator             'none'

    back-quoted-argument           'fg=024,bold'
    single-quoted-argument         'fg=024'
    double-quoted-argument         'fg=024'
    dollar-double-quoted-argument  'fg=004,bold'
    back-double-quoted-argument    'fg=024,bold'
    back-dollar-quoted-argument    'fg=024,bold'
    assign                         'fg=240,bold'

    ftype-exe           'fg=111'
    ftype-com           'fg=111'
    ftype-btm           'fg=111'
    ftype-bat           'fg=108'
    ftype-cmd           'fg=108'
    ftype-tar           'fg=61'
    ftype-tgz           'fg=61,bold'
    ftype-taz           'fg=61,bold'
    ftype-lzh           'fg=61,bold'
    ftype-lzma          'fg=61,bold'
    ftype-tlz           'fg=61,bold'
    ftype-txz           'fg=61,bold'
    ftype-zip           'fg=61,bold'
    ftype-ZIP           'fg=61,bold'
    ftype-z             'fg=61,bold'
    ftype-Z             'fg=61,bold'
    ftype-dz            'fg=61,bold'
    ftype-gz            'fg=61,bold'
    ftype-lz            'fg=61,bold'
    ftype-xz            'fg=61,bold'
    ftype-bz2           'fg=61,bold'
    ftype-bz            'fg=61,bold'
    ftype-tbz           'fg=61,bold'
    ftype-tbz2          'fg=61,bold'
    ftype-tz            'fg=61,bold'
    ftype-rar           'fg=63'
    ftype-ace           'fg=61,bold'
    ftype-zoo           'fg=61,bold'
    ftype-cpio          'fg=61,bold'
    ftype-7z            'fg=61,bold'
    ftype-lrz           'fg=61,bold'
    ftype-rz            'fg=61,bold'
    ftype-z             'fg=61,bold'
    ftype-Z             'fg=61,bold'
    ftype-jar           'fg=67'
    ftype-arj           'fg=67'
    ftype-rpm           'fg=68'
    ftype-cab           'fg=68'
    ftype-deb           'fg=68'
    ftype-udeb          'fg=68'
    ftype-apk           'fg=68'
    ftype-xpi           'fg=68'
    ftype-egg           'fg=68'
    ftype-pkg           'fg=68'
    ftype-jad           'fg=68'
    ftype-gem           'fg=68'
    ftype-msi           'fg=68'
    ftype-qcow          'fg=61'
    ftype-qcow2         'fg=61'
    ftype-vmdk          'fg=61'
    ftype-vdi           'fg=61'
    ftype-jpg           'fg=24'
    ftype-JPG           'fg=24'
    ftype-jpeg          'fg=24'
    ftype-bmp           'fg=110,bold'
    ftype-pbm           'fg=110'
    ftype-pgm           'fg=110'
    ftype-ppm           'fg=110'
    ftype-tga           'fg=110'
    ftype-psd           'fg=110'
    ftype-xbm           'fg=111'
    ftype-xpm           'fg=36'
    ftype-tif           'fg=33'
    ftype-tiff          'fg=33'
    ftype-png           'fg=24,bold'
    ftype-mng           'fg=24'
    ftype-pcx           'fg=24'
    ftype-dl            'fg=24'
    ftype-xcf           'fg=24,bold'
    ftype-xwd           'fg=24,bold'
    ftype-yuv           'fg=24,bold'
    ftype-cgm           'fg=24,bold'
    ftype-emf           'fg=24,bold'
    ftype-eps           'fg=24,bold'
    ftype-CR2           'fg=24,bold'
    ftype-svg           'fg=25'
    ftype-svgz          'fg=25'
    ftype-gif           'fg=25,bold'
    ftype-ico           'fg=25,bold'
    ftype-icns          'fg=25,bold'
    ftype-log           'fg=240'
    ftype-bak           'fg=240'
    ftype-aux           'fg=240'
    ftype-bbl           'fg=240'
    ftype-blg           'fg=240'
    ftype-part          'fg=240'
    ftype-incomplete    'fg=240'
    ftype-swp           'fg=240'
    ftype-tmp           'fg=240'
    ftype-temp          'fg=240'
    ftype-o             'fg=240'
    ftype-pyc           'fg=240'
    ftype-class         'fg=240'
    ftype-cache         'fg=240'
    ftype-djvu          'fg=250'
    ftype-djv           'fg=250'
    ftype-pdf           'fg=7,bold'
    ftype-epub          'fg=7'
    ftype-mobi          'fg=7'
    ftype-lit           'fg=7'
    ftype-fb2           'fg=7'
    ftype-dvi           'fg=7'
    ftype-chm           'fg=250'
    ftype-markdown      'fg=110'
    ftype-mkd           'fg=110'
    ftype-md            'fg=110'
    ftype-mf            'fg=110,3'
    ftype-mfasl         'fg=73'
    ftype-txt           'fg=60'
    ftype-rtf           'fg=30'
    ftype-doc           'fg=30'
    ftype-docx          'fg=30'
    ftype-docm          'fg=30'
    ftype-dot           'fg=30'
    ftype-dotm          'fg=30'
    ftype-odt           'fg=30'
    ftype-odm           'fg=30'
    ftype-pages         'fg=30'
    ftype-xla           'fg=14'
    ftype-xls           'fg=14'
    ftype-xlsx          'fg=14'
    ftype-xlsm          'fg=14'
    ftype-gnumeric      'fg=14'
    ftype-chrt          'fg=14,bold'
    ftype-ppt           'fg=222'
    ftype-pptx          'fg=222'
    ftype-ods           'fg=29'
    ftype-odp           'fg=29'
    ftype-odb           'fg=29'
    ftype-db            'fg=60'
    ftype-sqlite        'fg=99'
    ftype-db            'fg=99'
    ftype-mdf           'fg=99'
    ftype-ldf           'fg=99'
    ftype-mdb           'fg=99'
    ftype-odb           'fg=99'
    ftype-asm           'fg=228'
    ftype-asoundrc      'fg=6'
    ftype-awk           'fg=6'
    ftype-coffee        'fg=6'
    ftype-cs            'fg=6'
    ftype-css           'fg=222'
    ftype-scss          'fg=222'
    ftype-sass          'fg=222'
    ftype-csv           'fg=6'
    ftype-dir_colors    'fg=3,bold'
    ftype-enc           'fg=6'
    ftype-ps            'fg=248'
    ftype-eps           'fg=248'
    ftype-epsi          'fg=248'
    ftype-epsf          'fg=248'
    ftype-eps2          'fg=248'
    ftype-eps3          'fg=248'
    ftype-etx           'fg=6'
    ftype-ex            'fg=6'
    ftype-example       'fg=6'
    ftype-fehbg         'fg=6'
    ftype-fonts         'fg=6'
    ftype-git           'fg=6'
    ftype-gitignore     'fg=238'
    ftype-htm           'fg=77'
    ftype-html          'fg=77'
    ftype-jhtm          'fg=77,bold'
    ftype-hgrc          'fg=23,bold'
    ftype-hgignore      'fg=23,bold'
    ftype-hs            'fg=200'
    ftype-htoprc        'fg=23,bold'
    ftype-info          'fg=23,bold'
    ftype-java          'fg=215,bold'
    ftype-js            'fg=200'
    ftype-jsm           'fg=68'
    ftype-jsp           'fg=68'
    ftype-lisp          'fg=68'
    ftype-lesshst       'fg=23,bold'
    ftype-log           'fg=23,bold'
    ftype-lua           'fg=23,bold'
    ftype-map           'fg=2,bold'
    ftype-mf            'fg=2,bold'
    ftype-mfasl         'fg=2,bold'
    ftype-mi            'fg=2,bold'
    ftype-msmtprc       'fg=2,bold'
    ftype-mtx           'fg=2,bold'
    ftype-muttrc        'fg=2,bold'
    ftype-nfo           'fg=2,bold'
    ftype-netrc         'fg=1,bold'
    ftype-offlineimaprc 'fg=2,bold'
    ftype-pacnew        'fg=33,bold'
    ftype-patch         'bg=7,fg=16,bold'
    ftype-diff          'bg=7,fg=16,bold'
    ftype-pc            'fg=1'
    ftype-pfa           'fg=1'
    ftype-php           'fg=1'
    ftype-pid           'fg=1'
    ftype-pl            'fg=67,bold'
    ftype-PL            'fg=6'
    ftype-pm            'fg=1'
    ftype-pod           'fg=23,bold'
    ftype-py            'fg=30,bold'
    ftype-rc            'fg=1'
    ftype-rb            'fg=32,bold'
    ftype-ru            'fg=1'
    ftype-sed           'fg=1'
    ftype-signature     'fg=1'
    ftype-sty           'fg=5,bold'
    ftype-sug           'fg=5,bold'
    ftype-t             'fg=5,bold'
    ftype-tcl           'fg=225'
    ftype-tk            'fg=225'
    ftype-tdy           'fg=5,bold'
    ftype-tfm           'fg=5,bold'
    ftype-tfnt          'fg=5,bold'
    ftype-theme         'fg=5,bold'
    ftype-viminfo       'fg=221'
    ftype-vim           'fg=221'
    ftype-vimrc         'fg=221,underline'
    ftype-sh            'fg=103,bold'
    ftype-sh*           'fg=103,bold'
    ftype-bash          'fg=103,bold'
    ftype-dash          'fg=103,bold'
    ftype-bash_history  'fg=103,bold'
    ftype-zsh           'fg=103,bold'
    ftype-csh           'fg=103,bold'
    ftype-ksh           'fg=103,bold'
    ftype-tcsh          'fg=103,bold'
    ftype-zshrc         'fg=77,underline,bold'
    ftype-profile       'fg=77,underline,bold'
    ftype-bash_profile  'fg=77,underline,bold'
    ftype-bash_logout   'fg=77,underline,bold'
    ftype-bashrc        'fg=77,underline,bold'
    ftype-ttytterrc     'fg=5,bold'
    ftype-urlview       'fg=5,bold'
    ftype-xinitrc       'fg=1,bold'
    ftype-Xauthority    'fg=1,bold'
    ftype-Xmodmap       'fg=1'
    ftype-Xresources    'fg=3,bold'
    ftype-iso           'fg=141,bold'
    ftype-img           'fg=141,bold'
    ftype-dmg           'fg=141,bold'
    ftype-vcd           'fg=141,bold'
    ftype-ISO           'fg=141,bold'
    ftype-nrg           'fg=141,bold'
    ftype-mdf           'fg=141,bold'
    ftype-tex           'fg=73'
    ftype-latex         'fg=73'
    ftype-textile       'fg=60'
    ftype-rdf           'fg=60'
    ftype-owl           'fg=60'
    ftype-n3            'fg=60'
    ftype-rc            'fg=60'
    ftype-ttl           'fg=60'
    ftype-nt            'fg=60'
    ftype-torrent       'fg=60'
    ftype-jidgo         'fg=60'
    ftype-xml           'fg=60'
    ftype-nfo           'fg=60'
    ftype-yml           'fg=77'
    ftype-cfg           'fg=77'
    ftype-ini           'fg=77'
    ftype-conf          'fg=77'
    ftype-yml           'fg=77'
    ftype-json          'fg=77,bold'
    ftype-aux           'fg=239'
    ftype-md5           'fg=244'
    ftype-sfv           'fg=244'
    ftype-sha1          'fg=244'
    ftype-st5           'fg=244'
    ftype-ffp           'fg=244'
    ftype-par           'fg=244'
    ftype-flac          'fg=108,bold'
    ftype-alac          'fg=108,bold'
    ftype-wav           'fg=108,bold'
    ftype-aac           'fg=108'
    ftype-au            'fg=108'
    ftype-mid           'fg=108'
    ftype-midi          'fg=108'
    ftype-mka           'fg=108'
    ftype-mp2           'fg=108'
    ftype-mp3           'fg=108'
    ftype-wma           'fg=108'
    ftype-mpc           'fg=108'
    ftype-ogg           'fg=108'
    ftype-ra            'fg=108'
    ftype-m4a           'fg=108'
    ftype-m4b           'fg=108'
    ftype-m4r           'fg=108'
    ftype-axa           'fg=108'
    ftype-oga           'fg=108'
    ftype-spx           'fg=108'
    ftype-m3u8          'fg=28'
    ftype-m3u           'fg=28'
    ftype-pls           'fg=28'
    ftype-cue           'fg=28'
    ftype-xspf          'fg=28'
    ftype-S3M           'fg=5,bold'
    ftype-dat           'fg=5'
    ftype-fcm           'fg=5'
    ftype-m4            'fg=5'
    ftype-mod           'fg=5'
    ftype-oga           'fg=5'
    ftype-s3m           'fg=5,bold'
    ftype-sid           'fg=5,bold'
    ftype-spl           'fg=5'
    ftype-wv            'fg=5'
    ftype-wvc           'fg=5'
    ftype-mov           'fg=12,bold'
    ftype-MOV           'fg=12,bold'
    ftype-mpg           'fg=12,bold'
    ftype-mpeg          'fg=12,bold'
    ftype-m2v           'fg=12,bold'
    ftype-mkv           'fg=12,bold'
    ftype-ogm           'fg=12,bold'
    ftype-mp4           'fg=12,bold'
    ftype-VOB           'fg=12,bold'
    ftype-m4v           'fg=12,bold'
    ftype-mp4v          'fg=12,bold'
    ftype-vob           'fg=12,bold'
    ftype-qt            'fg=12,bold'
    ftype-nuv           'fg=12,bold'
    ftype-wmv           'fg=12,bold'
    ftype-asf           'fg=12,bold'
    ftype-rm            'fg=12,bold'
    ftype-rmvb          'fg=12,bold'
    ftype-flc           'fg=12,bold'
    ftype-avi           'fg=12,bold'
    ftype-AVI           'fg=12,bold'
    ftype-fli           'fg=12,bold'
    ftype-flv           'fg=12,bold'
    ftype-gl            'fg=12,bold'
    ftype-m2ts          'fg=12,bold'
    ftype-divx          'fg=12,bold'
    ftype-webm          'fg=12,bold'
    ftype-ogv           'fg=12,bold'
    ftype-sample        'fg=12,bold'
    ftype-ts            'fg=12'
    ftype-axv           'fg=13,bold'
    ftype-anx           'fg=13,bold'
    ftype-ogx           'fg=13,bold'
    ftype-srt           'fg=116,bold'
    ftype-ttf           'fg=65,bold'
    ftype-otf           'fg=65,bold'
    ftype-pcf           'fg=65'
    ftype-bdf           'fg=65'
    ftype-fon           'fg=65,bold'
    ftype-dfont         'fg=65,bold'
    ftype-pfa           'fg=65'
    ftype-pfb           'fg=65'
    ftype-gsf           'fg=65'
    ftype-service       'fg=81'
    ftype-socket        'fg=75'
    ftype-device        'fg=24'
    ftype-mount         'fg=115'
    ftype-automount     'fg=114'
    ftype-swap          'fg=113'
    ftype-target        'fg=73'
    ftype-path          'fg=116'
    ftype-timer         'fg=111'
    ftype-snapshot      'fg=139'
    ftype-c             'fg=24,bold'
    ftype-C             'fg=24,bold'
    ftype-cp            'fg=24,bold'
    ftype-cc            'fg=24,bold'
    ftype-cpp           'fg=24,bold'
    ftype-cxx           'fg=24,bold'
    ftype-c++           'fg=24,bold'
    ftype-ii            'fg=24,bold'
    ftype-cs            'fg=74,bold'
    ftype-rs            'fg=74,bold'
    ftype-go            'fg=227'
    ftype-erl           'fg=227'
    ftype-ml            'fg=227'
    ftype-scala         'fg=227'
    ftype-H             'fg=29'
    ftype-hpp           'fg=29'
    ftype-hxx           'fg=29'
    ftype-h++           'fg=29'
    ftype-tcc           'fg=29'
    ftype-f             'fg=29'
    ftype-for           'fg=29'
    ftype-ftn           'fg=29'
    ftype-s             'fg=29'
    ftype-S             'fg=29'
    ftype-sx            'fg=29'
    ftype-am            'fg=242'
    ftype-in            'fg=242'
    ftype-old           'fg=242'
    ftype-pcap          'fg=29'
    ftype-cap           'fg=29'
    ftype-dmp           'fg=29'
    ftype-am            'fg=242'
    ftype-in            'fg=242'
    ftype-old           'fg=242'
)

# Whether the highlighter should be called or not.
_zsh_highlight_main_highlighter_predicate()
{
    # accept-* may trigger removal of path_prefix highlighting
    [[ $WIDGET == accept-* ]] ||
        _zsh_highlight_buffer_modified
}

# Helper to deal with tokens crossing line boundaries.
_zsh_highlight_main_add_region_highlight() {
    integer start=$1 end=$2
    local style=$3

    # The calculation was relative to $PREBUFFER$BUFFER, but region_highlight is
    # relative to $BUFFER.
    (( start -= $#PREBUFFER ))
    (( end -= $#PREBUFFER ))

    (( end < 0 )) && return # having end<0 would be a bug
    (( start < 0 )) && start=0 # having start<0 is normal with e.g. multiline strings
    region_highlight+=("$start $end $style")
}

# Wrapper around 'type -w'.
#
# Takes a single argument and outputs the output of 'type -w $1'.
#
# NOTE: This runs 'setopt', but that should be safe since it'll only ever be
# called inside a $(...) subshell, so the effects will be local.
_zsh_highlight_main__type() {
    if (( $#options_to_set )); then
        setopt $options_to_set;
    fi
    LC_ALL=C builtin type -w -- $1 2>/dev/null
}

# Main syntax highlighting function.
_zsh_highlight_main_highlighter() {
    ## Before we even 'emulate -L', we must test a few options that would reset.
    if [[ -o interactive_comments ]]; then
        local interactive_comments= # set to empty
    fi
    if [[ -o path_dirs ]]; then
        integer path_dirs_was_set=1
    else
        integer path_dirs_was_set=0
    fi
    emulate -L zsh
    setopt localoptions extendedglob bareglobqual

    ## Variable declarations and initializations
    local start_pos=0 end_pos highlight_glob=true arg style
    local in_array_assignment=false # true between 'a=(' and the matching ')'
    typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
    typeset -a ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
    typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
    local -a options_to_set # used in callees
    local buf="$PREBUFFER$BUFFER"
    region_highlight=()

    if (( path_dirs_was_set )); then
        options_to_set+=( PATH_DIRS )
    fi
    unset path_dirs_was_set

    ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=(
        '|' '||' ';' '&' '&&'
        '|&'
        '&!' '&|'
        # ### 'case' syntax, but followed by a pattern, not by a command
        # ';;' ';&' ';|'
    )
    ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS=(
        'builtin' 'command' 'exec' 'nocorrect' 'noglob' 'sudo' 's'
        'pkexec' # immune to #121 because it's usually not passed --option flags
    )

    # Tokens that, at (naively-determined) "command position", are followed by
    # a de jure command position.  All of these are reserved words.
    ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW=(
        $'\x7b' # block
        $'\x28' # subshell
        '()' # anonymous function
        'while'
        'until'
        'if'
        'then'
        'elif'
        'else'
        'do'
        'time'
        'coproc'
        '!' # reserved word; unrelated to $histchars[1]
    )


    # State machine
    #
    # The states are:
    # - :start:      Command word
    # - :sudo_opt:   A leading-dash option to sudo (such as "-u" or "-i")
    # - :sudo_arg:   The argument to a sudo leading-dash option that takes one,
    #                when given as a separate word; i.e., "foo" in "-u foo" (two
    #                words) but not in "-ufoo" (one word).
    # - :regular:    "Not a command word", and command delimiters are permitted.
    #                Mainly used to detect premature termination of commands.
    #
    # When the kind of a word is not yet known, $this_word / $next_word may contain
    # multiple states.  For example, after "sudo -i", the next word may be either
    # another --flag or a command name, hence the state would include both :start:
    # and :sudo_opt:.
    #
    # The tokens are always added with both leading and trailing colons to serve as
    # word delimiters (an improvised array); [[ $x == *:foo:* ]] and x=${x//:foo:/} 
    # will DTRT regardless of how many elements or repetitions $x has..
    #
    # Handling of redirections: upon seeing a redirection token, we must stall
    # the current state --- that is, the value of $this_word --- for two iterations
    # (one for the redirection operator, one for the word following it representing
    # the redirection target).  Therefore, we set $in_redirection to 2 upon seeing a
    # redirection operator, decrement it each iteration, and stall the current state
    # when it is non-zero.  Thus, upon reaching the next word (the one that follows
    # the redirection operator and target), $this_word will still contain values
    # appropriate for the word immediately following the word that preceded the
    # redirection operator.
    #
    # The "the previous word was a redirection operator" state is not communicated
    # to the next iteration via $next_word/$this_word as usual, but via
    # $in_redirection.  The value of $next_word from the iteration that processed
    # the operator is discarded.
    #
    local this_word=':start:' next_word
    integer in_redirection
    for arg in ${interactive_comments-${(z)buf}} \
                ${interactive_comments+${(zZ+c+)buf}}; do
        if (( in_redirection )); then
            (( --in_redirection ))
        fi
        if (( in_redirection == 0 )); then
            # Initialize $next_word to its default value.
            next_word=':regular:'
        else
            # Stall $next_word.
        fi
        # $already_added is set to 1 to disable adding an entry to region_highlight
        # for this iteration.  Currently, that is done for "" and $'' strings,
        # which add the entry early so escape sequences within the string override
        # the string's color.
        integer already_added=0
        local style_override=""
        if [[ $this_word == *':start:'* ]]; then
            in_array_assignment=false
            if [[ $arg == 'noglob' ]]; then
                highlight_glob=false
            fi
        fi

        # advance $start_pos, skipping over whitespace in $buf.
        if [[ $arg == ';' ]] ; then
        # We're looking for either a semicolon or a newline, whichever comes
        # first.  Both of these are rendered as a ";" (SEPER) by the ${(z)..}
        # flag.
        #
        # We can't use the (Z+n+) flag because that elides the end-of-command
        # token altogether, so 'echo foo\necho bar' (two commands) becomes
        # indistinguishable from 'echo foo echo bar' (one command with three
        # words for arguments).
        local needle=$'[;\n]'
        integer offset=${${buf[start_pos+1,-1]}[(i)$needle]}
        (( start_pos += offset - 1 ))
        (( end_pos = start_pos + $#arg ))
        else
        ((start_pos+=${#buf[$start_pos+1,-1]}-${#${buf[$start_pos+1,-1]##([[:space:]]|\\[[:space:]])#}}))
        ((end_pos=$start_pos+${#arg}))
        fi

        if [[ -n ${interactive_comments+'set'} && $arg[1] == $histchars[3] ]]; then
            if [[ $this_word == *(':regular:'|':start:')* ]]; then
                style=$ZSH_HIGHLIGHT_STYLES[comment]
            else
                style=$ZSH_HIGHLIGHT_STYLES[unknown-token] # prematurely terminated
            fi
            _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
            already_added=1
            continue
        fi

        # Parse the sudo command line
        if (( ! in_redirection )); then
            if [[ $this_word == *':sudo_opt:'* ]]; then
                case "$arg" in
                # Flag that requires an argument
                '-'[Cgprtu]) this_word=${this_word//:start:/};
                            next_word=':sudo_arg:';;
                # This prevents misbehavior with sudo -u -otherargument
                '-'*)        this_word=${this_word//:start:/};
                            next_word+=':start:';
                            next_word+=':sudo_opt:';;
                *)           ;;
                esac
            elif [[ $this_word == *':sudo_arg:'* ]]; then
                next_word+=':sudo_opt:'
                next_word+=':start:'
            fi
        fi

        if [[ $this_word == *':start:'* ]] && (( in_redirection == 0 )); then # $arg is the command word
            if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]]; then
                style=$ZSH_HIGHLIGHT_STYLES[precommand]
            elif [[ "$arg" = "sudo" ]]; then
                style=$ZSH_HIGHLIGHT_STYLES[precommand]
                next_word=${next_word//:regular:/}
                next_word+=':sudo_opt:'
                next_word+=':start:'
        else
            _zsh_highlight_main_highlighter_expand_path $arg
            local expanded_arg="$REPLY"
            local res="$(_zsh_highlight_main__type ${expanded_arg})"
            () {
                # Special-case: command word is '$foo', like that, without braces or anything.
                #
                # That's not entirely correct --- if the parameter's value happens to be a reserved
                # word, the parameter expansion will be highlighted as a reserved word --- but that
                # incorrectness is outweighed by the usability improvement of permitting the use of
                # parameters that refer to commands, functions, and builtins.
                local -a match mbegin mend
                local MATCH; integer MBEGIN MEND
                if [[ $res == *': none' ]] && (( ${+parameters} )) &&
                [[ ${arg[1]} == \$ ]] && [[ ${arg:1} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+)$ ]]; then
                res="$(_zsh_highlight_main__type ${(P)MATCH})"
                fi
            }
        case $res in
            *': reserved')  style=$ZSH_HIGHLIGHT_STYLES[reserved-word];;
            *': suffix alias')
                            style=$ZSH_HIGHLIGHT_STYLES[suffix-alias]
                            ;;
            *': alias')     () {
                            integer insane_alias
                            case $arg in 
                                # Issue #263: aliases with '=' on their LHS.
                                #
                                # There are three cases:
                                #
                                # - Unsupported, breaks 'alias -L' output, but invokable:
                                ('='*) :;;
                                # - Unsupported, not invokable:
                                (*'='*) insane_alias=1;;
                                # - The common case:
                                (*) :;;
                            esac
                            if (( insane_alias )); then
                                style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                            else
                                style=$ZSH_HIGHLIGHT_STYLES[alias]
                                local aliased_command="${"$(alias -- $arg)"#*=}"
                                [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$aliased_command"} && -z ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} ]] && ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS+=($arg)
                            fi
                            }
                            ;;
            *': builtin')   style=$ZSH_HIGHLIGHT_STYLES[builtin];;
            *': function')  style=$ZSH_HIGHLIGHT_STYLES[function];;
            *': command')   style=$ZSH_HIGHLIGHT_STYLES[command];;
            *': hashed')    style=$ZSH_HIGHLIGHT_STYLES[hashed-command];;
            *)              if _zsh_highlight_main_highlighter_check_assign; then
                            style=$ZSH_HIGHLIGHT_STYLES[assign]
                            if [[ $arg[-1] == '(' ]]; then
                                in_array_assignment=true
                            else
                                # assignment to a scalar parameter.
                                # (For array assignments, the command doesn't start until the ")" token.)
                                next_word+=':start:'
                            fi
                            elif [[ $arg[0,1] == $histchars[0,1] || $arg[0,1] == $histchars[2,2] ]]; then
                            style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                            elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                            if [[ $this_word == *':regular:'* ]]; then
                                # This highlights empty commands (semicolon follows nothing) as an error.
                                # Zsh accepts them, though.
                                style=$ZSH_HIGHLIGHT_STYLES[commandseparator]
                            else
                                style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                            fi
                            elif [[ $arg == (<0-9>|)(\<|\>)* ]]; then
                            # A '<' or '>', possibly followed by a digit
                            style=$ZSH_HIGHLIGHT_STYLES[redirection]
                            (( in_redirection=2 ))
                            elif [[ $arg[1,2] == '((' ]]; then
                                # Arithmetic evaluation.
                                #
                                # Note: prior to zsh-5.1.1-52-g4bed2cf (workers/36669), the ${(z)...}
                                # splitter would only output the '((' token if the matching '))' had
                                # been typed.  Therefore, under those versions of zsh, BUFFER="(( 42"
                                # would be highlighted as an error until the matching "))" are typed.
                                #
                                # We highlight just the opening parentheses, as a reserved word; this
                                # is how [[ ... ]] is highlighted, too.
                                style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                                _zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) $style
                                already_added=1
                                if [[ $arg[-2,-1] == '))' ]]; then
                                    _zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos $style
                                    already_added=1
                                fi
                            elif [[ $arg == '()' || $arg == $'\x28' ]]; then
                                # anonymous function
                                # subshell
                                style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                                else
                                if _zsh_highlight_main_highlighter_check_path; then
                                    style=$ZSH_HIGHLIGHT_STYLES[path]
                                else
                                    style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                                fi
                            fi
                            ;;
            esac
        fi
        else # $arg is a non-command word
        case $arg in
            $'\x29') # subshell or end of array assignment
                    if $in_array_assignment; then
                        style=$ZSH_HIGHLIGHT_STYLES[assign]
                        in_array_assignment=false
                    else
                        style=$ZSH_HIGHLIGHT_STYLES[reserved-word]
                    fi;;
            $'\x7d') style=$ZSH_HIGHLIGHT_STYLES[reserved-word];; # block
            *.exe)             style=$ZSH_HIGHLIGHT_STYLES[ftype-exe];;
            *.com)             style=$ZSH_HIGHLIGHT_STYLES[ftype-com];;
            *.btm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-btm];;
            *.bat)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bat];;
            *.cmd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cmd];;
            *.tar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tar];;
            *.tgz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tgz];;
            *.taz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-taz];;
            *.lzh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lzh];;
            *.lzma)            style=$ZSH_HIGHLIGHT_STYLES[ftype-lzma];;
            *.tlz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tlz];;
            *.txz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-txz];;
            *.zip)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zip];;
            *.ZIP)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ZIP];;
            *.z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-z];;
            *.Z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-Z];;
            *.dz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-dz];;
            *.gz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gz];;
            *.lz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-lz];;
            *.xz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-xz];;
            *.bz2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bz2];;
            *.bz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-bz];;
            *.tbz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tbz];;
            *.tbz2)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tbz2];;
            *.tz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-tz];;
            *.rar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rar];;
            *.ace)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ace];;
            *.zoo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zoo];;
            *.cpio)            style=$ZSH_HIGHLIGHT_STYLES[ftype-cpio];;
            *.7z)              style=$ZSH_HIGHLIGHT_STYLES[ftype-7z];;
            *.lrz)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lrz];;
            *.rz)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rz];;
            *.z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-z];;
            *.Z)               style=$ZSH_HIGHLIGHT_STYLES[ftype-Z];;
            *.jar)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jar];;
            *.arj)             style=$ZSH_HIGHLIGHT_STYLES[ftype-arj];;
            *.rpm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rpm];;
            *.cab)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cab];;
            *.deb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-deb];;
            *.udeb)            style=$ZSH_HIGHLIGHT_STYLES[ftype-udeb];;
            *.apk)             style=$ZSH_HIGHLIGHT_STYLES[ftype-apk];;
            *.xpi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xpi];;
            *.egg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-egg];;
            *.pkg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pkg];;
            *.jad)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jad];;
            *.gem)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gem];;
            *.msi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-msi];;
            *.qcow)            style=$ZSH_HIGHLIGHT_STYLES[ftype-qcow];;
            *.qcow2)           style=$ZSH_HIGHLIGHT_STYLES[ftype-qcow2];;
            *.vmdk)            style=$ZSH_HIGHLIGHT_STYLES[ftype-vmdk];;
            *.vdi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vdi];;
            *.jpg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jpg];;
            *.JPG)             style=$ZSH_HIGHLIGHT_STYLES[ftype-JPG];;
            *.jpeg)            style=$ZSH_HIGHLIGHT_STYLES[ftype-jpeg];;
            *.bmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bmp];;
            *.pbm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pbm];;
            *.pgm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pgm];;
            *.ppm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ppm];;
            *.tga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tga];;
            *.psd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-psd];;
            *.xbm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xbm];;
            *.xpm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xpm];;
            *.tif)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tif];;
            *.tiff)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tiff];;
            *.png)             style=$ZSH_HIGHLIGHT_STYLES[ftype-png];;
            *.mng)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mng];;
            *.pcx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pcx];;
            *.dl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-dl];;
            *.xcf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xcf];;
            *.xwd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xwd];;
            *.yuv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yuv];;
            *.cgm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cgm];;
            *.emf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-emf];;
            *.eps)             style=$ZSH_HIGHLIGHT_STYLES[ftype-eps];;
            *.CR2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-CR2];;
            *.svg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-svg];;
            *.svgz)            style=$ZSH_HIGHLIGHT_STYLES[ftype-svgz];;
            *.gif)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gif];;
            *.ico)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ico];;
            *.icns)            style=$ZSH_HIGHLIGHT_STYLES[ftype-icns];;
            *.log)             style=$ZSH_HIGHLIGHT_STYLES[ftype-log];;
            *.bak)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bak];;
            *.aux)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aux];;
            *.bbl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bbl];;
            *.blg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-blg];;
            *.part)            style=$ZSH_HIGHLIGHT_STYLES[ftype-part];;
            *.incomplete)      style=$ZSH_HIGHLIGHT_STYLES[ftype-incomplete];;
            *.swp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-swp];;
            *.tmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tmp];;
            *.temp)            style=$ZSH_HIGHLIGHT_STYLES[ftype-temp];;
            *.o)               style=$ZSH_HIGHLIGHT_STYLES[ftype-o];;
            *.pyc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pyc];;
            *.class)           style=$ZSH_HIGHLIGHT_STYLES[ftype-class];;
            *.cache)           style=$ZSH_HIGHLIGHT_STYLES[ftype-cache];;
            *.djvu)            style=$ZSH_HIGHLIGHT_STYLES[ftype-djvu];;
            *.djv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-djv];;
            *.pdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pdf];;
            *.epub)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epub];;
            *.mobi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mobi];;
            *.lit)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lit];;
            *.fb2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fb2];;
            *.dvi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dvi];;
            *.chm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-chm];;
            *.markdown)        style=$ZSH_HIGHLIGHT_STYLES[ftype-markdown];;
            *.mkd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mkd];;
            *.md)              style=$ZSH_HIGHLIGHT_STYLES[ftype-md];;
            *.mf)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mf];;
            *.mfasl)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mfasl];;
            *.txt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-txt];;
            *.rtf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rtf];;
            *.doc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-doc];;
            *.docx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-docx];;
            *.docm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-docm];;
            *.dot)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dot];;
            *.dotm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-dotm];;
            *.odt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odt];;
            *.odm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odm];;
            *.pages)           style=$ZSH_HIGHLIGHT_STYLES[ftype-pages];;
            *.xla)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xla];;
            *.xls)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xls];;
            *.xlsx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xlsx];;
            *.xlsm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xlsm];;
            *.gnumeric)        style=$ZSH_HIGHLIGHT_STYLES[ftype-gnumeric];;
            *.chrt)            style=$ZSH_HIGHLIGHT_STYLES[ftype-chrt];;
            *.ppt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ppt];;
            *.pptx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-pptx];;
            *.ods)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ods];;
            *.odp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odp];;
            *.odb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odb];;
            *.db)              style=$ZSH_HIGHLIGHT_STYLES[ftype-db];;
            *.sqlite)          style=$ZSH_HIGHLIGHT_STYLES[ftype-sqlite];;
            *.db)              style=$ZSH_HIGHLIGHT_STYLES[ftype-db];;
            *.mdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdf];;
            *.ldf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ldf];;
            *.mdb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdb];;
            *.odb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-odb];;
            *.asm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-asm];;
            *.asoundrc)        style=$ZSH_HIGHLIGHT_STYLES[ftype-asoundrc];;
            *.awk)             style=$ZSH_HIGHLIGHT_STYLES[ftype-awk];;
            *.coffee)          style=$ZSH_HIGHLIGHT_STYLES[ftype-coffee];;
            *.cs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
            *.css)             style=$ZSH_HIGHLIGHT_STYLES[ftype-css];;
            *.scss)            style=$ZSH_HIGHLIGHT_STYLES[ftype-scss];;
            *.sass)            style=$ZSH_HIGHLIGHT_STYLES[ftype-sass];;
            *.csv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-csv];;
            *.dir_colors)      style=$ZSH_HIGHLIGHT_STYLES[ftype-dir_colors];;
            *.enc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-enc];;
            *.ps)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ps];;
            *.eps)             style=$ZSH_HIGHLIGHT_STYLES[ftype-eps];;
            *.epsi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epsi];;
            *.epsf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-epsf];;
            *.eps2)            style=$ZSH_HIGHLIGHT_STYLES[ftype-eps2];;
            *.eps3)            style=$ZSH_HIGHLIGHT_STYLES[ftype-eps3];;
            *.etx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-etx];;
            *.ex)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ex];;
            *.example)         style=$ZSH_HIGHLIGHT_STYLES[ftype-example];;
            *.fehbg)           style=$ZSH_HIGHLIGHT_STYLES[ftype-fehbg];;
            *.fonts)           style=$ZSH_HIGHLIGHT_STYLES[ftype-fonts];;
            *.git)             style=$ZSH_HIGHLIGHT_STYLES[ftype-git];;
            *.gitignore)       style=$ZSH_HIGHLIGHT_STYLES[ftype-gitignore];;
            *.htm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-htm];;
            *.html)            style=$ZSH_HIGHLIGHT_STYLES[ftype-html];;
            *.jhtm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-jhtm];;
            *.hgrc)            style=$ZSH_HIGHLIGHT_STYLES[ftype-hgrc];;
            *.hgignore)        style=$ZSH_HIGHLIGHT_STYLES[ftype-hgignore];;
            *.hs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-hs];;
            *.htoprc)          style=$ZSH_HIGHLIGHT_STYLES[ftype-htoprc];;
            *.info)            style=$ZSH_HIGHLIGHT_STYLES[ftype-info];;
            *.java)            style=$ZSH_HIGHLIGHT_STYLES[ftype-java];;
            *.js)              style=$ZSH_HIGHLIGHT_STYLES[ftype-js];;
            *.jsm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jsm];;
            *.jsp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-jsp];;
            *.lisp)            style=$ZSH_HIGHLIGHT_STYLES[ftype-lisp];;
            *.lesshst)         style=$ZSH_HIGHLIGHT_STYLES[ftype-lesshst];;
            *.log)             style=$ZSH_HIGHLIGHT_STYLES[ftype-log];;
            *.lua)             style=$ZSH_HIGHLIGHT_STYLES[ftype-lua];;
            *.map)             style=$ZSH_HIGHLIGHT_STYLES[ftype-map];;
            *.mf)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mf];;
            *.mfasl)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mfasl];;
            *.mi)              style=$ZSH_HIGHLIGHT_STYLES[ftype-mi];;
            *.msmtprc)         style=$ZSH_HIGHLIGHT_STYLES[ftype-msmtprc];;
            *.mtx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mtx];;
            *.muttrc)          style=$ZSH_HIGHLIGHT_STYLES[ftype-muttrc];;
            *.nfo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nfo];;
            *.netrc)           style=$ZSH_HIGHLIGHT_STYLES[ftype-netrc];;
            *.offlineimaprc)   style=$ZSH_HIGHLIGHT_STYLES[ftype-offlineimaprc];;
            *.pacnew)          style=$ZSH_HIGHLIGHT_STYLES[ftype-pacnew];;
            *.patch)           style=$ZSH_HIGHLIGHT_STYLES[ftype-patch];;
            *.diff)            style=$ZSH_HIGHLIGHT_STYLES[ftype-diff];;
            *.pc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pc];;
            *.pfa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfa];;
            *.php)             style=$ZSH_HIGHLIGHT_STYLES[ftype-php];;
            *.pid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pid];;
            *.pl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pl];;
            *.PL)              style=$ZSH_HIGHLIGHT_STYLES[ftype-PL];;
            *.pm)              style=$ZSH_HIGHLIGHT_STYLES[ftype-pm];;
            *.pod)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pod];;
            *.py)              style=$ZSH_HIGHLIGHT_STYLES[ftype-py];;
            *.rc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rc];;
            *.rb)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rb];;
            *.ru)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ru];;
            *.sed)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sed];;
            *.signature)       style=$ZSH_HIGHLIGHT_STYLES[ftype-signature];;
            *.sty)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sty];;
            *.sug)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sug];;
            *.t)               style=$ZSH_HIGHLIGHT_STYLES[ftype-t];;
            *.tcl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tcl];;
            *.tk)              style=$ZSH_HIGHLIGHT_STYLES[ftype-tk];;
            *.tdy)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tdy];;
            *.tfm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tfm];;
            *.tfnt)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tfnt];;
            *.theme)           style=$ZSH_HIGHLIGHT_STYLES[ftype-theme];;
            *.viminfo)         style=$ZSH_HIGHLIGHT_STYLES[ftype-viminfo];;
            *.vim)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vim];;
            *.vimrc)           style=$ZSH_HIGHLIGHT_STYLES[ftype-vimrc];;
            *.sh)              style=$ZSH_HIGHLIGHT_STYLES[ftype-sh];;
            *.sh*)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sh*];;
            *.bash)            style=$ZSH_HIGHLIGHT_STYLES[ftype-bash];;
            *.dash)            style=$ZSH_HIGHLIGHT_STYLES[ftype-dash];;
            *.bash_history)    style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_history];;
            *.zsh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-zsh];;
            *.csh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-csh];;
            *.ksh)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ksh];;
            *.tcsh)            style=$ZSH_HIGHLIGHT_STYLES[ftype-tcsh];;
            zshrc)           style=$ZSH_HIGHLIGHT_STYLES[ftype-zshrc];;
            *.profile)         style=$ZSH_HIGHLIGHT_STYLES[ftype-profile];;
            *.bash_profile)    style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_profile];;
            *.bash_logout)     style=$ZSH_HIGHLIGHT_STYLES[ftype-bash_logout];;
            bashrc)          style=$ZSH_HIGHLIGHT_STYLES[ftype-bashrc];;
            *.ttytterrc)       style=$ZSH_HIGHLIGHT_STYLES[ftype-ttytterrc];;
            *.urlview)         style=$ZSH_HIGHLIGHT_STYLES[ftype-urlview];;
            *.xinitrc)         style=$ZSH_HIGHLIGHT_STYLES[ftype-xinitrc];;
            *.Xauthority)      style=$ZSH_HIGHLIGHT_STYLES[ftype-Xauthority];;
            *.Xmodmap)         style=$ZSH_HIGHLIGHT_STYLES[ftype-Xmodmap];;
            *.Xresources)      style=$ZSH_HIGHLIGHT_STYLES[ftype-Xresources];;
            *.iso)             style=$ZSH_HIGHLIGHT_STYLES[ftype-iso];;
            *.img)             style=$ZSH_HIGHLIGHT_STYLES[ftype-img];;
            *.dmg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dmg];;
            *.vcd)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vcd];;
            *.ISO)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ISO];;
            *.nrg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nrg];;
            *.mdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mdf];;
            *.tex)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tex];;
            *.latex)           style=$ZSH_HIGHLIGHT_STYLES[ftype-latex];;
            *.textile)         style=$ZSH_HIGHLIGHT_STYLES[ftype-textile];;
            *.rdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-rdf];;
            *.owl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-owl];;
            *.n3)              style=$ZSH_HIGHLIGHT_STYLES[ftype-n3];;
            *.rc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rc];;
            *.ttl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ttl];;
            *.nt)              style=$ZSH_HIGHLIGHT_STYLES[ftype-nt];;
            *.torrent)         style=$ZSH_HIGHLIGHT_STYLES[ftype-torrent];;
            *.jidgo)           style=$ZSH_HIGHLIGHT_STYLES[ftype-jidgo];;
            *.xml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-xml];;
            *.nfo)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nfo];;
            *.yml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yml];;
            *.cfg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cfg];;
            *.ini)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ini];;
            *.conf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-conf];;
            *.yml)             style=$ZSH_HIGHLIGHT_STYLES[ftype-yml];;
            *.json)            style=$ZSH_HIGHLIGHT_STYLES[ftype-json];;
            *.aux)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aux];;
            *.md5)             style=$ZSH_HIGHLIGHT_STYLES[ftype-md5];;
            *.sfv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sfv];;
            *.sha1)            style=$ZSH_HIGHLIGHT_STYLES[ftype-sha1];;
            *.st5)             style=$ZSH_HIGHLIGHT_STYLES[ftype-st5];;
            *.ffp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ffp];;
            *.par)             style=$ZSH_HIGHLIGHT_STYLES[ftype-par];;
            *.flac)            style=$ZSH_HIGHLIGHT_STYLES[ftype-flac];;
            *.alac)            style=$ZSH_HIGHLIGHT_STYLES[ftype-alac];;
            *.wav)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wav];;
            *.aac)             style=$ZSH_HIGHLIGHT_STYLES[ftype-aac];;
            *.au)              style=$ZSH_HIGHLIGHT_STYLES[ftype-au];;
            *.mid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mid];;
            *.midi)            style=$ZSH_HIGHLIGHT_STYLES[ftype-midi];;
            *.mka)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mka];;
            *.mp2)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp2];;
            *.mp3)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp3];;
            *.wma)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wma];;
            *.mpc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mpc];;
            *.ogg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogg];;
            *.ra)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ra];;
            *.m4a)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4a];;
            *.m4b)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4b];;
            *.m4r)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4r];;
            *.axa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-axa];;
            *.oga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-oga];;
            *.spx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-spx];;
            *.m3u8)            style=$ZSH_HIGHLIGHT_STYLES[ftype-m3u8];;
            *.m3u)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m3u];;
            *.pls)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pls];;
            *.cue)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cue];;
            *.xspf)            style=$ZSH_HIGHLIGHT_STYLES[ftype-xspf];;
            *.S3M)             style=$ZSH_HIGHLIGHT_STYLES[ftype-S3M];;
            *.dat)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dat];;
            *.fcm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fcm];;
            *.m4)              style=$ZSH_HIGHLIGHT_STYLES[ftype-m4];;
            *.mod)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mod];;
            *.oga)             style=$ZSH_HIGHLIGHT_STYLES[ftype-oga];;
            *.s3m)             style=$ZSH_HIGHLIGHT_STYLES[ftype-s3m];;
            *.sid)             style=$ZSH_HIGHLIGHT_STYLES[ftype-sid];;
            *.spl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-spl];;
            *.wv)              style=$ZSH_HIGHLIGHT_STYLES[ftype-wv];;
            *.wvc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wvc];;
            *.mov)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mov];;
            *.MOV)             style=$ZSH_HIGHLIGHT_STYLES[ftype-MOV];;
            *.mpg)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mpg];;
            *.mpeg)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mpeg];;
            *.m2v)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m2v];;
            *.mkv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mkv];;
            *.ogm)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogm];;
            *.mp4)             style=$ZSH_HIGHLIGHT_STYLES[ftype-mp4];;
            *.VOB)             style=$ZSH_HIGHLIGHT_STYLES[ftype-VOB];;
            *.m4v)             style=$ZSH_HIGHLIGHT_STYLES[ftype-m4v];;
            *.mp4v)            style=$ZSH_HIGHLIGHT_STYLES[ftype-mp4v];;
            *.vob)             style=$ZSH_HIGHLIGHT_STYLES[ftype-vob];;
            *.qt)              style=$ZSH_HIGHLIGHT_STYLES[ftype-qt];;
            *.nuv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-nuv];;
            *.wmv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-wmv];;
            *.asf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-asf];;
            *.rm)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rm];;
            *.rmvb)            style=$ZSH_HIGHLIGHT_STYLES[ftype-rmvb];;
            *.flc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-flc];;
            *.avi)             style=$ZSH_HIGHLIGHT_STYLES[ftype-avi];;
            *.AVI)             style=$ZSH_HIGHLIGHT_STYLES[ftype-AVI];;
            *.fli)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fli];;
            *.flv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-flv];;
            *.gl)              style=$ZSH_HIGHLIGHT_STYLES[ftype-gl];;
            *.m2ts)            style=$ZSH_HIGHLIGHT_STYLES[ftype-m2ts];;
            *.divx)            style=$ZSH_HIGHLIGHT_STYLES[ftype-divx];;
            *.webm)            style=$ZSH_HIGHLIGHT_STYLES[ftype-webm];;
            *.ogv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogv];;
            *.sample)          style=$ZSH_HIGHLIGHT_STYLES[ftype-sample];;
            *.ts)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ts];;
            *.axv)             style=$ZSH_HIGHLIGHT_STYLES[ftype-axv];;
            *.anx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-anx];;
            *.ogx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ogx];;
            *.srt)             style=$ZSH_HIGHLIGHT_STYLES[ftype-srt];;
            *.ttf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ttf];;
            *.otf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-otf];;
            *.pcf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pcf];;
            *.bdf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-bdf];;
            *.fon)             style=$ZSH_HIGHLIGHT_STYLES[ftype-fon];;
            *.dfont)           style=$ZSH_HIGHLIGHT_STYLES[ftype-dfont];;
            *.pfa)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfa];;
            *.pfb)             style=$ZSH_HIGHLIGHT_STYLES[ftype-pfb];;
            *.gsf)             style=$ZSH_HIGHLIGHT_STYLES[ftype-gsf];;
            *.service)         style=$ZSH_HIGHLIGHT_STYLES[ftype-service];;
            *.socket)          style=$ZSH_HIGHLIGHT_STYLES[ftype-socket];;
            *.device)          style=$ZSH_HIGHLIGHT_STYLES[ftype-device];;
            *.mount)           style=$ZSH_HIGHLIGHT_STYLES[ftype-mount];;
            *.automount)       style=$ZSH_HIGHLIGHT_STYLES[ftype-automount];;
            *.swap)            style=$ZSH_HIGHLIGHT_STYLES[ftype-swap];;
            *.target)          style=$ZSH_HIGHLIGHT_STYLES[ftype-target];;
            *.path)            style=$ZSH_HIGHLIGHT_STYLES[ftype-path];;
            *.timer)           style=$ZSH_HIGHLIGHT_STYLES[ftype-timer];;
            *.snapshot)        style=$ZSH_HIGHLIGHT_STYLES[ftype-snapshot];;
            *.c)               style=$ZSH_HIGHLIGHT_STYLES[ftype-c];;
            *.C)               style=$ZSH_HIGHLIGHT_STYLES[ftype-C];;
            *.cp)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cp];;
            *.cc)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cc];;
            *.cpp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cpp];;
            *.cxx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cxx];;
            *.c++)             style=$ZSH_HIGHLIGHT_STYLES[ftype-c++];;
            *.ii)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ii];;
            *.cs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-cs];;
            *.rs)              style=$ZSH_HIGHLIGHT_STYLES[ftype-rs];;
            *.go)              style=$ZSH_HIGHLIGHT_STYLES[ftype-go];;
            *.erl)             style=$ZSH_HIGHLIGHT_STYLES[ftype-erl];;
            *.ml)              style=$ZSH_HIGHLIGHT_STYLES[ftype-ml];;
            *.scala)           style=$ZSH_HIGHLIGHT_STYLES[ftype-scala];;
            *.H)               style=$ZSH_HIGHLIGHT_STYLES[ftype-H];;
            *.hpp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-hpp];;
            *.hxx)             style=$ZSH_HIGHLIGHT_STYLES[ftype-hxx];;
            *.h++)             style=$ZSH_HIGHLIGHT_STYLES[ftype-h++];;
            *.tcc)             style=$ZSH_HIGHLIGHT_STYLES[ftype-tcc];;
            *.f)               style=$ZSH_HIGHLIGHT_STYLES[ftype-f];;
            *.for)             style=$ZSH_HIGHLIGHT_STYLES[ftype-for];;
            *.ftn)             style=$ZSH_HIGHLIGHT_STYLES[ftype-ftn];;
            *.s)               style=$ZSH_HIGHLIGHT_STYLES[ftype-s];;
            *.S)               style=$ZSH_HIGHLIGHT_STYLES[ftype-S];;
            *.sx)              style=$ZSH_HIGHLIGHT_STYLES[ftype-sx];;
            *.am)              style=$ZSH_HIGHLIGHT_STYLES[ftype-am];;
            *.in)              style=$ZSH_HIGHLIGHT_STYLES[ftype-in];;
            *.old)             style=$ZSH_HIGHLIGHT_STYLES[ftype-old];;
            *.pcap)            style=$ZSH_HIGHLIGHT_STYLES[ftype-pcap];;
            *.cap)             style=$ZSH_HIGHLIGHT_STYLES[ftype-cap];;
            *.dmp)             style=$ZSH_HIGHLIGHT_STYLES[ftype-dmp];;
            *.am)              style=$ZSH_HIGHLIGHT_STYLES[ftype-am];;
            *.in)              style=$ZSH_HIGHLIGHT_STYLES[ftype-in];;
            *.old)             style=$ZSH_HIGHLIGHT_STYLES[ftype-old];;
            '--'*)   style=$ZSH_HIGHLIGHT_STYLES[double-hyphen-option];;
            '-'*)    style=$ZSH_HIGHLIGHT_STYLES[single-hyphen-option];;
            "'"*)    style=$ZSH_HIGHLIGHT_STYLES[single-quoted-argument];;
            '"'*)    style=$ZSH_HIGHLIGHT_STYLES[double-quoted-argument]
                    _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                    _zsh_highlight_main_highlighter_highlight_string
                    already_added=1
                    ;;
            \$\'*)   style=$ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]
                    _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
                    _zsh_highlight_main_highlighter_highlight_dollar_string
                    already_added=1
                    ;;
            '`'*)    style=$ZSH_HIGHLIGHT_STYLES[back-quoted-argument];;
            [*?]*|*[^\\][*?]*)
                    $highlight_glob && style=$ZSH_HIGHLIGHT_STYLES[globbing] || style=$ZSH_HIGHLIGHT_STYLES[default];;
            *)       if false; then
                    elif [[ $arg[0,1] = $histchars[0,1] ]]; then
                    style=$ZSH_HIGHLIGHT_STYLES[history-expansion]
                    elif [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
                    if [[ $this_word == *':regular:'* ]]; then
                        style=$ZSH_HIGHLIGHT_STYLES[commandseparator]
                    else
                        style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                    fi
                    elif [[ $arg == (<0-9>|)(\<|\>)* ]]; then
                    style=$ZSH_HIGHLIGHT_STYLES[redirection]
                    (( in_redirection=2 ))
                    else
                    if _zsh_highlight_main_highlighter_check_path; then
                        style=$ZSH_HIGHLIGHT_STYLES[path]
                    else
                        style=$ZSH_HIGHLIGHT_STYLES[default]
                    fi
                    fi
                    ;;
        esac
    fi
    # if a style_override was set (eg in _zsh_highlight_main_highlighter_check_path), use it
    [[ -n $style_override ]] && style=$ZSH_HIGHLIGHT_STYLES[$style_override]
    (( already_added )) || _zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
    if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]]; then
            next_word=':start:'
            highlight_glob=true
        elif
            [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} && $this_word == *':start:'* ]] ||
            [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS:#"$arg"} && $this_word == *':start:'* ]]; then
            next_word=':start:'
        elif [[ $arg == "repeat" && $this_word == *':start:'* ]]; then
            # skip the repeat-count word
            in_redirection=2
            # The redirection mechanism assumes $this_word describes the word
            # following the redirection.  Make it so.
            #
            # The repeat-count word will be handled like a redirection target.
            this_word=':start:'
        fi
        start_pos=$end_pos
        (( in_redirection == 0 )) && this_word=$next_word
    done
}

# Check if $arg is variable assignment
_zsh_highlight_main_highlighter_check_assign() {
    setopt localoptions extended_glob
    [[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]]
}

# Check if $arg is a path.
_zsh_highlight_main_highlighter_check_path() {
  _zsh_highlight_main_highlighter_expand_path $arg;
  local expanded_path="$REPLY"

  [[ -z $expanded_path ]] && return 1
  [[ -e $expanded_path ]] && return 0

  # Search the path in CDPATH
  local cdpath_dir
  for cdpath_dir in $cdpath ; do
    [[ -e "$cdpath_dir/$expanded_path" ]] && return 0
  done

  # If dirname($arg) doesn't exist, neither does $arg.
  [[ ! -e ${expanded_path:h} ]] && return 1

  # If this word ends the buffer, check if it's the prefix of a valid path.
  if [[ ${BUFFER[1]} != "-" && ${#BUFFER} == $end_pos ]] &&
     [[ $WIDGET != accept-* ]]; then
    local -a tmp
    tmp=( ${expanded_path}*(N) )
    (( $#tmp > 0 )) && style_override=path_prefix && return 0
  fi

  # It's not a path.
  return 1
}

# Highlight special chars inside double-quoted strings
_zsh_highlight_main_highlighter_highlight_string() {
    setopt localoptions noksharrays
    local -a match mbegin mend
    local MATCH; integer MBEGIN MEND
    local i j k style
    # Starting quote is at 1, so start parsing at offset 2 in the string.
    for (( i = 2 ; i < end_pos - start_pos ; i += 1 )) ; do
        (( j = i + start_pos - 1 ))
        (( k = j + 1 ))
        case "$arg[$i]" in
        '$' ) style=$ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]
                # Look for an alphanumeric parameter name.
                if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]] ; then
                (( k += $#MATCH )) # highlight the parameter name
                (( i += $#MATCH )) # skip past it
                elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]] ; then
                (( k += $#MATCH )) # highlight the parameter name and braces
                (( i += $#MATCH )) # skip past it
                else
                continue
                fi
                ;;
        "\\") style=$ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]
                if [[ \\\`\"\$ == *$arg[$i+1]* ]]; then
                (( k += 1 )) # Color following char too.
                (( i += 1 )) # Skip parsing the escaped char.
                else
                continue
                fi
                ;;
        *) continue ;;

        esac
        _zsh_highlight_main_add_region_highlight $j $k $style
    done
}

# Highlight special chars inside dollar-quoted strings
_zsh_highlight_main_highlighter_highlight_dollar_string() {
    setopt localoptions noksharrays
    local -a match mbegin mend
    local MATCH; integer MBEGIN MEND
    local i j k style
    local AA
    integer c
    # Starting dollar-quote is at 1:2, so start parsing at offset 3 in the string.
    for (( i = 3 ; i < end_pos - start_pos ; i += 1 )) ; do
        (( j = i + start_pos - 1 ))
        (( k = j + 1 ))
        case "$arg[$i]" in
        "\\") style=$ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]
                for (( c = i + 1 ; c <= end_pos - start_pos ; c += 1 )); do
                [[ "$arg[$c]" != ([0-9xXuUa-fA-F]) ]] && break
                done
                AA=$arg[$i+1,$c-1]
                # Matching for HEX and OCT values like \0xA6, \xA6 or \012
                if [[    "$AA" =~ "^(x|X)[0-9a-fA-F]{1,2}"
                    || "$AA" =~ "^[0-7]{1,3}"
                    || "$AA" =~ "^u[0-9a-fA-F]{1,4}"
                    || "$AA" =~ "^U[0-9a-fA-F]{1,8}"
                ]]; then
                (( k += $#MATCH ))
                (( i += $#MATCH ))
                else
                if (( $#arg > $i+1 )) && [[ $arg[$i+1] == [xXuU] ]]; then
                    # \x not followed by hex digits is probably an error
                    style=$ZSH_HIGHLIGHT_STYLES[unknown-token]
                fi
                (( k += 1 )) # Color following char too.
                (( i += 1 )) # Skip parsing the escaped char.
                fi
                ;;
        *) continue ;;

        esac
        _zsh_highlight_main_add_region_highlight $j $k $style
    done
}

# Called with a single positional argument.
# Perform filename expansion (tilde expansion) on the argument and set $REPLY to the expanded value.
#
# Does not perform filename generation (globbing).
_zsh_highlight_main_highlighter_expand_path() {
    (( $# == 1 )) || echo "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument" >&2

    # The $~1 syntax normally performs filename generation, but not when it's on the right-hand side of ${x:=y}.
    setopt localoptions nonomatch
    unset REPLY
    : ${REPLY:=${(Q)~1}}
}
