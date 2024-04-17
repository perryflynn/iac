# iac

Infrastructure as Code.

This project installs and configures Arch Linux or Debian operating systems fully automated.

> ⚠ This project is in beta state and all scripts referencing hard coded to the `dev` branch.

Features:

- Uses `ansible-pull` for apply configurations by hostname
- Build the installer ISO image
- Install a minimal Arch Linux OS
- Install a minimal Debian OS
- Configure the Arch Linux OS with a graphical environment

## archiso

[Archiso](https://wiki.archlinux.org/title/archiso) is used as a base. [archiso/](./archiso/) contains
a Dockerfile and some scripts to build a custom Arch Linux installer iso with additional scripts.

- `./archiso/build.sh` builds the container image
- `./archiso/pack.sh` runs the container image to build the Arch Linux ISO image

## Automatic hostname detection

The `perrys-bootstrapper.sh` script is using UEFI variables to fetch the hostname from the system and use the
correct ansible inventory variables.

Set hostname in UEFI variable:

```sh
echo -n wuseldusel > efi-hostname
efivar --name ed38a5bf-1135-4b0f-aa72-49d30b05dfd4-PerryHostname -w -f efi-hostname
```

Get the hostname from UEFI variable:

```sh
cat /sys/firmware/efi/efivars/PerryHostname-ed38a5bf-1135-4b0f-aa72-49d30b05dfd4
```

## How to install a OS

- Build the Arch Linux ISO image
- Boot ISO in a virtual machine or on a physical system
- Ensure that the `diskdev` and `bootmode` are correct in the [inventoy](./inventory/defaults.yml)
- Run installer
    - Debian: `perrys-bootstrapper.sh --flavor debian`
    - Arch Linux: `perrys-bootstrapper.sh --flavor archlinux`
- Reboot into the new OS

## Configure Arch Linux OS

Run `perrys-ansible-apply.sh` as root.

It pulls automatically the correct playbook from this repo by the hostname of the operating system.

## TODO

- [x] Swap File
- [ ] Disk Encryption
