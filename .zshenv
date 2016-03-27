[[ $(readlink -e ~/tmp) == "" ]] && rm -f ~/tmp
[[ ! -L ~/tmp ]] && { rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs ${tmp_loc} ~/tmp }
