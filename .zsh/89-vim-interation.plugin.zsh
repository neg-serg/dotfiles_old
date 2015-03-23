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

function v {
    wid=$(xdotool search --classname wim)
    tmp_list=/tmp/vim_list
    if [ -z "$wid" ]; then
      urxvtc -fn 'xft:PragmataPro for Powerline:pixelsize=20,xft:dejavu sans mono:size=16:antialias=true' -fb "xft:PragmataPro for Powerline:style=bold:size=17" -name 'wim' -e bash -c 'tmux -S /home/neg/1st_level/vim.socket new "vim --servername VIM" && tmux -S /home/neg/1st_level/vim.socket switch-client -t vim' && \
      notionflux -e "app.byinstance('', 'URxvt', 'wim')"
      sleep .8s
      for i in $@; echo $i >> $tmp_list
      while read line; do
          file_name="$(resolve_file $line)"
          eval $(echo tmux -S ~/1st_level/vim.socket run \""$(echo vim --servername VIM --remote-silent \"${file_name}\")\"")
      done < $tmp_list
      rm $tmp_list
      file_name=
    else  
      notionflux -e "app.byinstance('', 'URxvt', 'wim')"
      sleep .5s
      for i in $@; echo $i >> $tmp_list
      while read line; do
          file_name="$(resolve_file $line)"
          eval $(echo tmux -S ~/1st_level/vim.socket run \""$(echo vim --servername VIM --remote-silent \"${file_name}\")\"")
      done < $tmp_list
      file_name=
      rm $tmp_list
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
