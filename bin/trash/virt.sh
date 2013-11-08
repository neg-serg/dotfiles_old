#!/bin/zsh
sudo zsh -c 'for m in vbox{drv,netadp,netflt}; do modprobe $m; done' && VirtualBox
#sudo zsh -c 'for m in vbox{drv,netadp,netflt}; do modprobe $m; done' && VirtualBox -startvm "hzhz"
VirtualBox &
