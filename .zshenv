if [[ ! -f $(readlink -f ~/tmp) ]]; then
    tmp_loc=$(mktemp -d) && ln -fs ${tmp_loc} ~/tmp
fi

source ~/.zsh/01-init.zsh
source ~/.zsh/03-exports.zsh
