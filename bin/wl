#!/bin/zsh

. ${XDG_CONFIG_HOME}/.wallpapers
. ~/.zsh/03-helpers.zsh

local wall_dir="${HOME}/pic/wl"
local prev_list="${HOME}/tmp/current_walls"
local settings="${HOME}/tmp/wl_settings"
local trash_dir="${HOME}/tmp/trash"

local last_count=40

save_current_wall(){ print "$1" > ${HOME}/tmp/current_wallpaper }
print_wall(){ print $(_zpref) $(_zfwrap "${1}") }
print_smth(){ print $(_zpref) $(_zwrap "${1}") }


function main(){
    current=$(< ${HOME}/tmp/current_wallpaper|head -1)
    [[ ! -f "${settings}"  ]] && print "full" > "${settings}"
    [[ $mode = "" ]] && mode="full"
    case ${1} in
        t*)
                mode=$(xargs <<< $(< "${settings}")|head -1)
                if [[ "${mode}" == "full" ]]; then
                    print "fill" > "${settings}"
                else
                    print "full" > "${settings}"
                fi
                print_smth "${mode}"
            ;;
        s*) 
            local -a filtered_wall_=()
            for i in ${wall_}; [[ -e "$i" ]] && filtered_wall_+=(${i})
            current="${wall_[$[RANDOM % $#filtered_wall_]+1]}"
            hsetroot -$mode "${current}" && save_current_wall "${current}" &
            ;;
        r*)
            local -a walls=(${wall_dir}/*.{jpg,png})
            local current="${walls[$[RANDOM % $#walls]+1]}"
            {
                print "${current}" >> "${prev_list}" && \
                local buf=$(tail -${last_count} "${prev_list}")
                echo "${buf}" > "${prev_list}"
            } &
            hsetroot -$mode "${current}" && save_current_wall "${current}" &
            ;;
        d*)
            [[ ! -d ${trash_dir} ]] && mkdir "${trash_dir}"
            mv -iv "$(tail -1 ${prev_list})" "${trash_dir}"
            ;;
        l*)
            while IFS='' read -r line; do
                print $(_zpref) $(_zfwrap "${line}")
            done < "${prev_list}"
            ;;
        (c|p)*)
            print_wall "${current}"
            xclip <<< "${current}"
            ;;
    esac
}

main "$@"
