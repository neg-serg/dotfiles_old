alias wine="WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine"
alias steamwine='WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe' 
function bnet(){
    local prefix_=""
    if [[ $1 =~ ".*32" ]]; then
        prefix_="setarch i386 -3 "
        _zwrap "set to 32 bit"
    fi
    local dir_=~/.wine/drive_c/Program\ Files\ \(x86\)/
    cd "${dir_}/Battle.net"
    eval WINEDEBUG=-all LC_ALL=ru_RU.utf8 LC_COLLATE=C LC_MESSAGES=C \
    ${prefix_} wine ./Battle.net.exe &
}
alias crossover="LANG=ru_RU.utf8 setarch i386 -3 /mnt/home/crossover/bin/crossover"


function sls(){
    steamcmd '+apps_installed +quit' |\
        awk '/AppID/ {
                id = $2;
                name = substr($0, index($0, " : ") + 3);
                sub(" : .*", "", name);
                print id ": " name;
            }'
}
