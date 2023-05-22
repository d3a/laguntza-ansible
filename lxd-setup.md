# Instalación LXD/LXC

Instalación y preparación del contenedores LXD para laboratorio de Ansible.

**Crear par de claves para conexiones ssh**
```bash
clave_privada="/home/d3a/.ssh/d3a_id"
ssh-keygen -t ed25519 -C "d3a@sauron" -f ${clave_privada} -N ""
eval "$(ssh-agent -s)"
ssh-add ${clave_privada}
```


**Instalar e inicializar LXD**
```bash
snap install lxd
lxd init
```

## Crear Plantillas base para 
**Ubuntu 22.04**

Se pueden buscar imagenes Ubuntu con el comando
```bash
lxc image list images: | egrep -i ubuntu
```

Crear contenedor Ubuntu 22.04 y entrada como root
```bash
lxc launch ubuntu:22.04 Ubuntu2204
lxc exec Ubuntu2204 -- /bin/bash
```

Dentro del contenedor Ubuntu2204 crear usuario e instalar SSH
```bash
useradd ansible -m -G sudo
echo ansible:ansible | chpasswd

apt update
apt upgrade
apt install ssh
vim /etc/ssh/sshd_config
# para incluir:
# PasswordAuthentication yes
service ssh restart
```
De nuevo en el host dar de alta maquina en hostst y estableces clave 
```bash
sudo echo "<ip-ubuntu2204>   ubuntu2204" >> /etc/hosts
ssh-copy-id -i ${clave_privada}.pub ansible@ubuntu2204
```

Denuevo dentro dentro del contenedor Ubuntu2204 securizamos SSH
```bash
vim /etc/ssh/sshd_config
# para incluir:
# PasswordAuthentication no
# PermitRootLogin no
service ssh restart
```



**Rocky Linux 8/9**

Se pueden buscar imagenes RockyLinux con el comando
```bash
lxc image list images: | egrep -i rocky
```

Crear contenedor Rocky Linux 8 y entrada como root
```bash
lxc launch images:rockylinux/8/amd64 RockyLinux8
lxc launch images:rockylinux/9/amd64 RockyLinux9
lxc exec RockyLinux8 -- /bin/bash
lxc exec RockyLinux9 -- /bin/bash
```

Dentro de los contenedores RockyLinux8 y RockyLinux9 crear usuario e instalar SSH
```bash
useradd ansible -G wheel

dnf install openssh-server
systemctl start sshd
systemctl enable sshd
```

De nuevo en el host dar de alta maquinas en hosts y establecer claves 
```bash
sudo echo "<ip-rockylinux8>   rockylinux8" >> /etc/hosts
sudo echo "<ip-rockylinux9>   rockylinux9" >> /etc/hosts
ssh-copy-id -i ${clave_privada}.pub ansible@ubuntu2204
```

## Crear plantilla a partir de los contenedores Base
Parar el conetnedores
```bash
lxc stop Ubuntu2204
lxc stop RockyLinux8
lxc stop RockyLinux9
```
Crear plantillas
```bash
lxc publish Ubuntu2204 --alias=Ubuntu2204ansible description="Ubuntu 22.04 con usuario ansible"
lxc publish RockyLinux8 --alias=RockyLinux8ansible description="Rocky Linux 8 con usuario ansible"
lxc publish RockyLinux9 --alias=RockyLinux9ansible description="Rocky Linux 9 con usuario ansible"
```

Crear nuevos contenedores a partir de las nuevas plantaillas
```bash
lxc launch Ubuntu2204ansible ua1
lxc launch Ubuntu2204ansible ua2
```

```bash
lxc list -c nts4Dmf
lxc image list
```
