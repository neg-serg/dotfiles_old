#!/bin/zsh

function contains_element () {
    local e
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
    return 1
}

function main(){
    local dist_dir="/one/dist"
    local jetbrain_products=(idea pycharm rubymine webstorm clion)
    for i in ${jetbrain_products[@]}; do
        jetbrains_path="${dist_dir}/${i}/bin/${i}.sh"
        jetbrains_path_alter="/opt/${i}/bin/${i}.sh"
        if readlink -fq ${jetbrains_path}>/dev/null; then
            alias "$i=${jetbrains_path} > /dev/shm/${i}$$ &" 
        fi
        if readlink -fq ${jetbrains_path_alter} > /dev/null; then
            alias "$i=${jetbrains_path_alter} > /dev/shm/${i}$$ &" 
        fi
    done
    if contains_element "$1" ${jetbrain_products[@]}; then
        eval "$1"
    fi
}

main $1
