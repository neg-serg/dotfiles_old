#!/bin/bash
#vbetool vbestate restore 
echo 0 > /sys/class/vtconsole/vtcon1/bind
rmmod nouveau 
sleep 1
#/etc/init.d/consolefont restart 
rmmod ttm 
rmmod drm_kms_helper 
rmmod drm 
modprobe nvidia 
su neg -c startx
