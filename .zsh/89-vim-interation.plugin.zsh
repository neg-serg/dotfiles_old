function resolve_file {
  if [ -f "$1" ]; then
    echo $(readlink -f "$1")
  elif [[ "${1#/}" == "$1" ]]; then
    echo "$(pwd)/$1"
  else
    echo $1
  fi
}

function callvim {
  if [[ $# == 0 ]]; then
    cat <<EOH
usage: callvim [-b cmd] [-a cmd] [file ... fileN]

  -b cmd     Run this command in GVIM before editing the first file
  -a cmd     Run this command in GVIM after editing the first file
  file       The file to edit
  ... fileN  The other files to add to the argslist
EOH
    return 0
  fi

  local cmd=""
  local toNormal="<c-\\><c-n>"
  local before=""
  local after=""
  while getopts ":b:a:" option
  do
    case $option in
      a) after="$OPTARG"
         ;;
      b) before="$before$OPTARG"
         ;;
    esac
  done
  shift $((OPTIND-1))
  if [[ ${after#:} != $after && ${after%<cr>} == $after ]]; then
    after="$after<cr>"
  fi
  if [[ ${before#:} != $before && ${before%<cr>} == $before ]]; then
    before="$before<cr>"
  fi
  local files=""
  for f in $@
  do
    files="$files $(resolveFile $f)"
  done
  if [[ -n $files ]]; then
    files=':args! '"$files<cr>"
  fi
  cmd="$toNormal$before$files$after"
  vim --servername VIM --remote-send "$cmd"
  if typeset -f postCallVim > /dev/null; then
    postCallVim
  fi
}

function vim_file_open() {
    local file_name="$(resolve_file $line)"
    file_name=$(bash -c "printf %q '$file_name'")

    eval $(echo tmux -S ~/1st_level/vim.socket run \'"$(echo vim --servername VIM --remote-silent "${file_name}")"\')
    
    local FG237="[38;5;237m"
    local file_size=$(stat -c%s "$file_name" 2>/dev/null| numfmt --to=iec-i --suffix=B|sed "s/\([KMGT]iB\|B\)/$fg[green]&/")
    local file_length="`wc -l $file_name 2>/dev/null|grep -owE '[0-9]* '|tr -d ' '`"
    local sz_msg="$fg[blue][$fg[white]sz ${FG237}~$fg[white] $file_size$fg[blue]]"
    local len_msg="$fg[blue][$fg[white]len ${FG237}=$fg[white] $file_length$fg[blue]]"
    local new_file_msg="$fg[blue][$fg[white] new_file $fg[blue]]"
    local dir_msg="$fg[blue][$fg[white] directory $fg[blue]]"
    local msg_delim="[38;5;24m::"
    local prefix="$fg[blue][$fg[white]>>$fg[blue]]"
    local decoration="$fg[green]‒$fg[white]"
    local tmp_name="$(echo ${file_name}|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
    local fancy_name="${decoration} $fg[white]${tmp_name} ${decoration}"
    if [ -f "${file_name}" ] && [ ! -d "${file_name}" ]; then
        local current_syntax=$(vim --servername "VIM" --remote-expr "b:current_syntax" 2>/dev/null)
        if [[ ! $(echo ${current_syntax}|tr -d '[:blank:]') == "" ]]; then
            local syn_msg=" ${msg_delim} $fg[blue][$fg[white] ft ${FG237}=$fg[white] ${current_syntax} $fg[blue]]$fg[white]"
        else
            syn_msg=""
        fi
        echo "${prefix} ${fancy_name} ${msg_delim} ${sz_msg} ${msg_delim} ${len_msg}${syn_msg}"
    else
        if [ ! -d "${file_name}"  ]; then
            echo "${prefix} ${fancy_name} ${msg_delim} ${new_file_msg}"
        else
            echo "${prefix} ${fancy_name} ${msg_delim} ${dir_msg}"
        fi
    fi

    file_name=
}

function process_list() {
    notionflux -e "app.byclass('', 'wim')" > /dev/null
    sleep "$1"; shift
    for line; do vim_file_open; done
}

function v {
    wid=$(xdotool search --classname wim)
    local wim_font="PragmataPro for Powerline"
    # wim_font_s="Mensch:size=14"
    if [ -z "$wid" ]; then
       st -f "${wim_font}:pixelsize=20" -c 'wim' -e bash -c 'tmux -S ${HOME}/1st_level/vim.socket new "vim --servername VIM" && tmux -S ${HOME}/1st_level/vim.socket switch-client -t vim' & 
      process_list ".8s" "$@"
    else  
      process_list ".5s" "$@"
    fi
}

# { callvim -b':vsp' }
# { callvim -b':sp' }
# { callvim -b':wincmd k' }
# { callvim -b':wincmd j' }
# { callvim -b':wincmd l' }
# { callvim -b':wincmd h' }
# { callvim -b':sp<cr>:wincmd k' }
# { callvim -b':sp<cr>:wincmd j' }
# { callvim -b':vsp<cr>:wincmd h' }
# { callvim -b':vsp<cr>:wincmd l' }
