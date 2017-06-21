#!/bin/zsh

# Original taken from : http://www.adminsehow.com/2010/03/shell-script-to-show-network-speed/
function interface_autodetect(){
    if [[ $(pgrep NetworkManager) > /dev/null ]]; then
        host_dev="$(nmcli|awk -F ':' '/connected to/{print $1}')"
        builtin printf "%s\n" "${host_dev}"
    else
        local host="google.com"
        local default_net_="enp7s0"

        local host_ip=$(getent ahosts ${host} | head -1 | awk '{print $1}')
        local active_net_interface=$(ip link show up | \
            awk -F \: '/state UP/ {print $2}')

        if [[ "${host_ip}" != "" ]]; then
            local host_dev=$(ip route get "${host_ip}" | \
                grep -Po '(?<=(dev )).*(?= src)'|tr -d '[:space:]')
        fi

        if [[ "${host_dev}" != "" && "${host_dev}" ]]; then
            builtin printf "%s\n" "${host_dev}"
        else
            builtin printf "%s\n" "${default_net_}"
        fi
    fi
}

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
function get_bytes() {
    line=$(cat /proc/net/dev \
        | grep "${interface}" \
        | cut -d ':' -f 2 \
        | awk '{print "received_bytes="$1, "transmitted_bytes="$9}'\
    )
    eval "${line}"
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.
function get_velocity() {
    local Kb="K" Mb="M"
    local value=$1
    local old_value=$2
    local use_bytes_=false
    local use_mb_=false

    let vel=$[value-old_value]
    let velKB=$[vel/1024.]
    let velMB=$[vel/1024./1024.]

    if [[ ${velMB} > 1 && ${use_mb_} == true ]]; then
        builtin printf "%.1f%s" "${velMB}" "${Mb}";
    elif [[ ${velKB} > 1 ]]; then
        builtin printf "%.1f%s" "${velKB}" "${Kb}";
    elif [[ ${use_bytes_} == true ]]; then
        builtin printf "%.1f%s" "${vel}" "B";
    else 
        builtin printf "%.1f%s" "${velKB}" "${Kb}";
    fi

}

if [[ $# == 0 ]]; then
    interface=$(interface_autodetect)
    if [[ -e "${interface}" ]]; then
        echo "net: oOps :("
        sleep 1m; exit 0
    fi
else
    interface=$1
fi

received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""

# Gets initial values.
get_bytes
old_received_bytes="${received_bytes}"
old_transmitted_bytes="${transmitted_bytes}"

counter=0
first_blood=true

local delim="/"
local lhs_q="["
local rhs_q="]"

function hi_color(){
    if [[ -x $(which xrq) ]]; then
        hi_color_="$(xrq color2)"
    else
        hi_color_="#287373"
    fi
    echo "${hi_color_}"
}

function wrap_polybar(){
    builtin print "%{F$(hi_color)}$1%{F#fff}"
}

if [[ "${USE_POLYBAR}" == 1 ]]; then
    delim=$(wrap_polybar "${delim}")
    lhs_q=$(wrap_polybar "${lhs_q}")
    rhs_q=$(wrap_polybar "${rhs_q}")
fi

# Main loop. It will repeat forever.
while true; do
    local use_terminal_=false
    local timeout_=60
    local interface_timeout_=7

    # Get new transmitted and received byte number values.
    get_bytes

    # Calculates speeds.
    vel_recv=$(get_velocity "${received_bytes}" "${old_received_bytes}")
    vel_trans=$(get_velocity "${transmitted_bytes}" "${old_transmitted_bytes}")

    # Shows results in the console.
    if [[ ${use_terminal_} == true ]]; then
        builtin printf "%b" "\e[2K"
        builtin printf "%b" "${interface} ${vel_recv}${delim}${vel_trans}\r"
    else
        if [[ ${counter} < "${interface_timeout_}" && ${first_blood} == true ]]; then
            builtin printf "%b" "net: ${lhs_q}${interface}${rhs_q} ${vel_recv}${delim}${vel_trans}\r"
        else
            builtin printf "%b" "net: ${vel_recv}${delim}${vel_trans}\r"
            first_blood=false
        fi
        builtin printf "\n"
    fi

    # Update old values to perform new calculations.
    old_received_bytes="${received_bytes}"
    old_transmitted_bytes="${transmitted_bytes}"

    if [[ $# < 2 ]]; then
        sleep 1s
    else
        sleep "$2"
    fi
    let counter=counter+1
    if [[ ${counter} == ${timeout_} ]]; then
        interface=$(interface_autodetect)
        if [[ -e "${interface}" ]]; then
            echo "net: oOps :("
            sleep 1m; exit 0
        fi
    fi
done
