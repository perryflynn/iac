#!/bin/bash

set -u
set -e

export PYTHONUNBUFFERED=1

# Arguments
ARG_HELP=0
UNKNOWN_OPTION=0
ARG_FLAVOR=archlinux

# Arguments from cli
if [ $# -ge 1 ]
then
    while [[ $# -ge 1 ]]
    do
        key="$1"
        case $key in
            --flavor)
                shift
                ARG_FLAVOR=$1
                ;;
            -h|--help)
                ARG_HELP=1
                ;;
            *)
                # unknown option
                ARG_HELP=1
                UNKNOWN_OPTION=1
                ;;
        esac
        shift # past argument or value
    done
else
    # no arguments passed, show help
    ARG_HELP=1
fi

# Help
if [ $ARG_HELP -eq 1 ]
then
    if [ $UNKNOWN_OPTION -eq 1 ]
    then
        echo "Unknown option."
        echo
    fi

    echo "Bootstrap Operating Systems with Ansible"
    echo "https://github.com/perryflynn/iac"
    echo
    echo "Usage: $0 --flavor [debian|archlinux]"
    echo
    echo "-h, --help         Print this help"
    echo "--flavor os        OS to bootstrap"
    echo "                   one of 'debian' or 'archlinux'"
    echo
    exit
fi

loadkeys de
hostnamectl hostname "${ARG_FLAVOR}iso"

mount -o remount,size=2G /run/archiso/cowspace
pacman --noconfirm --needed -Sy archlinux-keyring
pacman --noconfirm --needed -S ansible git

ansible-pull -U https://github.com/perryflynn/iac.git -C dev -l "bootstrap-$ARG_FLAVOR"
