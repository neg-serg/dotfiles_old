#!/bin/sh
if [[ $1 == "twice" ]]; then
    killall compton && compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
else
    if [[ $(pidof compton) ]]; then
        killall compton 
    else
        compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
    fi
fi
