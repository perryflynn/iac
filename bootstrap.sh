#!/bin/bash

set -u
set -e

export PYTHONUNBUFFERED=1

UEFI_HOSTNAME="/sys/firmware/efi/efivars/PerryHostname-ed38a5bf-1135-4b0f-aa72-49d30b05dfd4"

# Arguments
ARG_HELP=0
UNKNOWN_OPTION=0
ARG_FLAVOR=archlinux
ARG_HOSTNAME=""

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
            --hostname)
                shift
                ARG_HOSTNAME=$1
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
    echo "-h, --help          Print this help"
    echo "--hostname myhost   Override hostname of bootstrapped OS"
    echo "--flavor os         OS to bootstrap"
    echo "                    one of 'debian' or 'archlinux'"
    echo
    exit
fi

# Set hostname
hostnamectl hostname "${ARG_FLAVOR}iso"

# Expand disk size
mount -o remount,size=2G /run/archiso/cowspace

# Install tools
pacman --noconfirm --needed -Sy archlinux-keyring
pacman --noconfirm --needed -S ansible git

# Build arguments
extraargs=()

if [ -n "$ARG_HOSTNAME" ]; then
    extraargs+=( -e "{ \"hostname\": \"$ARG_HOSTNAME\" }" )
elif [ -f "$UEFI_HOSTNAME" ]; then
    extraargs+=( -e "{ \"hostname\": \"$(cat "$UEFI_HOSTNAME" | tr -cd "[:print:]\r\n\t")\" }" )
fi

# Run ansible
ansible-pull \
    -U https://github.com/perryflynn/iac.git -C dev \
    -l "bootstrap-$ARG_FLAVOR" \
    "${extraargs[@]}"
