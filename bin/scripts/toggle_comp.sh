#!/bin/dash
if [ $1 -eq "twice" ]; then
    killall compton && compton -b --config $XDG_CONFIG_HOME/compton/compton.conf 2> /dev/null&
else
    if pidof compton > /dev/null; then
        killall compton 
    else
        compton -b --config $XDG_CONFIG_HOME/compton/compton.conf 2> /dev/null &
    fi
fi
