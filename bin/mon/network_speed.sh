#!/bin/zsh

# Taken from : http://www.adminsehow.com/2010/03/shell-script-to-show-network-speed/

# Global variables
interface=$1
received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""

Kb="K" Mb="M"

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
get_bytes() {
    line=$(cat /proc/net/dev \
        | grep ${interface} \
        | cut -d ':' -f 2 \
        | awk '{print "received_bytes="$1, "transmitted_bytes="$9}'\ 
    )
    eval ${line}
}


# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.
get_velocity() {
    value=$1   old_value=$2

    let vel=$[value-old_value]
    let velKB=$[vel/1024.]
    let velMB=$[vel/1024./1024.]

    if [[ ${velMB} > 1 ]]; then
        builtin printf "%.1f%s" "${velMB}" "${Mb}";
    elif [[ ${velKB} > 1 ]]; then
        builtin printf "%.1f%s" "${velKB}" "${Kb}";
    else
        builtin printf "%.1f%s" "${vel}" "B";
    fi
}

# Gets initial values.
get_bytes
old_received_bytes=${received_bytes}
old_transmitted_bytes=${transmitted_bytes}

# Main loop. It will repeat forever.
while true; do

    # Get new transmitted and received byte number values.
    get_bytes

    # Calculates speeds.
    vel_recv=$(get_velocity ${received_bytes} ${old_received_bytes})
    vel_trans=$(get_velocity ${transmitted_bytes} ${old_transmitted_bytes})

    # Shows results in the console.
    if false; then
        builtin printf "%b" "\e[2K"
        builtin printf "%b" "${interface} ${vel_recv}/${vel_trans}\r"
    else 
        builtin printf "%b" "net: ${vel_recv}/${vel_trans}\r"
        builtin printf "\n"
    fi

    # Update old values to perform new calculations.
    old_received_bytes=${received_bytes}
    old_transmitted_bytes=${transmitted_bytes}

    sleep $2
done
