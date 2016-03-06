if [[ ! -f $(readlink -f ~/tmp) ]]; then
    tmp_loc=$(mktemp -d) && ln -fs ${tmp_loc} ~/tmp
fi
