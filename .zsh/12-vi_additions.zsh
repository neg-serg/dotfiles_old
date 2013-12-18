# delete's a block between two characters
delete-in() {
    local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT
    read -k CHAR
    if [[ $CHAR == "w" ]];then
        zle vi-backward-word
        LSEARCH=$CURSOR
        zle vi-forward-word
        RSEARCH=$CURSOR
        RBUFFER="$BUFFER[$RSEARCH+1,${#BUFFER}]"
        LBUFFER="$LBUFFER[1,$LSEARCH]"
        return
    elif [[ $CHAR == "(" ]] || [[ $CHAR == ")" ]];then
        LCHAR="("
        RCHAR=")"
    elif [[ $CHAR == "[" ]] || [[ $CHAR == "]" ]];then
        LCHAR="["
        RCHAR="]"
    elif [[ $CHAR == "{" ]] || [[ $CHAR == "}" ]];then
        LCHAR="{"
        RCHAR="}"
    else
        LSEARCH=${#LBUFFER}
        while [[ $LSEARCH -gt 0 ]] && [[ "$LBUFFER[$LSEARCH]" != "$CHAR" ]]; do
            (( LSEARCH = $LSEARCH - 1 ))
        done
        RSEARCH=0
        while [[ $RSEARCH -lt (( ${#RBUFFER} + 1 )) ]] && [[ "$RBUFFER[$RSEARCH]" != "$CHAR" ]]; do
            (( RSEARCH = $RSEARCH + 1 ))
        done
        RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
        LBUFFER="$LBUFFER[1,$LSEARCH]"
        return
    fi
    COUNT=1
    LSEARCH=${#LBUFFER}
    while [[ $LSEARCH -gt 0 ]] && [[ $COUNT -gt 0 ]]; do
        (( LSEARCH = $LSEARCH - 1 ))
        if [[ $LBUFFER[$LSEARCH] == "$RCHAR" ]];then
            (( COUNT = $COUNT + 1 ))
        fi
        if [[ $LBUFFER[$LSEARCH] == "$LCHAR" ]];then
            (( COUNT = $COUNT - 1 ))
        fi
    done
    COUNT=1
    RSEARCH=0
    while [[ $RSEARCH -lt (( ${#RBUFFER} + 1 )) ]] && [[ $COUNT -gt 0 ]]; do
        (( RSEARCH = $RSEARCH + 1 ))
        if [[ $RBUFFER[$RSEARCH] == "$LCHAR" ]];then
            (( COUNT = $COUNT + 1 ))
        fi
        if [[ $RBUFFER[$RSEARCH] == "$RCHAR" ]];then
            (( COUNT = $COUNT - 1 ))
        fi
    done
    RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"
}
zle -N delete-in

change-in() {
    zle delete-in
    zle vi-insert
}
zle -N change-in

delete-around() {
    zle delete-in
    zle vi-backward-char
    zle vi-delete-char
    zle vi-delete-char
}
zle -N delete-around

change-around() {
    zle delete-in
    zle vi-backward-char
    zle vi-delete-char
    zle vi-delete-char
    zle vi-insert
}
zle -N change-around

bindkey -M vicmd ' ' execute-named-cmd # Space for command line mode
bindkey -M vicmd 'H' run-help
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M vicmd "ga"     what-cursor-position
bindkey -M vicmd "g~"     vi-oper-swap-case

bindkey -M vicmd "di"     delete-in
bindkey -M vicmd "ci"     change-in
bindkey -M vicmd "da"     delete-around
bindkey -M vicmd "ca"     delete-around

bindkey -M vicmd  "^J"    down-line-or-history
bindkey -M vicmd  "^K"    up-line-or-history
bindkey -M vicmd  "="     list-choices
bindkey -M vicmd  "^D"    list-choices
bindkey -M vicmd  "^R"    history-incremental-search-backward
bindkey -M vicmd  "k"     up-line-or-history
bindkey -M vicmd  "+"     vi-down-line-or-history
bindkey -M vicmd  "G"     vi-fetch-history
bindkey -M vicmd  "F"     vi-find-prev-char
bindkey -M vicmd  "T"     vi-find-prev-char-skip

bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^w'    backward-kill-word
bindkey -M vicmd '^u'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?'     vi-history-search-backward
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '\ef'   forward-word                      # Alt-f
bindkey -M vicmd '\eb'   backward-word                     # Alt-b
bindkey -M vicmd '\ed'   kill-word                         # Alt-d
bindkey -M vicmd '\e[5~' history-beginning-search-backward # PageUp
bindkey -M vicmd '\e[6~' history-beginning-search-forward  # PageDo
