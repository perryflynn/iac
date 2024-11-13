#!/usr/bin/bash

set -e -u -x

# https://gitlab.archlinux.org/archlinux/packaging/packages/cloud-init/-/issues/3#note_216601
ln -s /bin/nc /bin/nc.openbsd
sed -i '/Before=sysinit.target/d' /usr/lib/systemd/system/cloud-init-main.service

# enable cloud-init services
systemctl enable cloud-init-local || true
systemctl enable cloud-init-main.service
systemctl enable cloud-init-network || true
systemctl enable systemd-networkd || true
systemctl enable systemd-timesyncd || true
systemctl enable systemd-resolved || true
