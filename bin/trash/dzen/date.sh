
#!/bin/bash
 
#Layout
WIDTH=162
HEIGHT=10
X_POS=1758
Y_POS=0
 
#Look and feel
 
 
DZEN_FG="#9d9d9d"
DZEN_FG2="#5f656b"
DZEN_BG="#050505"
 
FONT="-*-montecarlo-medium-r-normal-*-11-*-*-*-*-*-*-*"
 
 
printDate() {
        while true; do
                sleep 1
                echo "^fg()$(date '+%Y^fg(#444).^fg()%m^fg(#444).^fg()%d^fg(#007b8c)/^fg(#5f656b)%a ^fg(#a488d9)| ^fg()%H^fg(#444):^fg()%M^fg(#444):^fg()%S')"         
    done
    }
    printDate | dzen2  -dock -x $X_POS -y $Y_POS -w $WIDTH -h $HEIGHT -fn $FONT -ta 'r' -bg $DZEN_BG -fg $DZEN_FG -p -e ''
     

