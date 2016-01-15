#!/bin/zsh

python_path="$(which python)"

if [[ $(basename $(readlink /usr/sbin/python)) == python3 ]]; then
    echo ':: set python (3 to 2) ::'
    sudo ln -fs /usr/sbin/python2 /usr/sbin/python && \
        l ${python_path}
elif
    [[ $(basename $(readlink /usr/sbin/python)) == python2 ]]; then
    echo ':: set python (2 to 3) ::'
    sudo ln -fs /usr/sbin/python3 /usr/sbin/python && \
        l ${python_path}
fi
