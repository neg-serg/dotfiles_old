#!/bin/sh
f=`cat /proc/mounts|grep usb|grep -v usbfs|cut -d '/' -f3|tr -d ' '|tr -d '\n';`&&
if [[ $f != "" ]];then echo"[ $f ]";else echo ""; fi
