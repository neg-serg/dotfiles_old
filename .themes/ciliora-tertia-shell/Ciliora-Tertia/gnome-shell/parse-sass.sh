#!/usr/bin/bash

SRC="./sass/gnome-shell.scss"
COMPILE="gnome-shell.css"

bundle exec sass --watch $SRC:$COMPILE --sourcemap=none --no-cache --style expanded
