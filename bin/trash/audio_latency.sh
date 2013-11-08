#!/bin/bash
sleep 25 ; sudo chrt -f -p 81 $(pidof mpd)        #Changes MPD to Real-Time priority
sleep 35 ; taskset -c -p 1 $(pidof mpd)              #Changes MPD to it's 'own' cpu core
sleep 45 ; sudo killall lxdm-binary                     #This kills the desktop environment for lubuntu-linux
sudo chrt -f -p 99 5
sudo chrt -f -p 99 11
sudo chrt -f -p 99 9
sudo chrt -f -p 99 19
sudo chrt -f -p 99 25
sudo chrt -f -p 99 23
sudo chrt -f -p 99 36
sudo chrt -f -p 99 32
sudo chrt -f -p 99 38
sudo chrt -f -p 99 45
sudo chrt -f -p 99 49
sudo chrt -f -p 99 51
sudo chrt -f -p 99 719
modprobe snd-usb-audio nrpacks=1                #reduce USB latency
modprobe -r ppdev
modprobe -r uvcvideo                                          #kill video support
modprobe -r ath9k                                                #kill wireless wi-fi
modprobe -r videodev
modprobe -r lp                                                      #no printer service needed
/etc/init.d/ondemand stop &
/etc/init.d/cups stop &
sudo killall modem-manager                                #kill modem support
sudo killall -9 irqbalance
sudo killall -9 bluetooth
sudo /etc/init.d/cron stop
