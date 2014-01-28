function retval() {
    if [[ -z $1 ]];then
        echo '.'
    else
        echo $1
    fi
}

alias psmem='ps -e -orss=,args= | sort -b -k1,1n'
alias psmem10='ps -e -orss=,args= | sort -b -k1,1n| head -10'
# get top process eating cpu if not work try excute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args|sort -k1 -nr | head -10'
# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Sort connection state
sortcons() { netstat -nat |awk '{print $6}'|sort|uniq -c|sort -rn } 
# View all 80 Port Connections
con80() { netstat -nat|grep -i ":80"|wc -l } 
# On the connected IP sorted by the number of connections
sortconip() { netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n }
# top20 of Find the number of requests on 80 port
req20() { netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20 }
# top20 of Using tcpdump port 80 access to view
http20() { sudo tcpdump -i eth0 -tnn dst port 80 -c 1000 | awk -F"." '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr |head -20 }
# top20 of Find time_wait connection
timewait20() { netstat -n|grep TIME_WAIT|awk '{print $5}'|sort|uniq -c|sort -rn|head -n20 }
# top20 of Find SYN connection
syn20() { netstat -an | grep SYN | awk '{print $5}' | awk -F: '{print $1}' | sort | uniq -c | sort -nr|head -n20 }
# Printing process according to the port number
port_pro() { netstat -ntlp | grep "$(retval $1)" | awk '{print $7}' | cut -d/ -f1 } 
# top10 of gain access to the ip address
accessip10() { awk '{counts[$(11)]+=1}; END {for(url in counts) print counts[url], url}' "$(retlog)" }
# top100 of Page lists the most time-consuming (more than 60 seconds) as well as the corresponding page number of occurrences
# Website traffic statistics (G)
webtraffic() { awk "{sum+=$10} END {print sum/1024/1024/1024}" "$(retlog)" }
# Statistical connections 404
c404() { awk '($9 ~/404/)' "$(retlog)" | awk '{print $9,$7}' | sort }
# Statistical http status.
httpstatus() { awk '{counts[$(9)]+=1}; END {for(code in counts) print code, counts[code]}' "$(retlog)" }
# gather external ip address
geteip() { curl http://ifconfig.me }
# determine local IP address
getip() { ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' }
# Clear zombie processes
clrz() { ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9 }
# Second concurrent
conssec() { awk '{if($9~/200|30|404/)COUNT[$4]++}END{for( a in COUNT) print a,COUNT[a]}' "$(retlog)"|sort -k 2 -nr|head -n10 }
