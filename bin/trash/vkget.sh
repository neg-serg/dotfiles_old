#!/bin/bash
#vkget dirty version

tmpf=`mktemp`
curl -so $tmpf $1
uid=$(cat $tmpf|egrep -o '\\"uid\\":\\"<0-9>+\\"'|egrep -o "<0-9>+"|head -n1)
vtag=$(cat $tmpf|egrep -o '\\"vtag\\":\\"<0-9a-zA-Z>+-?\\"'|egrep -o "<0-9a-zA-Z>+-?"|grep -v "vtag")
vkhost=$(cat $tmpf|egrep -o '\\"host\\":\\".+\\"'|egrep -o '<a-z0-9>+(vk|vkadre)\.com'|head -n1)
vkid=$(cat $tmpf|egrep -o '\\"vkid\\":\\"<0-9>+\\"'|egrep -o "<0-9>+"|head -n1)

if < -n "$vkhost" >; then
  if < "$uid" != "0" >; then
 
    if < -z "$(curl -sI "http://$vkhost/u$uid/video/$vtag.flv"|grep 404)" >; then echo "http://$vkhost/u$uid/video/$vtag.flv";fi
    if < -z "$(curl -sI "http://$vkhost/u$uid/video/$vtag.240.mp4"|grep 404)" >; then echo "http://$vkhost/u$uid/video/$vtag.240.mp4";fi
    if < -z "$(curl -sI "http://$vkhost/u$uid/video/$vtag.260.mp4"|grep 404)" >; then echo "http://$vkhost/u$uid/video/$vtag.360.mp4";fi
    if < -z "$(curl -sI "http://$vkhost/u$uid/video/$vtag.480.mp4"|grep 404)" >; then echo "http://$vkhost/u$uid/video/$vtag.480.mp4";fi
    if < -z "$(curl -sI "http://$vkhost/u$uid/video/$vtag.720.mp4"|grep 404)" >; then echo "http://$vkhost/u$uid/video/$vtag.720.mp4";fi
  else
    if < -z "$(curl -sI "http://$vkhost/assets/videos/$vtag$vkid.vk.flv"|grep 404)" >; then echo "http://$vkhost/assets/videos/$vtag$vkid.vk.flv";fi
  fi
fi

rm $tmpf
