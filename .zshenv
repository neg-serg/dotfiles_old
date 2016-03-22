if [[ ! -h $(readlink -f ~/tmp) ]]; then
    rm ~/tmp && tmp_loc=$(mktemp -d) && ln -fs ${tmp_loc} ~/tmp
fi
