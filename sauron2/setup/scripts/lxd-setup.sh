#!/bin/bash


# Crear par de claves para conexiones ssh
clave_privada="/home/d3a/.ssh/d3a_id"
ssh-keygen -t ed25519 -C "d3a@sauron" -f ${clave_privada} -N ""
eval "$(ssh-agent -s)"
ssh-add ${clave_privada}


# Instalar e inicializar LXD
sudo apt install lxd
lxd init

# Crear Plantilla para Ubuntu 22.04
#lxc image list images:
lxc launch ubuntu:22.04 Ubuntu2204
lxc exec Ubuntu2204 -- /bin/bash
#ejecutar lxd-setup-ubuntu.sh
ssh-copy-id -i ${clave_privada}.pub ansible@ubuntu2204


lxc launch images:rockylinux/8/amd64 RockyLinux8
lxc stop RockyLinux8
# lxc start RockyLinux8

lxc launch images:rockylinux/9/amd64 RockyLinux9
lxc stop RockyLinux9
# lxc start RockyLinux9
lxc exec contenedor -- /bin/bash

# lxc list
# lxc image list
