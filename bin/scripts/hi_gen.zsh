#!/bin/zsh

eat () {
        prog=${0##*/}
        bldblu='\e[1;34m'
        bldred='\e[1;31m'
        bldwht='\e[1;37m'
        txtbld=$(tput bold)
        txtund=$(tput sgr 0 1)
        txtrst='\e[0m'
        info=${bldwht}*${txtrst}
        pass=${bldblu}*${txtrst}
        warn=${bldred}!${txtrst}
        filename=$@
        if [[ -z ${filename} ]]
        then
                echo " ${prog} <filename> - copy a file to the clipboard"
                exit
        fi
        if [[ ! -f ${filename} ]]
        then
                echo -e "${warn} File ${txtund}${filename}${txtrst} doesn't exist"
                exit
        fi
        if [[ $(whoami) = root ]]
        then
                echo -e "${warn} Must be regular user to copy a file to the clipboard"
                exit
        fi
        xclip -in -selection c < "$filename"
        echo -e "${pass} ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

egrep '^[.*]' ~/.config/dircolors/.dircolors|sed 's/#.*//'|sed 's/^\.\W*/ftype-/' > /tmp/generation

echo "-----------------------------"
echo "you should handle it by hand:"
echo "-----------------------------"

egrep '^ftype-' -v /tmp/generation 
egrep '^ftype-' /tmp/generation | sed -e 's/38;5;/fg=/' \
                                      -e 's/48;5;/bg=/g' \
                                      -e "/\(01;\|;1\)/s/$/,bold/" \
                                      -e 's/00;//' \
                                      -e 's/\(01;\|;1\)//' \
                                      -e 's/;/,/g' \
                                      -e 's/,4/,underline/g' \
                                      -e "/\ 3[0-9][0-9]*/s/3/fg=/" > /tmp/_result

vim -c 'Tabularize/[bf]g=.*' /tmp/_result -c 'wq'
sed 's/^ftype-//' /tmp/_result|awk '{print "*."$1") style=$ZSH_HIGHLIGHT_STYLES[ftype-"$1"];;"}' > /tmp/_rules
vim -c 'Tabularize/)\zs ' /tmp/_rules -c 'wq'

eat /tmp/_result
eat /tmp/_rules

rm -vf /tmp/{generation,_{fill,result,rules}} && echo :: Cleanup done ::
