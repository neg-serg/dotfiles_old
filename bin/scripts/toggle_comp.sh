#!/bin/sh
if [[ $(pidof compton) ]]; then
    killall compton 
else
    compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
fi
