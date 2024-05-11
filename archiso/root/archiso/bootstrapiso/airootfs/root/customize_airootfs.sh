#!/usr/bin/bash

set -e -u -x

# enable cloud-init services
systemctl enable cloud-init-local
systemctl enable cloud-init
systemctl enable cloud-config
systemctl enable cloud-final

# disable mirror reflector
#systemctl disable reflector
