#!/bin/zsh    

function setcol(){
    builtin printf "%b" "^fg($1)"
}

main(){
    local bracket_color="#287373"
    local fg_color="#cccccc"
    local left_side="[ "
    local right_side=" ]"

    if [[ $1 == "__left__" ]]; then
        builtin printf "$(setcol "${bracket_color}")${left_side}$(setcol "${fg_color}")"
        exit 0
    fi
    if [[ $1 == "__right__" ]]; then
        builtin printf "$(setcol "${bracket_color}")${right_side}$(setcol "${fg_color}")"
        exit 0
    fi


    builtin printf "%b" $(setcol "${bracket_color}") "${left_side}" \
            $(setcol "${fg_color}") "$1" $(setcol "${bracket_color}") \
            "${right_side}" $(setcol "${fg_color}")
}

main "$@"
