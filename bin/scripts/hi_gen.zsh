#!/bin/zsh

eat () {
        prog=${0##*/}
        local bldblu='\e[1;34m'
        local txtbld=$(tput bold)
        local txtund=$(tput sgr 0 1)
        local txtrst='\e[0m'
        local pass=${bldblu}*${txtrst}
        filename=$@
        xclip -in -selection c < "${filename}"
        echo -e "${pass} ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

dircolors_location="${XDG_CONFIG_HOME}/dircolors/.dircolors"
egrep '^[.*]' ${1:-$dircolors_location}|sed 's/#.*//'|sed 's/^\.\W*/ftype-/' > /tmp/generation

echo "-----------------------------"
echo "you should handle it by hand:"
echo "-----------------------------"

egrep '^ftype-' -v /tmp/generation 
egrep '^ftype-' /tmp/generation | sed -e 's/38;5;/fg=/'                  \
                                      -e 's/48;5;/bg=/g'                 \
                                      -e "/\(01;\|;1\)/s/$/,bold/"       \
                                      -e "/\(04;\|;4\)/s/$/,underline/"  \
                                      -e 's/00;//'                       \
                                      -e 's/\(01;\|;1\)//'               \
                                      -e 's/;/,/g'                       \
                                      -e 's/,4/,underline/g'             \
                                      -e "/\ 3[0-9][0-9]*/s/3/fg=/"      \
                                      -e "s/, //g" > /tmp/_result

vim -c 'Tabularize/[bf]g=.*' /tmp/_result -c 'wq'
sed 's/^ftype-//' /tmp/_result|awk '{print "*."$1") style=$ZSH_HIGHLIGHT_STYLES[ftype-"$1"];;"}' > /tmp/_rules
vim -c 'Tabularize/)\zs ' /tmp/_rules -c 'wq'

eat /tmp/_result
eat /tmp/_rules

rm -vf /tmp/{generation,_{fill,result,rules}} && echo :: Cleanup done ::
