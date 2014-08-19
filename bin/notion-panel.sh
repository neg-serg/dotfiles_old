#!/bin/env bash

function statusbar {

    function desk() {
    # DESKTOP=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
    # case $DESKTOP in
    #     0)  echo "main"
    #         ;;
    #     1)  echo "www"
    #         ;;
    #     2)  echo "irc"
    #         ;;
    #     3)  echo "foo"
    #         ;;
    #     4)  echo "bar"
    #         ;;
    #     *)  echo "error"
    # esac
    DESKTOP=$(cat /tmp/example.txt)
    echo $DESKTOP
    }

    function clock() {
    time=$(date "+%e.%m %R")
    echo $time
    }

    function link() {
    AP=$(iwconfig wlp2s0 | grep "Quality" | awk '/Quality/ {print $2}' | sed 's/Quality//g;s/=//g;s/\///g;s/100//g')
    echo $AP
    }

    function mem() {
    free=$(free -m | grep Mem: | awk '{print $3}')
    echo $free
    }

    function temp() {
    tem=$(acpi -t | awk '{print $4}')
    echo $tem
    }

    # function sda() {
    # dfh=$(df -h | grep "/dev/sda1" | awk '{print $3}')
    # echo $dfh
    # }
    #
    function vol() {
    ami="$(amixer get Master | awk '/Front Left:/ {print $5}' | tr -d "[]")"
    echo $ami
    }
    
    function ncc() {
    mus=$(mpc current)
    echo $mus
    }
    
    echo "^fg(#8A2F58):bspwm = _"$(desk)"_ ^fg(#AAAAAA) (^fg(#287373) :gen^fg(#AAAAAA) ((^fg(#914E89):mem $(mem)M^fg(#98CBFE) ^fg(#AAAAAA))(^fg(#2B7694):link{$(link)%}^fg(#AAAAAA) (^fg(#5E468C)temp: $(temp)°C^fg(#AAAAAA) ))^fg(#E5B0FF)(load $(ncc)) (^fg(#395573) :sy^fg(#AAAAAA)(^fg(#CF4F88)^fg(AAAAAA) )^fg(#47959E)[setf *alsa*] :vol $(vol)^fg(#AAAAAA) ))(^fg(#FFFFFF)cons '$(clock)')^fg(#AAAAAA))"
}
FONT="-hell-monobook-bold-r-normal--16-160-72-72-m-80-iso10646-1"
 while true 
 do
     echo "$(statusbar)"
    sleep 0.5   
 done | dzen2 -dock -bg '#000000' -fn $FONT -tw 0 -x 0 -ta l -p &

