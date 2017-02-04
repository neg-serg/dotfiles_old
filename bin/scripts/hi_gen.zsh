#!/bin/zsh

source ${ZSH}/03-helpers.zsh

autoload colors && colors

function eat () {
    prog=${0##*/}
    local pass="*"
    filename="$@"
    xclip -in -selection c < "${filename}"
    _zwrap "${pass} ${txtund}"${filename##*/}"${txtrst} copied to clipboard"
}

function main() {
    readonly ftype_pref="ftype-"
    readonly dircolors_location="${XDG_CONFIG_HOME}/dircolors/.dircolors"

    readonly tmp_file="$(mktemp)"
    readonly ftype_arr="/tmp/ftype_arr"
    readonly ftype_rule="/tmp/ftype_rule"

    readonly is_bold="\\(01;\|;1\\)"
    readonly is_uline="\\(04;\|;4\\)"
    readonly bold_regex="/${is_bold}/"
    readonly uline_regex="/${is_uline}/"

    readonly fg_eq="38;5;" 
    readonly bg_eq="48;5;"

    egrep '^[.*]' ${1:-$dircolors_location} \
        |sed 's/#.*//' \
        |sed "s/^\.\W*/${ftype_pref}/" > "${tmp_file}"

    _zwrap "-----------------------------"
    _zwrap "You should handle it by hand:"
    _zwrap "-----------------------------"

    egrep "^${ftype_pref}" -v "${tmp_file}"
    egrep "^${ftype_pref}" "${tmp_file}" | sed -e "s/${fg_eq}/fg=/"               \
                                               -e "s/${bg_eq}/bg=/g"              \
                                               -e "${bold_regex}s/$/,bold/"       \
                                               -e "${uline_regex}s/$/,underline/" \
                                               -e "s/00;//"                       \
                                               -e "s/${is_bold}//"                \
                                               -e "s/${is_uline}//"               \
                                               -e "s/;/,/g"                       \
                                               -e "/\ 3[0-9][0-9]*/s/3/fg=/"      \
                                               -e "s/, //g" > "${ftype_arr}"

    nohup zsh -c "vim +'Tabularize/[bf]g=.*' "${ftype_arr}" +'wq'" 2> /tmp/vimlol
    sed "s/^${ftype_pref}//" "${ftype_arr}" |awk '{print "*."$1") style=ftype-"$1" ;;"}' > "${ftype_rule}"
    nohup zsh -c "vim +'Tabularize/)\zs ' "${ftype_rule}" +'wq'" 2> /tmp/vimlol

    for t in "${ftype_arr}" "${ftype_rule}"; eat "${t}"
    rm "${tmp_file}"
}

main "${1}"
