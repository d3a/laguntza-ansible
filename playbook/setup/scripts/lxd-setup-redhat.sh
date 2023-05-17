#!/bin/bash

# lxc exec Ubuntu2204 wheel- /bin/bash
useradd ansible -G wheel

dnf install openssh-server
systemctl start sshd
systemctl enable sshd