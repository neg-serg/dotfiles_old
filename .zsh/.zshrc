. ~/.zsh/01-init.zsh
. ~/.zsh/02-zsh-syntax-highlighting.zsh
. ~/.zsh/03-exports.zsh
. ~/.zsh/04-oldprompt.zsh
. ~/.zsh/04-zleiab.zsh
. ~/.zsh/05-functions.zsh
. ~/.zsh/06-alias.zsh
. ~/.zsh/07-misc.zsh
. ~/.zsh/09-cb.zsh
. ~/.zsh/10-safe-paste.plugin.zsh
. ~/.zsh/10-hashes.zsh
. ~/.zsh/10-jump.zsh
. ~/.zsh/11-open.zsh
. ~/.zsh/12-completion.zsh
. ~/.zsh/12-vi_additions.zsh
. ~/.zsh/13-bindkeys.zsh
. ~/.zsh/14-dirjumps.zsh
. ~/.zsh/20-rehash-hook.zsh
. ~/.zsh/40-gpg-agent.zsh
. ~/.zsh/50-title.zsh
# . ~/.zsh/50-vicursor.zsh
# . ~/.zsh/65-fastfile.zsh
# . ~/.zsh/72-bracket-paste.zsh
. ~/.zsh/72-return.zsh
. ~/.zsh/74-show_mod.zsh
. ~/.zsh/75-urltools.plugun.zsh    #test it
. ~/.zsh/90-systemadmin.zsh        #test it
. ~/.zsh/90-github.plugin.zsh 
. ~/.zsh/96-vcs_info-cdpath.zsh    #test it
. ~/.zsh/97-lastfm.zsh
# ------------------------------------------
# . ~/.zsh/99-trash.zsh
# . ~/.zsh/99-experimental.zsh
# ------------------------------------------

say() {

        mpv -user-agent Mozilla \
        "http://translate.google.com/translate_tts?ie=UTF-8&tl="$1"&q=$(echo "$@" \
        | cut -d ' ' -f2- | sed 's/ /\+/g')" > /dev/null 2>&1 ;}

say-translation() {

        lang=$1
        trans=$(translate {=$lang} "$(echo "$@" | cut -d ' ' -f2- | sed 's/ /\+/g')" )
        echo $trans
        mpv -user-agent Mozilla \
        "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$trans" > /dev/null 2>&1 ;}

