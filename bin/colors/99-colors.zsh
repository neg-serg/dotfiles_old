function spectrum_ls() {
    # A script to make using 256 colors in zsh less painful.
    # Copied from http://github.com/sykora/etc/blob/master/zsh/functions/spectrum/

    typeset -Ag FX FG BG

    FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
    )

    for color in {000..255}; do
        FG[$color]="%{[38;5;${color}m%}"
        BG[$color]="%{[48;5;${color}m%}"
    done

    # Show all 256 colors with color number
    for code in {000..255}; print -P -- "$code: %F{$code}Test%f"
}

function getlscolors(){
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

