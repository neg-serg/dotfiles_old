#!/bin/sh
killall compton 
compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
