#/bin/bash

FG='#dcdcdc'
BG='#333333'
fg_title="#abd4e2"

font1="Inconsolata:size=11"
font_title="Inconsolata:bold:size=11"
icons="Typicons:size=15"
icons2="FontAwesome:size=13"
icons3="Ionicons:size=13"

 #A simple popup showing system information

 HOST=$(uname -n)
 KERNEL=$(uname -r)
 uptime=$(uptime | awk '{print $3}')
 charCount=$(echo ${#uptime})

 if [[ "$charCount" = "3" ]]
 	then
 	uptime=$(uptime | awk '{print $3}' | sed 's/,/m/')
 elif [[ "$charCount" = "1" ]] || [[ "$charCount" = "2" ]]
 	then
 	uptime=$(uptime | awk '{print $3}' | sed 's/$/m/')
 else
 	uptime=$(uptime | awk '{print $3}' | sed 's/:/h /' | sed 's/,/m/')
 fi


 #UPTIME=$(uptime | sed 's/.* up //' | sed 's/[0-9]* us.*//' | sed 's/ day, /d /'\
  #        | sed 's/ days, /d /' | sed 's/:/h /' | sed 's/ min//'\
   #         |  sed 's/,/m/' | sed 's/  / /')
 PACKAGES=$(pacman -Q | wc -l)

 ram_used=$(free -m | grep Mem | awk '{print $3" MB"}')
 ram_total=$(free -m | grep Mem | awk '{print $2" MB"}')
 cpu_user=$(mpstat | grep all | awk '{print $4"%"}')
 cpu_sys=$(mpstat | grep all | awk '{print $6"%"}')
 cpu_idle=$(mpstat | grep all | awk '{print $13"%"}')
 temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)
 let "cpu_temp=$temp/1000"
 hdd_temp=$(hddtemp -n /dev/sda)
 

(
 echo "
 ^fg($fg_title)^fn($font_title)^p(+55)System Information^p()^fg()" # Fist line goes to title
 # The following lines go to slave window
 echo "   ^fg(#666666)-----------------------------"
 echo "   ^fn($icons2)^fn($font1) $HOST "
 echo "   ^fn($icons2)^fn($font1) $uptime"
 echo "   ^fn($icons3)P^fn() $PACKAGES packages"
 echo "   ^fg(#666666)-----------------------------"
 echo "   ^fn($font_title)^fg($fg_title)^bg(#222222) CPU "
 echo "   User utilization: $cpu_user"
 echo "   System utilization: $cpu_sys"
 echo "   Idle: $cpu_idle"
 echo "   ^fn($icons)^fn($font1) $cpu_temp°C/90°C"
 echo ""
 echo "   ^fn($font_title)^fg($fg_title)^bg(#222222) RAM "
 echo "   Used: $ram_used / $ram_total"
 echo ""
 echo "   ^fn($font_title)^fg($fg_title)^bg(#222222) HDD "
 echo "   ^fn($icons)^fn($font1) $hdd_temp°C/55°C
 "
 echo ""

) | dzen2 -p -x 213 -y 28 -w 250 -bg $BG -fg $FG -l 19 -sa l -ta c -e 'onstart=uncollapse;button1=exit;button3=exit' -fn $font1

 # "onstart=uncollapse" ensures that slave window is visible from start.