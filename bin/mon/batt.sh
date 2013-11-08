#!/bin/sh
a=`grep charged /proc/acpi/battery/BAT0/state`
if [[ $a == "" ]]; then echo "[ batt: `acpi|awk '{print $4}'|tr -d ","` ]" ;else echo "";fi
