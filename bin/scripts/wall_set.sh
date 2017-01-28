#!/bin/bash

shopt -s nullglob
cd /home/neg/pic/wl

files=()
for i in *.{jpg,png}; do
    [[ -f $i ]] && files+=("$i")
done
range=${#files[@]}
((range)) && hsetroot -fill "${files[RANDOM % range]}"
