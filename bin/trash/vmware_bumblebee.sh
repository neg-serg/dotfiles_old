
#!/bin/bash

# Copyright 2012 Robert Auch
# Licensed under GPLv3
# v1.1 - added "gksu / sudo" autodetection for ease-of-use

#ACADAPTER="/proc/acpi/ac_adapter/AC/state"
#BATTERY="/proc/acpi/battery/BAT0"

# The default 3D method - autodetection, forced off, or forced on:
FORCE3D="a"  #a for auto, n for no, y for yes

#This is how we'll track what we decide to do. Default safe for power.
#The script will change this value based on logic below. Change to "y" to default on for speed
DO3D="n"

echo $1 | egrep -q -w '(help|h|\?)'
if [ $? -eq 0 ]; then
    echo "Choose whether to run VMware Workstation via primusrun/optirun or not, based on laptop power state"
    echo "  (plugged in or not)"
    echo "Options are slim:"
    echo ""
    echo "    -?|-h|--help        -- this help text"
    echo "    -f|-y|--yes|--force -- force using optirun/primusrun"
    echo "    -n|--no             -- force NOT using optirun/primusrun"
    echo "    -i|--install        -- install these scripts"
    echo ""
    echo "If no options are passed, auto-detection is used.  Autodetection simply attempts to figure out if"
    echo "your AC adapter is plugged in or not."
    echo ""
    exit 1
fi

if [ -x `which gksudo` ]; then
    SUDO="`which gksudo` -k"
elif [ -x `which gksu` ]; then
    SUDO="`which gksu` -S -k"
elif [ -x `which kdesudo` ]; then
    echo "WARNING: kdesudo doesn't support a '--preserve-environment' flag, install gksu. Using 'sudo -E'"
    SUDO="sudo -E"
else
    SUDO="sudo -E"
fi

installvmx_script() {
    if [ -x /usr/lib/vmware/bin/vmware-vmx ]; then
        filetype=`file /usr/lib/vmware/bin/vmware-vmx`
        echo ${filetype} | grep -q "setuid ELF"
        if [ $? -ne 0 ]; then
            echo "ERROR: vmware-vmx is not an ELF binary!"
            echo "${filetype}"
            echo "ERROR: Refusing to continue!"
            exit 16
        fi
    else
        echo "ERROR: vmware-vmx is not executable!"
        echo "Don't know how to continue!"
        exit 16
    fi

    if [ -f /usr/lib/vmware/bin/vmware-vmx.real ]; then
        echo "WARNING: there's already a vmware-vmx.real"
        echo "Moving it to /usr/lib/vmware/bin/vmware-vmx.$$"
        if [ -f /usr/lib/vmware/bin/vmware-vmx.real.$$ ]; then
            echo "Or not!  /usr/lib/vmware/bin/vmware-vmx.real.$$ already exists!"
            echo "ERROR: can't continue! Please clean up your VMware install!"
            exit 16
        fi
        mv /usr/lib/vmware/bin/vmware-vmx.real /usr/lib/vmware/bin/vmware-vmx.real.$$
        if [ $? -ne 0 ]; then
            echo "ERROR $? moving vmware-vmx.real."
            echo "   Can't continue!"
            exit 16
        fi
    fi
    mv /usr/lib/vmware/bin/vmware-vmx /usr/lib/vmware/bin/vmware-vmx.real
    if [ $? -ne 0 ]; then
        echo "ERROR $? moving vmware-vmx to vmware-vmx.real!"
        echo "     Can't continue!"
        exit 16
    fi
    touch /usr/lib/vmware/bin/vmware-vmx
    cat > /usr/lib/vmware/bin/vmware-vmx <<'EOF'
#!/bin/bash
DO3D="${DO3D}"
if [ -z "${DO3D}" ]; then
    ps -ef |egrep -q '[p]rimusrun.*vmware'
    if [ $? -eq 0 ]; then
        DO3D="y"
    else
        DO3D="n"
    fi
fi

# Find primusrun or optirun, since this can work with both, eventually
bbrun="/usr/bin/primusrun"
PRELOAD="/usr/lib/x86_64-linux-gnu/primus/libGL.so.1"
if [ ! -x ${bbrun} ]; then
    bbrun="/usr/bin/optirun"
    #PRELOAD="/usr/lib/x86_64-linux-gnu/optimus/libGL.so.1"
    PRELOAD=""
fi
if [ ! -x ${bbrun} ]; then
    echo "ERROR: Couldn't find Primus or Optimus!"
    exit 4
fi


if [ "${DO3D}" = "y" ]; then
    export PRIMUS_libGLa='/usr/lib/nvidia-current/libGL.so.1'
    export LD_LIBRARY_PATH=/usr/lib/nvidia-current:/usr/lib32/nvidia-current:/usr/lib/nvidia-current/tls:/usr/lib32/nvidia/tls

    LD_PRELOAD=${PRELOAD} exec ${bbrun} /usr/lib/vmware/bin/vmware-vmx.real "$@"
else
    /usr/lib/vmware/bin/vmware-vmx.real "$@"
fi

EOF
    chmod u+s,a+x /usr/lib/vmware/bin/vmware-vmx
    exit 0
}

#figure out which options the user wants
echo $1 | egrep -q -w '(yes|y|f|force)'
if [ $? -eq 0 ]; then
    echo "forcing 3d on"
    FORCE3D="y"
fi

echo $1 | egrep -q -w '(n|no)'
if [ $? -eq 0 ]; then
    echo "Forcing 3D off"
    FORCE3D="n"
fi

echo $1 | egrep -q -w '(i|install)'
if [ $? -eq 0 ]; then
    if [ "$USER" = "root" ]; then
        `installvmx_script`
        if [ $? -eq 0 ]; then
            exit 0
        else
            echo "Some error happened in the installer!"
            exit 1
        fi
    else
        echo "ERROR: Have to be root to run the install!"
        echo "       Please try again via $SUDO."
        exit 2
    fi
fi

# Find primusrun or optirun, since this can work with both, eventually
bbrun="/usr/bin/primusrun"
if [ ! -x ${bbrun} ]; then
    bbrun="/usr/bin/optirun"
fi
if [ ! -x ${bbrun} ]; then
    echo "ERROR: Couldn't find Primus or Optimus!"
    exit 4
fi


if [ "${FORCE3D}" = "y" ]; then
    #The user wants it forced on! Easy!
    DO3D="y"
elif [ "${FORCE3D}" = "n" ]; then
    DO3D="n"
else
    #automatic!

    # Now determine if we're on AC (mains) power or not
    ACSTATE=`awk '/state:/ { print $NF }' ${ACADAPTER}`
    BATSTATE=""
    if [ -f ${BATTERY}/state ]; then
        BATPRESENT=`awk '/present:/i { print $NF }' ${BATTERY}/state | grep -i "yes"`
        if [ $? = 0 ]; then
            BATSTATE=`awk '/charg/i { print $NF; exit }' ${BATTERY}/state`
        else
            BATSTATE="NF"
        fi
    else
        BATSTATE="NF"
    fi

    if [ "X${ACSTATE}" = "Xoff-line" -o "X${BATSTATE}" = "Xdischarging" ]; then
        echo "AC is offline"
        DO3D="n"
    else
        DO3D="y"
    fi
fi

export DO3D

if [ "${DO3D}" = "y" ]; then
    #TODO Fix up for non-ubuntu installs
    export PRIMUS_libGLa='/usr/lib64/nvidia-bumblebee/libGL.so.1'
    export LD_LIBRARY_PATH=/usr/lib/nvidia-current:/usr/lib32/nvidia-current:/usr/lib/nvidia-current/tls:/usr/lib32/nvidia/tls:/usr/lib64/nvidia-bumblebee

    #this is to get sudo to work properly with vmware
    if [ -z "${XAUTHORITY}" ]; then
        export XAUTHORITY=${HOME}/.Xauthority
        XAUTHORITY=${HOME}/.Xauthority $SUDO ${bbrun} /usr/bin/vmware
    else
        export XAUTHORITY
        XAUTHORITY=${XAUTHORITY} $SUDO ${bbrun} /usr/bin/vmware
    fi
else
    /usr/bin/vmware
fi

exit 0
