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
    if [ -z "$wid" ]; then
      urxvtc -fn 'xft:PragmataPro for Powerline:pixelsize=20,xft:dejavu sans mono:size=16:antialias=true' -name 'wim' -e bash -c 'tmux -S /home/neg/1st_level/vim.socket new "vim --servername VIM" && tmux -S /home/neg/1st_level/vim.socket switch-client -t vim' && \
      notionflux -e "app.byinstance('', 'URxvt', 'wim')" > /dev/null
      # file_name=\'`readlink -f "$@"`\'
      # echo vim --servername VIM --remote-silent "$file_name" > /tmp/tmux_run
      sleep .8s
      for i in $@; echo $i >> /tmp/file
      while read line; do
          file_name="$(resolve_file $line)"
          eval $(echo tmux -S ~/1st_level/vim.socket run \"$(echo vim --servername VIM --remote-silent \"${file_name}\")\")
      done < /tmp/file
      # tmux -S ~/1st_level/vim.socket run "`cat /tmp/tmux_run`"
      rm /tmp/file
      filename=
    else  
      notionflux -e "app.byinstance('', 'URxvt', 'wim')" > /dev/null
      # file_name=\'`readlink -f "$@"`\'
      # echo vim --servername VIM --remote-silent "$file_name" > /tmp/tmux_run
      sleep .5s
      for i in $@; echo $i >> /tmp/file
      while read line; do
          file_name="$(resolve_file $line)"
          eval $(echo tmux -S ~/1st_level/vim.socket run \"$(echo vim --servername VIM --remote-silent \"${file_name}\")\")
      done < /tmp/file
      # tmux -S ~/1st_level/vim.socket run "`cat /tmp/tmux_run`"
      filename=
      rm /tmp/file
    fi
}



# alias vi=callvim
# alias vvsp="callvim -b':vsp'"
# alias vhsp="callvim -b':sp'"
# alias vk="callvim -b':wincmd k'"
# alias vj="callvim -b':wincmd j'"
# alias vl="callvim -b':wincmd l'"
# alias vh="callvim -b':wincmd h'"
# alias vK="callvim -b':sp<cr>:wincmd k'"
# alias vJ="callvim -b':sp<cr>:wincmd j'"
# alias vH="callvim -b':vsp<cr>:wincmd h'"
# alias vL="callvim -b':vsp<cr>:wincmd l'"
