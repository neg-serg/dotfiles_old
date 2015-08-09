fe() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && xdg-open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fh - repeat history
fh() {
  zle -I;
  echo $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  zle -I
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}


# fco - checkout git commit
fco() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser (enter for show, ctrl-d for diff, backtick ` toggles sort)
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-o,ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = 'ctrl-d' ]; then
      git diff --color=always $shas | vimpager
    elif [ "$k" = 'ctrl-o' ]; then
      git checkout $shas 
    else
      for sha in $shas; do
        git show --color=always $sha | vimpager
      done
    fi
  done
}

# ftpane - switch pane
ftpane () {
  local panes current_window target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_window=$(tmux display-message  -p '#I')

  target=$(echo "$panes" | fzf) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

function pl(){
    if [[ -e "$@" ]]; then
        find_result="`find "$@"|~/.zsh/fzf-tmux -d 30% -- --color=16`"
    else
        find_result="`find "${HOME}/vid/"|~/.zsh/fzf-tmux -d 30% -- --color=16`"
    fi
    echo ${find_result}|xsel
    if [ ! -z ${find_result} ]; then
        local prefix="$fg[blue][$fg[white]>>$fg[blue]]"
        local msg_delim="[38;5;24m::${fg[white]}"

        local vid_comment="$(exiftool -t -S -Comment ${find_result})"
        local file_size="$(exiftool -t -S -FileSize ${find_result})"
        local mime_type="$(exiftool -t -S -MIMEType ${find_result})"
        local doc_type="$(exiftool -t -S -DocType ${find_result})"
        local muxing_app="$(exiftool -t -S -MuxingApp ${find_result})"
        local wrighting_app="$(exiftool -t -S -WrightingApp ${find_result})"
        local duration="$(exiftool -t -S -Duration ${find_result})"
        local date_time="$(exiftool -t -S -DateTimeOriginal ${find_result})"
        local img_width="$(exiftool -t -S -ImageWidth ${find_result})"
        local img_height="$(exiftool -t -S -ImageHeight ${find_result})"

        local tmp_name="$(echo ${find_result}|sed "s|^${HOME}|$fg[green]~|;s|/|$fg[blue]&$fg[white]|g")"
        local decoration="$fg[green]‒$fg[white]"
        local fancy_name="${decoration} ${tmp_name} ${decoration}"

        if [[ ! $(echo ${vid_comment}|tr -d '[:blank:]') == "" ]]; then
            local comment_str="${fg[blue]}[${fg[white]} Comment ${msg_delim} $vid_comment ${fg[blue]}]${fg[white]}"
        else
            local comment_str=""
        fi
        local img_size_str="${fg[blue]}[${fg[white]} Size ${msg_delim} ${img_width} x ${img_height} ${fg[blue]}]"
        local duration_str="${fg[blue]}[${fg[white]} Duration ${msg_delim} ${duration} ${fg[blue]}]"
        if [[ ! $(echo ${created_str}|tr -d '[:blank:]') == "" ]]; then
            local created_str="${fg[blue]}[${fg[white]} Created ${msg_delim} ${date_time} ${fg[blue]}]"
        else
            local created_str=""
        fi
        echo -e "${prefix} ${fancy_name}\n${img_size_str}\n${duration_str}\n${created_str}\n${comment_str}"
        mpv "${find_result}"
    fi
}


zle -N fe 
bindkey "^Xe" fe

zle -N fh 
bindkey "^Xh" fh

zle -N fkill 
bindkey "^Xq" fkill
