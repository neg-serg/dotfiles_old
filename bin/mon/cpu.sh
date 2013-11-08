#!/bin/bash

previous_total=0
previous_stats=(0 0 0 0)

 while :
 do
current_total=0
    read -a current_stats < <(awk '/^cpu /{print $2" "$3" "$4" "$5}' /proc/stat)
    for n in ${current_stats[@]}; do ((current_total+=$n)); done
    sleep 2
    ((idle=${current_stats[3]}-${previous_stats[3]}))
    ((total=current_total-previous_total))
    ((cpu=100*(total-idle)/total))
    previous_stats=(${current_stats[@]})
    previous_total=$current_total
    echo "$cpu%"
done
