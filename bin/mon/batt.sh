#!/bin/sh
echo "[ batt: `acpi|awk '{print $4}'|tr -d ","` ]" 
