#!/bin/bash

# lxc exec Ubuntu2204 -- /bin/bash
useradd ansible -m -G sudo
echo ansible:ansible | chpasswd

apt install ssh


