#!/bin/zsh

function 256colors(){
    for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

function reference() {
    echo -en "\n   +  "
    for i in {0..35}; do
        printf "%2b " $i
    done
    printf "\n\n %3b  " 0
    for i in {0..15}; do
        echo -en "\033[48;5;${i}m  \033[m "
    done
    #for i in 16 52 88 124 160 196 232; do
    for i in {0..6}; do
        let "i = i*36 +16"
        printf "\n\n %3b  " $i
        for j in {0..35}; do
            let "val = i+j"
            echo -en "\033[48;5;${val}m  \033[m "
        done
    done
    echo -e "\n"
}

function pacman() {
    init_ansi
    cat << EOF

    ${yellowf}  ▄███████▄${reset}   ${redf}  ▄██████▄${reset}    ${greenf}  ▄██████▄${reset}    ${bluef}  ▄██████▄${reset}    ${purplef}  ▄██████▄${reset}    ${cyanf}  ▄██████▄${reset}
    ${yellowf}▄█████████▀▀${reset}  ${redf}▄${whitef}█▀█${redf}██${whitef}█▀█${redf}██▄${reset}  ${greenf}▄${whitef}█▀█${greenf}██${whitef}█▀█${greenf}██▄${reset}  ${bluef}▄${whitef}█▀█${bluef}██${whitef}█▀█${bluef}██▄${reset}  ${purplef}▄${whitef}█▀█${purplef}██${whitef}█▀█${purplef}██▄${reset}  ${cyanf}▄${whitef}█▀█${cyanf}██${whitef}█▀█${cyanf}██▄${reset}
    ${yellowf}███████▀${reset}      ${redf}█${whitef}▄▄█${redf}██${whitef}▄▄█${redf}███${reset}  ${greenf}█${whitef}▄▄█${greenf}██${whitef}▄▄█${greenf}███${reset}  ${bluef}█${whitef}▄▄█${bluef}██${whitef}▄▄█${bluef}███${reset}  ${purplef}█${whitef}▄▄█${purplef}██${whitef}▄▄█${purplef}███${reset}  ${cyanf}█${whitef}▄▄█${cyanf}██${whitef}▄▄█${cyanf}███${reset}
    ${yellowf}███████▄${reset}      ${redf}████████████${reset}  ${greenf}████████████${reset}  ${bluef}████████████${reset}  ${purplef}████████████${reset}  ${cyanf}████████████${reset}
    ${yellowf}▀█████████▄▄${reset}  ${redf}██▀██▀▀██▀██${reset}  ${greenf}██▀██▀▀██▀██${reset}  ${bluef}██▀██▀▀██▀██${reset}  ${purplef}██▀██▀▀██▀██${reset}  ${cyanf}██▀██▀▀██▀██${reset}
    ${yellowf}  ▀███████▀${reset}   ${redf}▀   ▀  ▀   ▀${reset}  ${greenf}▀   ▀  ▀   ▀${reset}  ${bluef}▀   ▀  ▀   ▀${reset}  ${purplef}▀   ▀  ▀   ▀${reset}  ${cyanf}▀   ▀  ▀   ▀${reset}

    ${boldon}${yellowf}  ▄███████▄   ${redf}  ▄██████▄    ${greenf}  ▄██████▄    ${bluef}  ▄██████▄    ${purplef}  ▄██████▄    ${cyanf}  ▄██████▄${reset}
    ${boldon}${yellowf}▄█████████▀▀  ${redf}▄${whitef}█▀█${redf}██${whitef}█▀█${redf}██▄  ${greenf}▄${whitef}█▀█${greenf}██${whitef}█▀█${greenf}██▄  ${bluef}▄${whitef}█▀█${bluef}██${whitef}█▀█${bluef}██▄  ${purplef}▄${whitef}█▀█${purplef}██${whitef}█▀█${purplef}██▄  ${cyanf}▄${whitef}█▀█${cyanf}██${whitef}█▀█${cyanf}██▄${reset}
    ${boldon}${yellowf}███████▀      ${redf}█${whitef}▄▄█${redf}██${whitef}▄▄█${redf}███  ${greenf}█${whitef}▄▄█${greenf}██${whitef}▄▄█${greenf}███  ${bluef}█${whitef}▄▄█${bluef}██${whitef}▄▄█${bluef}███  ${purplef}█${whitef}▄▄█${purplef}██${whitef}▄▄█${purplef}███  ${cyanf}█${whitef}▄▄█${cyanf}██${whitef}▄▄█${cyanf}███${reset}
    ${boldon}${yellowf}███████▄      ${redf}████████████  ${greenf}████████████  ${bluef}████████████  ${purplef}████████████  ${cyanf}████████████${reset}
    ${boldon}${yellowf}▀█████████▄▄  ${redf}██▀██▀▀██▀██  ${greenf}██▀██▀▀██▀██  ${bluef}██▀██▀▀██▀██  ${purplef}██▀██▀▀██▀██  ${cyanf}██▀██▀▀██▀██${reset}
    ${boldon}${yellowf}  ▀███████▀   ${redf}▀   ▀  ▀   ▀  ${greenf}▀   ▀  ▀   ▀  ${bluef}▀   ▀  ▀   ▀  ${purplef}▀   ▀  ▀   ▀  ${cyanf}▀   ▀  ▀   ▀${reset}

EOF
}

function colorvalues() {
    local xdef="${XDG_CONFIG_HOME}/xres/colors/current_colors"
    local colors=( $( sed -re '/^!/d; /^$/d; /^#/d; s/(\*color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort | sed  's/^.*: *//g' ) )
    echo -e "\e[1;37m
    Black    Red      Green    Yellow   Blue     Magenta   Cyan    White
    ──────────────────────────────────────────────────────────────────────\e[0m"
    for i in {0..7}; do echo -en "\e[$((30+$i))m ${colors[i]} \e[0m"; done
    echo
    for i in {8..15}; do echo -en "\e[1;$((22+$i))m ${colors[i]} \e[0m"; done
    echo -e "\n"
}


function init_ansi() {
  esc=""
  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"
  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
  cyanb="${esc}[46m";    whiteb="${esc}[47m"
  boldon="${esc}[1m";    boldoff="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"
  reset="${esc}[0m"
}

# note in this first use that switching colors doesn't require a reset
# first - the new color overrides the old one.

function invader() {
    f=3 b=4
    for j in f b; do
    for i in {0..7}; do
        eval ${j}${i}=\$\'\\e\[${!j}${i}m\'
    done
    done
    bld=$'\e[1m'
    rst=$'\e[0m'

    cat << EOF

    $f0  ▄██▄     $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄   $rst
    $f0▄█▀██▀█▄   $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄ $rst       
    $f0▀▀█▀▀█▀▀   $f1█▀███████▀█   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4█▀███████▀█   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀ $rst        
    $f0▄▀▄▀▀▄▀▄   $f1▀ ▀▄▄ ▄▄▀ ▀   $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄ $rst        

    $bld $f0  ▄██▄     $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
    $bld $f0▄█▀██▀█▄   $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
    $bld $f0▀▀█▀▀█▀▀   $f1█▀███████▀█   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4█▀███████▀█   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀$rst
    $bld $f0▄▀▄▀▀▄▀▄   $f1▀ ▀▄▄ ▄▄▀ ▀   $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄$rst


                                                $f7▌$rst

                                                $f7▌$rst

                                            $f7    ▄█▄    $rst
                                            $f7▄█████████▄$rst
                                            $f7▀▀▀▀▀▀▀▀▀▀▀$rst

EOF
}


function ansi(){
    init_ansi
    cat << EOF

    ${redf}▒▒▒▒${reset} ${boldon}${redf}▒▒${reset}   ${greenf}▒▒▒▒${reset} ${boldon}${greenf}▒▒${reset}   ${yellowf}▒▒▒▒${reset} ${boldon}${yellowf}▒▒${reset}   ${bluef}▒▒▒▒${reset} ${boldon}${bluef}▒▒${reset}   ${purplef}▒▒▒▒${reset} ${boldon}${purplef}▒▒${reset}   ${cyanf}▒▒▒▒${reset} ${boldon}${cyanf}▒▒${reset} 
    ${redf}▒▒ ■${reset} ${boldon}${redf}▒▒${reset}   ${greenf}▒▒ ■${reset} ${boldon}${greenf}▒▒${reset}   ${yellowf}▒▒ ■${reset} ${boldon}${yellowf}▒▒${reset}   ${bluef}▒▒ ■${reset} ${boldon}${bluef}▒▒${reset}   ${purplef}▒▒ ■${reset} ${boldon}${purplef}▒▒${reset}   ${cyanf}▒▒ ■${reset} ${boldon}${cyanf}▒▒${reset}  
    ${redf}▒▒ ${reset}${boldon}${redf}▒▒▒▒${reset}   ${greenf}▒▒ ${reset}${boldon}${greenf}▒▒▒▒${reset}   ${yellowf}▒▒ ${reset}${boldon}${yellowf}▒▒▒▒${reset}   ${bluef}▒▒ ${reset}${boldon}${bluef}▒▒▒▒${reset}   ${purplef}▒▒ ${reset}${boldon}${purplef}▒▒▒▒${reset}   ${cyanf}▒▒ ${reset}${boldon}${cyanf}▒▒▒▒${reset}  

EOF
}

function dump(){
    app=$@;

    ansi="$(xrdb -query | grep -Ei ${app}[.*]color[01-9] | sort -n -tr -k2 | cut -d: -f2 | tr -d '[:blank:]')"

    echo "
    BLK      RED      GRN      YEL      BLU      MAG      CYN      WHT  "
    for i in {0..7}; do printf '%b' "\e[0;3${i}m $(echo "${ansi}" | sed -n $(($i+1))'p')\e[0m "; done;
    echo
    for i in {0..7}; do printf '%b' "\e[0;9${i}m $(echo "${ansi}" | sed -n $(($i+9))'p')\e[0m "; done;
    echo
    echo
}


function numbers (){
    init_ansi
    cat << EOF

    ${blackf}11111111${reset} ${redf}22222222${reset} ${greenf}33333333${reset} ${yellowf}44444444${reset} ${bluef}55555555${reset} ${purplef}66666666${reset} ${cyanf}77777777${reset} ${whitef}88888888${reset}
    ${blackb}11111111${reset} ${redb}22222222${reset} ${greenb}33333333${reset} ${yellowb}44444444${reset} ${blueb}55555555${reset} ${purpleb}66666666${reset} ${cyanb}77777777${reset} ${whiteb}88888888${reset}

EOF

}

function blocks (){
    init_ansi

    cat << EOF

    ${blackf}████${reset}${blackb}████${reset} ${redf}████${reset}${redb}████${reset} ${greenf}████${reset}${greenb}████${reset} ${yellowf}████${reset}${yellowb}████${reset} ${bluef}████${reset}${blueb}████${reset} ${purplef}████${reset}${purpleb}████${reset} ${cyanf}████${reset}${cyanb}████${reset} ${whitef}████${reset}${whiteb}████${reset}
    ${blackf}████${reset}${blackb}████${reset} ${redf}████${reset}${redb}████${reset} ${greenf}████${reset}${greenb}████${reset} ${yellowf}████${reset}${yellowb}████${reset} ${bluef}████${reset}${blueb}████${reset} ${purplef}████${reset}${purpleb}████${reset} ${cyanf}████${reset}${cyanb}████${reset} ${whitef}████${reset}${whiteb}████${reset}
    ${blackf}████${reset}${blackb}████${reset} ${redf}████${reset}${redb}████${reset} ${greenf}████${reset}${greenb}████${reset} ${yellowf}████${reset}${yellowb}████${reset} ${bluef}████${reset}${blueb}████${reset} ${purplef}████${reset}${purpleb}████${reset} ${cyanf}████${reset}${cyanb}████${reset} ${whitef}████${reset}${whiteb}████${reset}

EOF

}

function colorformatting(){
    for clbg in {40..47} {100..107} 49 ; do
        #Foreground
        for clfg in {30..37} {90..97} 39 ; do
            #Formatting
            for attr in 0 1 2 4 5 7 ; do
                #Print the result
                echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
            done
            echo #Newline
        done
    done
}

function list() {
    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m\
        44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
            '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
            '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
    done
    echo
}

function all() {
    local START_COLOR=0
    local END_COLOR=255
    local LINE_LENGTH=16
    local i=$START_COLOR
    local only_block=0
    [[ $# -gt 0 ]] && [[ $@ = '-b' ]] && only_block=1
    printf '\n'
    while [[ $i -le $END_COLOR ]]; do
        if [[ $only_block -eq 1 ]]; then printf "\033[38;5;${i}m%s" '█'; else printf "\033[38;5;${i}m%s%03u" '■' $i;fi
        [ $(((i - START_COLOR + 1) % LINE_LENGTH)) -eq 0 -a $i -gt $START_COLOR ] && printf '\n'
        i=$((i + 1))
    done
    printf '\033[0m\n\n'
}

function bars() {
    init_ansi
    cat << EOF

    ${redf}▆▆▆▆▆▆▆▆▆▆${reset} ${greenf}▆▆▆▆▆▆▆▆▆▆${reset} ${yellowf}▆▆▆▆▆▆▆▆▆▆${reset} ${bluef}▆▆▆▆▆▆▆▆▆▆${reset} ${purplef}▆▆▆▆▆▆▆▆▆▆${reset} ${cyanf}▆▆▆▆▆▆▆▆▆▆${reset} ${whitef}▆▆▆▆▆▆▆▆▆▆${reset}
    ${boldon}${blackf} ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
    ${boldon}${redf}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${greenf}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${yellowf}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${bluef}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${purplef}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${cyanf}▆▆▆▆▆▆▆▆▆▆${reset} ${boldon}${whitef}▆▆▆▆▆▆▆▆▆▆${reset}

EOF
}

function minicolors() {
    init_ansi
    cat << EOF

    ${redf}■■■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■■■${reset}${boldon}${cyanf}■■${reset} 
    ${redf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${redf}■■■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■■■${reset}${boldon}${cyanf}■■${reset} 
    ${redf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${redf}■■■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■■■${reset}${boldon}${cyanf}■■${reset} 
    ${redf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${greenf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${yellowf}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${bluef}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${cyanf}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
    ${greenf}■■${reset}${boldon}${greenf}■■${reset}${boldon}${redf}■■${reset}   ${yellowf}■■${reset}${boldon}${yellowf}■■${reset}${boldon}${greenf}■■${reset}   ${bluef}■■${reset}${boldon}${bluef}■■${reset}${boldon}${yellowf}■■${reset}   ${boldon}${cyanf}■■${reset}${purplef}■■${reset}${boldon}${purplef}■■${reset}   ${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset}${boldon}${bluef}■■${reset}   ${bluef}■■${reset}${boldon}${purplef}■■${reset}${boldon}${cyanf}■■${reset} 
 
EOF
}

function fancy(){
    FGNAMES=(' black ' '  red  ' ' green ' ' yellow' '  blue ' 'magenta' '  cyan ' ' white ')
    BGNAMES=('DFT' 'BLK' 'RED' 'GRN' 'YEL' 'BLU' 'MAG' 'CYN' 'WHT')
    echo "     ┌──────────────────────────────────────────────────────────────────────────┐"
    for b in $(seq 0 8); do
        if [ "$b" -gt 0 ]; then
        bg=$(($b+39))
        fi

        echo -en "\033[0m ${BGNAMES[$b]} │ "
        for f in $(seq 0 7); do
        echo -en "\033[${bg}m\033[$(($f+30))m ${FGNAMES[$f]} "
        done
        echo -en "\033[0m │"

        echo -en "\033[0m\n\033[0m     │ "
        for f in $(seq 0 7); do
        echo -en "\033[${bg}m\033[1;$(($f+30))m ${FGNAMES[$f]} "
        done
        echo -en "\033[0m │"
            echo -e "\033[0m"
            
    if [ "$b" -lt 8 ]; then
        echo "     ├──────────────────────────────────────────────────────────────────────────┤"
    fi
    done
    echo "     └──────────────────────────────────────────────────────────────────────────┘"
}

function 24bit(){
    for i in {0..255}; do echo -e -n "\033[38;2;${i};0;0m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;0;${i};0m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;0;0;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;${i};128;128m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;128;${i};128m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;128;128;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;${i};192;192m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;192;${i};192m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;192;192;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;${i};224;224m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;224;${i};224m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;224;224;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;${i};64;64m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;64;${i};64m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;64;64;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;${i};32;32m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;32;${i};32m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;32;32;${i}m█"; done; echo
    for i in {0..255}; do echo -e -n "\033[38;2;255;255;${i}m█"; done; echo
}

function tmux_pallete(){
    for i in $(seq 0 4 255); do
        for j in $(seq $i $(expr $i + 3)); do
            for k in $(seq 1 $(expr 3 - ${#j})); do
                printf " "
            done
            printf "\x1b[38;5;${j}mcolour${j}"
            [[ $(expr $j % 4) != 3 ]] && printf "    "
        done
        printf "\n"
    done
}

function spectrum(){
    typeset -Ag FG BG

    for color in {0..255}; do
        FG[$color]="%{[38;5;${color}m%}"
        BG[$color]="%{[48;5;${color}m%}"
    done

    for color in {0..255}; do print -P "${FG[$color][3,-3]} $color $[ [##16] $color ]" ; done
}

function ls_colors(){
    typeset -A names
    names[no]="global default"
    names[fi]="normal file"
    names[di]="directory"
    names[ln]="symbolic link"
    names[pi]="named pipe"
    names[so]="socket"
    names[do]="door"
    names[bd]="block device"
    names[cd]="character device"
    names[or]="orphan symlink"
    names[mi]="missing file"
    names[su]="set uid"
    names[sg]="set gid"
    names[tw]="sticky other writable"
    names[ow]="other writable"
    names[st]="sticky"
    names[ex]="executable"
    for i in ${(s.:.)LS_COLORS}; do
        key=${i%\=*}
        color=${i#*\=}
        name=${names[(e)$key]-$key}
        printf '\e[%sm%s\e[m\n' $color $name
    done
}


case $1 in
    ""|ref) reference ;;
    256) 256colors; exit 0 ;;
    24) 24bit; exit 0 ;;
    colorvalues) colorvalues; exit 0 ;;
    inv) invader; exit 0 ;;
    ansi) ansi; exit 0 ;;
    numb) numbers; exit 0 ;;
    blk) blocks; exit 0 ;;
    dump) shift; dump $@; exit 0 ;;
    fmt) colorformatting; exit 0 ;;
    pac) pacman; exit 0 ;;
    list) list; exit 0 ;;
    all) all; exit 0 ;;
    bar) bars; exit 0 ;;
    fn) fancy; exit 0 ;;
    tmux) tmux_pallete; exit 0 ;;
    spectr) spectrum; exit 0 ;; 
    ls) ls_colors; exit 0 ;;
esac
