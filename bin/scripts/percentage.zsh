#!/bin/zsh

function bar_output(){
    local bar_char='-'
    local bar_end_char="\\"
    local bar_fill_char="─"
    local length="$3"
    local current="$1"
    local maximum="$2"
    local percentage=$[${maximum}/${length}]
    local point=$[$current/$percentage]
    local remainder=$(echo $[$length - $point] | awk -F '.' '{print $1}')
    local bar_string
    local pt=$(echo $point| awk -F '.' '{print $1}')
    if [[ (( $pt  > 0 )) ]]; then
        bar_string=$(printf $bar_char%.0s {1..$pt})
    else
        bar_string=$(printf $bar_char)
    fi
    if [[ $current -ne $maximum ]]; then
        bar_string="$bar_string$bar_end_char"
    fi
    local len=${#bar_string}
    if [[ $len -ne $length ]]; then
        if [[ (( $remainder > 0 )) ]]; then
            print_side=$(printf $bar_fill_char%.0s {1..$(($remainder + 1))})
        else
            print_side=$(printf $bar_fill_char)
        fi
        bar_string="$bar_string$print_side"
    fi
    printf '%s\n' $bar_string
}

function main(){
    bar_output $1 $2 $3
}

main $1 $2 $3
