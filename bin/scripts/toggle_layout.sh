#!/usr/bin/env bash
if [ $(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | cut -d"+" -f2) = ru ]; then
        setxkbmap us;
else
        setxkbmap ru;
fi
