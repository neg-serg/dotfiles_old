#!/bin/sh
if [[ $1 == "twice" ]]; then
    killall compton && compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf 2> /dev/null&
else
    if [[ $(pidof compton) ]]; then
        killall compton 
    else
        compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf 2> /dev/null &
    fi
fi
