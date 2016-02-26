function _zwrap() { echo "$fg[blue][$fg[white]$1$fg[blue]]$fg[default]" }

function _zfwrap(){
    apply=$1;
    body=$2;
    shift
    echo $(apply) ${body} $(apply)
}

function _zgwrap(){
    side=$1;
    body=$2;
    shift
    echo ${side} ${body} ${side}
}

function _zfwrap() {
    local tmp_name="$(echo $1|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
    local decoration="$fg[green]‒$fg[white]"
    local fancy_name="${decoration} $fg[white]${tmp_name} ${decoration}"
    echo ${fancy_name}
}

function _zpref() { echo $(_zwrap ">>") }
function _zfg(){ echo -ne "[38;5;$1m" }
function _zdelim(){ echo -ne "$(_zfg 24)::"$(_zfg 8) }

