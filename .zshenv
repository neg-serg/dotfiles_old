if [[ ! -L ~/tmp ]]; then
    rm -f ~/tmp && tmp_loc=$(mktemp -d) && ln -fs ${tmp_loc} ~/tmp
fi
