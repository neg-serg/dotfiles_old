function copy-to-clipboard() {
    (( $+commands[xclip] )) || return
    echo -E -n - "$BUFFER" | xclip -i
}
zle -N copy-to-clipboard

# expand-or-complete, but sets buffer to "cd" if it's empty
function expand-or-complete-or-cd() {
    if [[ $#BUFFER == 0 ]]; then
        BUFFER="cd "
        CURSOR=3
        # don't want that after all
        # zle menu-expand-or-complete
        zle menu-expand-or-complete
    else
        zle expand-or-complete
    fi
}
zle -N expand-or-complete-or-cd

# automatically escape parsed urls
autoload -U url-quote-magic
if [[ $+functions[_zsh_highlight] == 1 ]]; then
    function _url-quote-magic() { url-quote-magic; _zsh_highlight }
    zle -N self-insert _url-quote-magic
else
    zle -N self-insert url-quote-magic
fi

# just type '...' to get '../..'
# function rationalise-dot() {
#   local MATCH dir
#   if [[ $LBUFFER =~ '(^|/| |    |'$'\n''|\||;|&)\.\.$' ]]; then
#     LBUFFER+=/
#     zle self-insert
#     zle self-insert
#     dir=${${(z)LBUFFER}[-1]}
#     [[ -e $dir ]] && zle -M $dir(:a)
#   elif [[ $LBUFFER[-1] == '.' ]]; then
#     zle self-insert
#     dir=${${(z)LBUFFER}[-1]}
#     [[ -e $dir ]] && zle -M $dir(:a)
#   else
#     zle self-insert
#   fi
# }
# zle -N rationalise-dot
#
