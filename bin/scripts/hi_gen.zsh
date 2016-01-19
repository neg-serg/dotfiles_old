#!/bin/zsh

function eat () {
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

function main() {
    local ftype_pref="ftype-"
    local dircolors_location="${XDG_CONFIG_HOME}/dircolors/.dircolors"

    local tmp_file=$(mktemp)
    local ftype_arr="/tmp/ftype_arr"
    local ftype_rule="/tmp/ftype_rule"

    local is_bold="\\(01;\|;1\\)"
    local is_uline="\\(04;\|;4\\)"
    local bold_regex="/${is_bold}/"
    local uline_regex="/${is_uline}/"

    local fg_eq="38;5;" bg_eq="48;5;"

    egrep '^[.*]' ${1:-$dircolors_location}|sed 's/#.*//'|sed "s/^\.\W*/${ftype_pref}/" > ${tmp_file}

    echo "-----------------------------"
    echo "you should handle it by hand:"
    echo "-----------------------------"

    egrep "^${ftype_pref}" -v ${tmp_file} 
    egrep "^${ftype_pref}" ${tmp_file} | sed -e "s/${fg_eq}/fg=/"               \
                                             -e "s/${bg_eq}/bg=/g"              \
                                             -e "${bold_regex}s/$/,bold/"       \
                                             -e "${uline_regex}s/$/,underline/" \
                                             -e "s/00;//"                       \
                                             -e "s/${is_bold}//"                \
                                             -e "s/${is_uline}//"               \
                                             -e "s/;/,/g"                       \
                                             -e "/\ 3[0-9][0-9]*/s/3/fg=/"      \
                                             -e "s/, //g" > ${ftype_arr}

    vim -c 'Tabularize/[bf]g=.*' ${ftype_arr} -c 'wq'
    sed "s/^${ftype_pref}//" ${ftype_arr}|awk '{print "*."$1") style=$ZSH_HIGHLIGHT_STYLES[ftype-"$1"];;"}' > ${ftype_rule}
    vim -c 'Tabularize/)\zs ' ${ftype_rule} -c 'wq'

    for t in "${ftype_arr}" "${ftype_rule}"; eat ${t}

    # rm -vf /tmp/{generation,_{fill,result,rules}} && echo :: Cleanup done ::
}

main $1
