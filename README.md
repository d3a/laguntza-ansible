# LXD/LXC

## [Instalación](lxd-setup.md)

### Ubuntu
```bash
apt install ansible
```



## Comandos

### ansible-inventory
```bash
ansible-inventory [--inventory <invent-file>] [--output <output-file>] [--yaml | --toml] --list
ansible-inventory [--inventory <invent-file>] [--vars] --graph
ansible-inventory [--inventory <invent-file>] --host <host>
```

### ansible
```bash
ansible <target> [-i <invent-file>] [-m <modulo>] [-a <argumentos>]
    algunos modulos:
        command # default
        shell
        script
        ping
        setup   # facts
    ejemplos:
        -a "/sbin/reboot"
        -m ansible.builtin.copy -a "src=/etc/hosts dest=/tmp/hosts"
        -m ansible.builtin.apt -a "name=acme state=present"
        -m ansible.builtin.user -a "name=nombre_usuario password=mipass"
        -m ansible.builtin.service -a "name=httpd state=started"
```

### ansible-playbook

### ansible-doc
```bash
ansible-vault --list | <modulo>
```

### ansible-vault
```bash
ansible-vault encrypt_string 'foobar' --name 'the_secret' --ask-vault-pass

export EDITOR=nano
ansible-vault create vault.yaml
ansible-vault view vault.yaml
ansible-vault edit vault.yaml

ansible-vault encrypt tasks.txt --output tasks.txt.enc
ansible-vault rekey tasks.txt.enc
ansible-vault decrypt tasks.enc.txt --output tasks2.txt
```
