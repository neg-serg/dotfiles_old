local games_dir_="$(readlink -f ${HOME}/games)"
local wine_pref_="${HOME}/.wine"
IFS= local wine_progs_="$(echo ${wine_pref_}'/drive_c/Program Files (x86)')"

alias wine="WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
alias crossover="LANG=ru_RU.utf8 setarch i386 -3 /mnt/home/crossover/bin/crossover"
alias q3="$(echo -e ${games_dir_}/q3/qq/ioquake3)"

function steam_wine(){
    cd "${wine_progs_}/Steam"
    WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine Steam.exe
}

function sls(){
    steamcmd '+apps_installed +quit' |\
        awk '/AppID/ {
                id = $2;
                name = substr($0, index($0, " : ") + 3);
                sub(" : .*", "", name);
                print id ": " name;
            }'
}

function bnet(){
    local prefix_=""
    if [[ $1 =~ ".*32" ]]; then
        prefix_="setarch i386 -3 "
        _zwrap "set to 32 bit"
    fi
    cd "${wine_progs_}/Battle.net"
    eval WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C \
    ${prefix_} wine ./Battle.net.exe &
}

function doom(){
    cd "${wine_progs_}/Steam/steamapps/common/DOOM/"
    local doom_path="DOOMx64vk.exe"
    wine ${doom_path}
}
