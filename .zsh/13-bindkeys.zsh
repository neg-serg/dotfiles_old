#!/usr/bin/zsh

if [[ "$TERM" != emacs ]] ; then
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
    [[ -z "$terminfo[kend]"  ]] || bindkey -M emacs "$terminfo[kend]"  end-of-line
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
    [[ -z "$terminfo[kend]"  ]] || bindkey -M vicmd "$terminfo[kend]"  vi-end-of-line
    [[ -z "$terminfo[cuf1]"  ]] || bindkey -M viins "$terminfo[cuf1]"  vi-forward-char
    [[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
    [[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char
    # ncurses stuff:
    [[ "$terminfo[kcuf1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
    [[ "$terminfo[kcub1]" == $'\eO'* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
    [[ "$terminfo[khome]" == $'\eO'* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == $'\eO'* ]] && bindkey -M viins "${terminfo[kend]/O/[}"  end-of-line
    [[ "$terminfo[khome]" == $'\eO'* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]"  == $'\eO'* ]] && bindkey -M emacs "${terminfo[kend]/O/[}"  end-of-line
fi

bindkey -e

# Search backward in the history for a line beginning with the current
# line up to the cursor and move the cursor to the end of the line then
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
#k# search history backward for entry beginning with typed text
bindkey '^xp'   history-beginning-search-backward-end
#k# search history forward for entry beginning with typed text
bindkey '^xP'   history-beginning-search-forward-end
#k# search history backward for entry beginning with typed text
bindkey "\e[5~" history-beginning-search-backward-end # PageUp
#k# search history forward for entry beginning with typed text
bindkey "\e[6~" history-beginning-search-forward-end  # PageDown

slash-backward-kill-word() {
    local WORDCHARS="${WORDCHARS:s@/@}"
    # zle backward-word
    zle backward-kill-word
}
zle -N slash-backward-kill-word
# Use Ctrl-x,Ctrl-l to get the output of the last command
zmodload -i zsh/parameter
insert-last-command-output() {
    LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey "^X^L" insert-last-command-output

#k# Kill left-side word or everything up to next slash
bindkey '\ev' slash-backward-kill-word
#k# Kill left-side word or everything up to next slash
bindkey '\e^h' slash-backward-kill-word
#k# Kill left-side word or everything up to next slash
bindkey '\e^?' slash-backward-kill-word

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

zstyle ':acceptline:*' rehash true

if zrcautoload insert-files && zle -N insert-files ; then
    bindkey "^xf" insert-files # C-x-f
fi

bindkey "^[+" up-one-dir
bindkey "^[=" back-one-dir

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

bindkey . rationalise-dot

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

if zrcautoload insert-files && zle -N insert-files ; then
    #k# Insert files and test globbing
    bindkey "^xf" insert-files # C-x-f
fi

#bindkey ' '   magic-space    # also do history expansion on space
bindkey '\ei' menu-complete  # menu completion via esc-i

#k# jump to after first word (for adding options)
bindkey '^x1'           jump_after_first_word
# do history expansion on space
bindkey " "             magic-space
bindkey ",."            zleiab

# zle -N backward-kill-default-word _backward_kill_default_word
# bindkey '\e=' backward-kill-default-word   # = is next to backspace

bindkey -M emacs "^[w"  vi-cmd-mode
bindkey -M emacs "^X^V" vi-cmd-mode
bindkey -M emacs "^X^F" vi-find-next-char
bindkey -M emacs "^[|"  vi-goto-column
bindkey -M emacs "^X^J" vi-join
bindkey -M emacs "^X^B" vi-match-bracket

# accept a completion and try to complete again by using menu
# completion; very useful with completing directories
# by using 'undo' one's got a simple file browser
bindkey -M menuselect '^o' accept-and-infer-next-history

bindkey -M menuselect 'h'     vi-backward-char                
bindkey -M menuselect 'j'     vi-down-line-or-history         
bindkey -M menuselect 'k'     vi-up-line-or-history           
bindkey -M menuselect 'l'     vi-forward-char                 
bindkey -M menuselect 'i'     accept-and-menu-complete
bindkey -M menuselect "+"     accept-and-menu-complete
bindkey -M menuselect "^[[2~" accept-and-menu-complete
bindkey -M menuselect 'o'     accept-and-infer-next-history
bindkey -M menuselect '\e^M'  accept-and-menu-complete
# also use + and INSERT since it's easier to press repeatedly

bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert
bindkey "^I" expand-or-complete-and-highlight

# load the lookup subsystem if it's available on the system
zrcautoload lookupinit && lookupinit
zle -N inplace_mk_dirs && bindkey '^xM' inplace_mk_dirs

bindkey -M emacs "^XD" describe-key-briefly
bindkey -M emacs "^Z" fg-widget
bindkey -M vicmd "^Z" fg-widget
bindkey -M viins "^Z" fg-widget

bindkey -s "c" ' cd -'     # A-c to do cycle throw last directory

bindkey "i" fasd-complete      # A-i to do ls++ alias
bindkey '^X^A' fasd-complete     # C-x C-a to do fasd-complete (files and directories)
bindkey '^X^F' fasd-complete-f   # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d   # C-x C-d to do fasd-complete-d (only directories)

bindkey '^X^X' copy-to-clipboard

jump_dirs=(~/1st_level ~/dw ~/dev ~/pic ~/vid ~/trash)
for index in $(seq 1 $((${#jump_dirs[@]} ))); do
    bindkey -s "${index}" "cd ${jump_dirs[$index]}"
done
