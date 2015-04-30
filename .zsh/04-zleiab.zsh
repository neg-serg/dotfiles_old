declare -A abk
abk=(
    'A'    '|& ack -i '
    'G'    '|& grep -i '
    'H'    '| head'
    'N'    '&>/dev/null'
    'S'    '| sort -h '
    'T'    '| tail'
    'W'    '|& ls_color'
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
