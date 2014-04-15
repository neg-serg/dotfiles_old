declare -A abk
abk=(
   #key    # value                  (#d additional doc string)
    'BG'   '& exit'
    'C'    '| wc -l'
    'G'    '|& ack -i '
    'H'    '| head'
    'Hl'   ' --help |& ${PAGER} -r'    #d (Display help in pager)
    'LL'   '|& ${PAGER} -r'
    'N'    '&>/dev/null'           #d (No Output)
    'R'    '| tr A-z N-za-m'       #d (ROT13)
    'S'    '| sort -h '
    'T'    '| tail'
    'W'    '|& ls_color'
    'V'    '|& v -'
    'co'   './configure && make'
    "findf" 'find . -maxdepth 1 -type f -printf "%P\n" | \
        perl -e "@_=<>; print sort grep {! /^[.]/ } @_; print sort grep { /^[.]/ } @_" | \
        ls_color'
    "jj"   "!$"
    "jk"   "!-2$"
    "jjk"  "!-3$"
    "jkk"  "!-4$"
    "kk"   "!-5$"
    "kj"   "!-6$"
)

zleiab() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

    if (( NOABBREVIATION > 0 )) ; then
        LBUFFER="${LBUFFER},."
        return 0
    fi

    matched_chars='[.-|_a-zA-Z0-9]#'
    LBUFFER=${LBUFFER%%(#m)[.-|_a-zA-Z0-9]#}
    LBUFFER+=${abk[$MATCH]:-$MATCH}
}

zle -N zleiab 
