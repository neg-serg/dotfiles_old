#!/bin/zsh

nexec compton || sudo pkill compton
compton -b --config ${XDG_CONFIG_HOME}/compton/compton.conf &
