#!/bin/bash

# Usage info
show_help()  {
cat << EOF
Usage: ${0##*/} [-h] [-a (0, 1)] ...
TIME MACHINE SPEED!
Change the disk operation throttle to on or off for the purposes of speeding up Time Machine

    -h    display this help and exit
    -a    Provide 1 for ON or 0 for OFF to designate the desired state of disk throttling

EOF
}

# Variables
throttling_state=""
no_args="true"

# Get opts section
while getopts "hva:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        a)
            throttling_state=$OPTARG
            ;;
        '?')
            show_help >&2 
            exit 1
            ;;
    esac
    no_args="false"
done

[[ $no_args == "true" ]] && { show_help; exit 1; }

# Disabling
if [ "$throttling_state" = "0" ];
then
    sudo sysctl debug.lowpri\_throttle_enabled=0
    echo $?
    echo "Make sure to re-enable with -a 1 after backup completes!!!"
fi

# Enabling
if [ "$throttling_state" = "1" ];
then
    sudo sysctl debug.lowpri\_throttle_enabled=1
    echo $?
fi

# If argument is not 0 or 1
if [ "$throttling_state" \> "1" ];
then
    show_help
    exit 0
fi

