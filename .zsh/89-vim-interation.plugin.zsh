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
    local file_size=$(stat -c%s "$file_name" 2>/dev/null| numfmt --to=iec-i --suffix=B)
    local file_length="`wc -l $file_name 2>/dev/null|grep -owE '[0-9]* '|tr -d ' '`"
    file_name=$(bash -c "printf %q '$file_name'")
    if [ -f "$file_name" ]; then
        echo "$fg[blue][$fg[white]>>$fg[blue]] -> $fg[white]$file_name :: [sz = $file_size] :: [len = $file_length]"
    else
        echo "$fg[blue][$fg[white]>>$fg[blue]] -> $fg[white]$file_name :: [ new_file ]"
    fi
    eval $(echo tmux -S ~/1st_level/vim.socket run \'"$(echo vim --servername VIM --remote-silent "${file_name}")"\')
    file_name=
    sleep .17s
}

function process_list() {
    notionflux -e "app.byclass('', 'wim')" > /dev/null
    sleep "$1"; shift
    for i in $@; echo $i >> $tmp_list
    while read line; do
        vim_file_open
    done < $tmp_list
    rm $tmp_list
}

function v {
    wid=$(xdotool search --classname wim)
    local wim_font="PragmataPro for Powerline"
    # wim_font_s="Mensch:size=14"
    tmp_list=/tmp/vim_list
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
