#!/bin/zsh
l1=`mpc|head -1`; l2=mpc|head -2;
l2=`$l2|perl -we 'undef $/; $x=<>;$x =~ /(\d+:\d.*)/;print $1;'`
Vol=`mpc volume|awk -F \:  '{print $2}'`
Vol=`echo $Vol|perl -pe 's/ //g'`
if [[ $(echo $(mpc|grep '\[paused\]')) == "" && $(echo $(mpc|wc -l)) > 1  &&  $(echo $(mpc|grep 'ERROR')) == "" ]];
then echo "[>>][ $l1 $l2 ][ Vol: $Vol ]";
else if [[ $(echo $(mpc|wc -l)) == 4 ]]; then echo "[>>][ $l1 $l2 ][ Vol: $Vol ]"; else echo "" ; fi; fi
