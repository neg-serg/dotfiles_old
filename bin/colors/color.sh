#!/bin/zsh

function tput_test(){
    for fg_ in {0..7}; do
        sf=$(tput setaf $fg_)
        for bg_ in {0..7}; do
            sb=$(tput setab $bg_)
            echo -n $sb$sf
            printf ' F:%s B:%s ' $fg_ $bg_
        done
        echo $(tput sgr0)
    done
}

function 256colors(){
    for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

function color8_init(){
    for i in {0..8}; do 
        printf -v f$i %b "\e[38;05;${i}m"
    done
    bld=$'\e[1m'
    rst=$'\e[0m'
    inv=$'\e[7m'
    w=$'\e[37m'
}

function init_ansi() {
    esc=""

    Bf="${esc}[30m";   rf="${esc}[31m";   gf="${esc}[32m"
    yf="${esc}[33m";   bf="${esc}[34m";   pf="${esc}[35m"
    cf="${esc}[36m";   wf="${esc}[37m";

    Bb="${esc}[40m";  rb="${esc}[41m";  gb="${esc}[42m"
    yb="${esc}[43m"   bb="${esc}[44m";   pb="${esc}[45m"
    cb="${esc}[46m";  wb="${esc}[47m"

    ON="${esc}[1m";        OFF="${esc}[22m"
    italicson="${esc}[3m"; italicsoff="${esc}[23m"
    ulon="${esc}[4m";      uloff="${esc}[24m"
    invon="${esc}[7m";     invoff="${esc}[27m"

    reset="${esc}[0m"
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

    ${yf}  ▄███████▄${reset}   ${rf}  ▄██████▄${reset}    ${gf}  ▄██████▄${reset}    ${bf}  ▄██████▄${reset}    ${pf}  ▄██████▄${reset}    ${cf}  ▄██████▄${reset}
    ${yf}▄█████████▀▀${reset}  ${rf}▄${wf}█▀█${rf}██${wf}█▀█${rf}██▄${reset}  ${gf}▄${wf}█▀█${gf}██${wf}█▀█${gf}██▄${reset}  ${bf}▄${wf}█▀█${bf}██${wf}█▀█${bf}██▄${reset}  ${pf}▄${wf}█▀█${pf}██${wf}█▀█${pf}██▄${reset}  ${cf}▄${wf}█▀█${cf}██${wf}█▀█${cf}██▄${reset}
    ${yf}███████▀${reset}      ${rf}█${wf}▄▄█${rf}██${wf}▄▄█${rf}███${reset}  ${gf}█${wf}▄▄█${gf}██${wf}▄▄█${gf}███${reset}  ${bf}█${wf}▄▄█${bf}██${wf}▄▄█${bf}███${reset}  ${pf}█${wf}▄▄█${pf}██${wf}▄▄█${pf}███${reset}  ${cf}█${wf}▄▄█${cf}██${wf}▄▄█${cf}███${reset}
    ${yf}███████▄${reset}      ${rf}████████████${reset}  ${gf}████████████${reset}  ${bf}████████████${reset}  ${pf}████████████${reset}  ${cf}████████████${reset}
    ${yf}▀█████████▄▄${reset}  ${rf}██▀██▀▀██▀██${reset}  ${gf}██▀██▀▀██▀██${reset}  ${bf}██▀██▀▀██▀██${reset}  ${pf}██▀██▀▀██▀██${reset}  ${cf}██▀██▀▀██▀██${reset}
    ${yf}  ▀███████▀${reset}   ${rf}▀   ▀  ▀   ▀${reset}  ${gf}▀   ▀  ▀   ▀${reset}  ${bf}▀   ▀  ▀   ▀${reset}  ${pf}▀   ▀  ▀   ▀${reset}  ${cf}▀   ▀  ▀   ▀${reset}

    ${ON}${yf}  ▄███████▄   ${rf}  ▄██████▄    ${gf}  ▄██████▄    ${bf}  ▄██████▄    ${pf}  ▄██████▄    ${cf}  ▄██████▄${reset}
    ${ON}${yf}▄█████████▀▀  ${rf}▄${wf}█▀█${rf}██${wf}█▀█${rf}██▄  ${gf}▄${wf}█▀█${gf}██${wf}█▀█${gf}██▄  ${bf}▄${wf}█▀█${bf}██${wf}█▀█${bf}██▄  ${pf}▄${wf}█▀█${pf}██${wf}█▀█${pf}██▄  ${cf}▄${wf}█▀█${cf}██${wf}█▀█${cf}██▄${reset}
    ${ON}${yf}███████▀      ${rf}█${wf}▄▄█${rf}██${wf}▄▄█${rf}███  ${gf}█${wf}▄▄█${gf}██${wf}▄▄█${gf}███  ${bf}█${wf}▄▄█${bf}██${wf}▄▄█${bf}███  ${pf}█${wf}▄▄█${pf}██${wf}▄▄█${pf}███  ${cf}█${wf}▄▄█${cf}██${wf}▄▄█${cf}███${reset}
    ${ON}${yf}███████▄      ${rf}████████████  ${gf}████████████  ${bf}████████████  ${pf}████████████  ${cf}████████████${reset}
    ${ON}${yf}▀█████████▄▄  ${rf}██▀██▀▀██▀██  ${gf}██▀██▀▀██▀██  ${bf}██▀██▀▀██▀██  ${pf}██▀██▀▀██▀██  ${cf}██▀██▀▀██▀██${reset}
    ${ON}${yf}  ▀███████▀   ${rf}▀   ▀  ▀   ▀  ${gf}▀   ▀  ▀   ▀  ${bf}▀   ▀  ▀   ▀  ${pf}▀   ▀  ▀   ▀  ${cf}▀   ▀  ▀   ▀${reset}

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


# note in this first use that switching colors doesn't require a reset
# first - the new color overrides the old one.

function invader() {
    color8_init
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

    ${rf}▒▒▒▒${reset} ${ON}${rf}▒▒${reset}   ${gf}▒▒▒▒${reset} ${ON}${gf}▒▒${reset}   ${yf}▒▒▒▒${reset} ${ON}${yf}▒▒${reset}   ${bf}▒▒▒▒${reset} ${ON}${bf}▒▒${reset}   ${pf}▒▒▒▒${reset} ${ON}${pf}▒▒${reset}   ${cf}▒▒▒▒${reset} ${ON}${cf}▒▒${reset} 
    ${rf}▒▒ ■${reset} ${ON}${rf}▒▒${reset}   ${gf}▒▒ ■${reset} ${ON}${gf}▒▒${reset}   ${yf}▒▒ ■${reset} ${ON}${yf}▒▒${reset}   ${bf}▒▒ ■${reset} ${ON}${bf}▒▒${reset}   ${pf}▒▒ ■${reset} ${ON}${pf}▒▒${reset}   ${cf}▒▒ ■${reset} ${ON}${cf}▒▒${reset}  
    ${rf}▒▒ ${reset}${ON}${rf}▒▒▒▒${reset}   ${gf}▒▒ ${reset}${ON}${gf}▒▒▒▒${reset}   ${yf}▒▒ ${reset}${ON}${yf}▒▒▒▒${reset}   ${bf}▒▒ ${reset}${ON}${bf}▒▒▒▒${reset}   ${pf}▒▒ ${reset}${ON}${pf}▒▒▒▒${reset}   ${cf}▒▒ ${reset}${ON}${cf}▒▒▒▒${reset}  

EOF
}

function blocks (){
    init_ansi
    cat << EOF
    ${Bf}████${reset}${Bb}████${reset} ${rf}████${reset}${rb}████${reset} ${gf}████${reset}${gb}████${reset} ${yf}████${reset}${yb}████${reset} ${bf}████${reset}${bb}████${reset} ${pf}████${reset}${pb}████${reset} ${cf}████${reset}${cb}████${reset} ${wf}████${reset}${wb}████${reset}
    ${Bf}████${reset}${Bb}████${reset} ${rf}████${reset}${rb}████${reset} ${gf}████${reset}${gb}████${reset} ${yf}████${reset}${yb}████${reset} ${bf}████${reset}${bb}████${reset} ${pf}████${reset}${pb}████${reset} ${cf}████${reset}${cb}████${reset} ${wf}████${reset}${wb}████${reset}
    ${Bf}████${reset}${Bb}████${reset} ${rf}████${reset}${rb}████${reset} ${gf}████${reset}${gb}████${reset} ${yf}████${reset}${yb}████${reset} ${bf}████${reset}${bb}████${reset} ${pf}████${reset}${pb}████${reset} ${cf}████${reset}${cb}████${reset} ${wf}████${reset}${wb}████${reset}

EOF

}

function colorformatting(){
    for clbg in {40..47} {100..107} 49 ; do  #Foreground
        for clfg in {30..37} {90..97} 39 ; do #Formatting
            for attr in 0 1 2 4 5 7 ; do #Print the result
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
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m"; done
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

    ${rf}▆▆▆▆▆▆▆▆▆▆${reset} ${gf}▆▆▆▆▆▆▆▆▆▆${reset} ${yf}▆▆▆▆▆▆▆▆▆▆${reset} ${bf}▆▆▆▆▆▆▆▆▆▆${reset} ${pf}▆▆▆▆▆▆▆▆▆▆${reset} ${cf}▆▆▆▆▆▆▆▆▆▆${reset} ${wf}▆▆▆▆▆▆▆▆▆▆${reset}
    ${ON}${Bf} ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
    ${ON}${rf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${gf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${yf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${bf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${pf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${cf}▆▆▆▆▆▆▆▆▆▆${reset} ${ON}${wf}▆▆▆▆▆▆▆▆▆▆${reset}

EOF
}

function minicolors() {
    init_ansi
    cat << EOF

    ${rf}■■■■${reset}${ON}${rf}■■${reset}   ${gf}■■■■${reset}${ON}${gf}■■${reset}   ${yf}■■■■${reset}${ON}${yf}■■${reset}   ${bf}■■■■${reset}${ON}${pf}■■${reset}   ${pf}■■■■${reset}${ON}${bf}■■${reset}   ${cf}■■■■${reset}${ON}${cf}■■${reset} 
    ${rf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${gf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${yf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${bf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${cf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${rf}■■■■${reset}${ON}${rf}■■${reset}   ${gf}■■■■${reset}${ON}${gf}■■${reset}   ${yf}■■■■${reset}${ON}${yf}■■${reset}   ${bf}■■■■${reset}${ON}${pf}■■${reset}   ${pf}■■■■${reset}${ON}${bf}■■${reset}   ${cf}■■■■${reset}${ON}${cf}■■${reset} 
    ${rf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${gf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${yf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${bf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${cf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${rf}■■■■${reset}${ON}${rf}■■${reset}   ${gf}■■■■${reset}${ON}${gf}■■${reset}   ${yf}■■■■${reset}${ON}${yf}■■${reset}   ${bf}■■■■${reset}${ON}${pf}■■${reset}   ${pf}■■■■${reset}${ON}${bf}■■${reset}   ${cf}■■■■${reset}${ON}${cf}■■${reset} 
    ${rf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${gf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${yf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${bf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${cf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
    ${gf}■■${reset}${ON}${gf}■■${reset}${ON}${rf}■■${reset}   ${yf}■■${reset}${ON}${yf}■■${reset}${ON}${gf}■■${reset}   ${bf}■■${reset}${ON}${bf}■■${reset}${ON}${yf}■■${reset}   ${ON}${cf}■■${reset}${pf}■■${reset}${ON}${pf}■■${reset}   ${ON}${pf}■■${reset}${ON}${cf}■■${reset}${ON}${bf}■■${reset}   ${bf}■■${reset}${ON}${pf}■■${reset}${ON}${cf}■■${reset} 
 
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

function ira(){
color8_init
cat << EOF
$f1  ▄▄        ▄▄   $f2  ▄▄        ▄▄   $f3  ▄▄        ▄▄   $f4  ▄▄        ▄▄   $f5  ▄▄        ▄▄   $f6  ▄▄        ▄▄   
$f1▄█████▄  ▄█████▄ $f2▄█████▄  ▄█████▄ $f3▄█████▄  ▄█████▄ $f4▄█████▄  ▄█████▄ $f5▄█████▄  ▄█████▄ $f6▄█████▄  ▄█████▄ 
$f1███████▄▄███████ $f2███████▄▄███████ $f3███████▄▄███████ $f4███████▄▄███████ $f5███████▄▄███████ $f6███████▄▄███████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1  ████████████   $f2  ████████████   $f3  ████████████   $f4  ████████████   $f5  ████████████   $f6  ████████████   
$f1    ████████     $f2    ████████     $f3    ████████     $f4    ████████     $f5    ████████     $f6    ████████     
$f1      ████       $f2      ████       $f3      ████       $f4      ████       $f5      ████       $f6      ████       $bld
$f1  ▄▄        ▄▄   $f2  ▄▄        ▄▄   $f3  ▄▄        ▄▄   $f4  ▄▄        ▄▄   $f5  ▄▄        ▄▄   $f6  ▄▄        ▄▄   
$f1▄█████▄  ▄█████▄ $f2▄█████▄  ▄█████▄ $f3▄█████▄  ▄█████▄ $f4▄█████▄  ▄█████▄ $f5▄█████▄  ▄█████▄ $f6▄█████▄  ▄█████▄ 
$f1███████▄▄███████ $f2███████▄▄███████ $f3███████▄▄███████ $f4███████▄▄███████ $f5███████▄▄███████ $f6███████▄▄███████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1████████████████ $f2████████████████ $f3████████████████ $f4████████████████ $f5████████████████ $f6████████████████ 
$f1  ████████████   $f2  ████████████   $f3  ████████████   $f4  ████████████   $f5  ████████████   $f6  ████████████   
$f1    ████████     $f2    ████████     $f3    ████████     $f4    ████████     $f5    ████████     $f6    ████████     
$f1      ████       $f2      ████       $f3      ████       $f4      ████       $f5      ████       $f6      ████       $rst

Ира милая кошка ^_^
Мурмурмур! :)
Я тебя люблю)
EOF

}

function skulls(){
color8_init
cat << EOF
$f1  ▄▄▄▄▄▄▄   $f2  ▄▄▄▄▄▄▄   $f3  ▄▄▄▄▄▄▄   $f4  ▄▄▄▄▄▄▄   $f5  ▄▄▄▄▄▄▄   $f6  ▄▄▄▄▄▄▄   
$f1▄█▀     ▀█▄ $f2▄█▀     ▀█▄ $f3▄█▀     ▀█▄ $f4▄█▀     ▀█▄ $f5▄█▀     ▀█▄ $f6▄█▀     ▀█▄ 
$f1█         █ $f2█         █ $f3█         █ $f4█         █ $f5█         █ $f6█         █ 
$f1███ ▄ ██  █ $f2███ ▄ ██  █ $f3███ ▄ ██  █ $f4███ ▄ ██  █ $f5███ ▄ ██  █ $f6███ ▄ ██  █ 
$f1█▄     ▄▄██ $f2█▄     ▄▄██ $f3█▄     ▄▄██ $f4█▄     ▄▄██ $f5█▄     ▄▄██ $f6█▄     ▄▄██ 
$f1 █▄█▄█▄██▀  $f2 █▄█▄█▄██▀  $f3 █▄█▄█▄██▀  $f4 █▄█▄█▄██▀  $f5 █▄█▄█▄██▀  $f6 █▄█▄█▄██▀  $bld
$f1  ▄▄▄▄▄▄▄   $f2  ▄▄▄▄▄▄▄   $f3  ▄▄▄▄▄▄▄   $f4  ▄▄▄▄▄▄▄   $f5  ▄▄▄▄▄▄▄   $f6  ▄▄▄▄▄▄▄   
$f1▄█▀     ▀█▄ $f2▄█▀     ▀█▄ $f3▄█▀     ▀█▄ $f4▄█▀     ▀█▄ $f5▄█▀     ▀█▄ $f6▄█▀     ▀█▄ 
$f1█         █ $f2█         █ $f3█         █ $f4█         █ $f5█         █ $f6█         █ 
$f1███ ▄ ██  █ $f2███ ▄ ██  █ $f3███ ▄ ██  █ $f4███ ▄ ██  █ $f5███ ▄ ██  █ $f6███ ▄ ██  █ 
$f1█▄     ▄▄██ $f2█▄     ▄▄██ $f3█▄     ▄▄██ $f4█▄     ▄▄██ $f5█▄     ▄▄██ $f6█▄     ▄▄██ 
$f1 █▄█▄█▄██▀  $f2 █▄█▄█▄██▀  $f3 █▄█▄█▄██▀  $f4 █▄█▄█▄██▀  $f5 █▄█▄█▄██▀  $f6 █▄█▄█▄██▀  
$rst
EOF
}

initializeANSI()
{
  esc=""

  Bf="${esc}[30m";   rf="${esc}[31m";   gf="${esc}[32m"
  yf="${esc}[33m";   bf="${esc}[34m";   pf="${esc}[35m"
  cf="${esc}[36m";   wf="${esc}[37m";
  
  Bb="${esc}[40m";  rb="${esc}[41m";  gb="${esc}[42m"
  yb="${esc}[43m"   bb="${esc}[44m";   pb="${esc}[45m"
  cb="${esc}[46m";  wb="${esc}[47m"

  ON="${esc}[1m";        OFF="${esc}[22m"
  italicson="${esc}[3m"; italicsoff="${esc}[23m"
  ulon="${esc}[4m";      uloff="${esc}[24m"
  invon="${esc}[7m";     invoff="${esc}[27m"

  reset="${esc}[0m"
}

function poke(){
init_ansi

cat << EOF
                        ${Bf}██████                    ${Bf}████████                  ██              ${Bf}████████                  ████████
                      ${Bf}██${gf}${ON}██████${OFF}${Bf}██                ${Bf}██${rf}${ON}██████${OFF}██${Bf}██              ██${rf}██${Bf}██          ${Bf}██${bf}${ON}██████${OFF}██${Bf}████            ██${bf}${ON}████████${OFF}${Bf}██
                  ${Bf}██████${gf}${ON}██████${OFF}${Bf}██              ${Bf}██${rf}${ON}██████████${OFF}██${Bf}██            ██${rf}████${Bf}██      ${Bf}██${bf}${ON}████████████${OFF}██${Bf}████      ████${bf}${ON}██████${OFF}████${Bf}██
              ${Bf}████${gf}${ON}████${OFF}██${ON}████${OFF}██${ON}██${OFF}${Bf}████          ${Bf}██${rf}${ON}████████████${OFF}${Bf}██            ██${rf}████${Bf}██      ${Bf}██${bf}${ON}██████████████${OFF}${Bf}██${pf}██${Bf}████  ██${bf}${ON}████${OFF}██${Bf}██${bf}████${Bf}██
      ${Bf}██    ██${gf}${ON}██████${OFF}████${ON}████${OFF}██${ON}██████${OFF}${Bf}██      ${Bf}██${rf}${ON}██████████████${OFF}██${Bf}██        ██${rf}████${yf}██${rf}██${Bf}██  ${Bf}██${bf}${ON}████████████████${OFF}██${pf}██${ON}██${OFF}██${Bf}██${bf}██${ON}██${OFF}██${Bf}██${bf}██████${Bf}██
    ${Bf}██${cf}${ON}██${OFF}${Bf}██████${gf}${ON}████${OFF}██${ON}██${OFF}██${ON}██████${OFF}██${ON}██████${OFF}${Bf}██  ${Bf}██${rf}${ON}████████${wf}██${OFF}${Bf}██${rf}${ON}████${OFF}██${Bf}██        ██${rf}██${yf}██${ON}██${OFF}${rf}██${Bf}██  ${Bf}██${bf}${ON}████████${wf}${ON}██${OFF}${Bf}██${bf}${ON}████${OFF}██${wf}${ON}██${OFF}${pf}${ON}████${OFF}██${Bf}██${bf}████${Bf}██${bf}████${Bf}██
    ${Bf}██${cf}${ON}██████${OFF}${Bf}████${gf}██${ON}██${OFF}██${ON}██████████${OFF}██${ON}████${OFF}${Bf}██  ${Bf}██${rf}${ON}████████${OFF}${Bf}████${rf}${ON}██${OFF}██████${Bf}██      ██${rf}██${yf}${ON}████${OFF}${rf}██${Bf}██  ${Bf}██${bf}██${ON}██████${OFF}${Bf}████${bf}${ON}██${OFF}████${wf}${ON}██${pf}██████${OFF}${Bf}██${bf}██${Bf}████████
    ${Bf}██${cf}${ON}████████${OFF}██${Bf}██${gf}${ON}██${OFF}██${ON}██████████${OFF}██${ON}████${OFF}${Bf}██  ${Bf}██${rf}${ON}████████${OFF}${Bf}████${rf}${ON}██${OFF}██████${Bf}██        ██${yf}${ON}██${OFF}${Bf}████      ${Bf}██${bf}████${ON}██${OFF}${Bf}████${bf}██████${Bf}██${wf}${ON}████${pf}██${OFF}██${Bf}████
  ${Bf}██${cf}${ON}████${OFF}██${ON}██${OFF}████${ON}██${OFF}${Bf}██████${gf}${ON}████████${OFF}██${ON}██${OFF}${Bf}██      ${Bf}██${rf}██${ON}████████${OFF}██████████${Bf}██      ██${rf}${ON}██${OFF}${Bf}██          ${Bf}████${bf}████████${Bf}████${bf}${ON}████${wf}██${OFF}${pf}████${Bf}██
${Bf}████${cf}██${ON}████████████████${OFF}${Bf}██${gf}██████${Bf}████████        ${Bf}████${rf}██████████████████${Bf}██  ██${rf}${ON}████${OFF}${Bf}██          ${Bf}██${bf}${ON}██${OFF}${Bf}████████${bf}${ON}██████${OFF}██${wf}${ON}██${OFF}${pf}████${Bf}██
${Bf}██${cf}████${ON}██████${OFF}██${ON}██████${OFF}${Bf}██${cf}██${Bf}██████${cf}██████${Bf}██            ${Bf}██████${rf}████${Bf}██${rf}██████${Bf}████${rf}██${ON}██${OFF}${Bf}██              ${Bf}████${yf}${ON}████${OFF}${Bf}██${bf}${ON}████${OFF}██${Bf}██${wf}${ON}██${OFF}${pf}████${Bf}██
${Bf}██${cf}${ON}████████${OFF}██${ON}██${OFF}${Bf}████${cf}${ON}██${OFF}██████████${Bf}██${cf}██${wf}${ON}██${OFF}${Bf}██              ${Bf}██${yf}${ON}████${OFF}${Bf}██${rf}${ON}████${OFF}${rf}██████${Bf}██${rf}██${ON}██${OFF}${Bf}██                  ${Bf}██${yf}████${Bf}████████${wf}${ON}██${OFF}${pf}████${Bf}██
${Bf}██${cf}██${ON}████████${OFF}${Bf}██${rf}${ON}██${wf}████${OFF}${cf}████${Bf}██${cf}████${Bf}██████                ${Bf}██${yf}${ON}██████${OFF}${Bf}████${rf}██████${Bf}██${rf}██${Bf}██                  ${Bf}██${bf}██${Bf}██${pf}██${yf}██████${pf}██${Bf}██${wf}${ON}██${OFF}${Bf}██
  ${Bf}██${cf}██${ON}██████${OFF}${Bf}██${rf}${ON}██${wf}██${cf}██${OFF}██${Bf}██${cf}████${Bf}██                    ${Bf}██${wf}${ON}██${OFF}${Bf}██${yf}${ON}██████${OFF}${rf}████████${Bf}████                      ${Bf}████████${pf}████${bf}██${Bf}██${wf}${ON}██${OFF}${Bf}██
    ${Bf}████${cf}████████████${Bf}██${cf}██████${Bf}██                      ${Bf}██████${yf}████${rf}██████${Bf}████                              ${Bf}██████${bf}██${Bf}████
        ${Bf}██████████████${wf}${ON}██${OFF}${cf}██${wf}${ON}██${OFF}${Bf}██                            ${Bf}██████${rf}██${Bf}████                                  ${Bf}██${bf}██████${Bf}██
                      ${Bf}██████                                ${Bf}██${wf}${ON}██${OFF}${rf}██${wf}${ON}██${OFF}${Bf}██                                    ${Bf}██████
                                                              ${Bf}██████                  
${reset}

EOF

}

case $1 in
    ""|ref*) reference ;;
    256*) 256colors; exit 0 ;;
    24*) 24bit; exit 0 ;;
    clrv*) colorvalues; exit 0 ;;
    inv*) invader; exit 0 ;;
    ansi*) ansi; exit 0 ;;
    blk*) blocks; exit 0 ;;
    fmt*) colorformatting; exit 0 ;;
    pac*) pacman; exit 0 ;;
    list*) list; exit 0 ;;
    all*) all; exit 0 ;;
    bar*) bars; exit 0 ;;
    fn*) fancy; exit 0 ;;
    tmux*) tmux_pallete; exit 0 ;;
    spectr*) spectrum; exit 0 ;; 
    ls*) ls_colors; exit 0 ;;
    ira*) ira; exit 0 ;;
    skull*) skulls; exit 0 ;;
    poke*) poke; exit 0 ;;
esac
