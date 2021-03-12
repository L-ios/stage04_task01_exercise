#!/bin/bash
set -e

echo "ssh-keygen all host key."
if [[ ! -f "/etc/ssh/ssh_host_rsa_key" ]]; then
    ssh-keygen -A
fi

echo "ssh-keygen root id_rsa."
if [[ ! -f "/root/.ssh/id_rsa" ]]; then
    ssh-keygen -q -t rsa -N "$(cat /etc/hostname)" -f /root/.ssh/id_rsa
fi

echo "reset root password"
if passwd --status root; then
    if [[ -z "${ROOT_PASSWORD}" ]]; then
        ROOT_PASSWORD=$(openssl rand -hex 16)
        echo "root password not found, random password: ${ROOT_PASSWORD}"
    fi
    echo "${ROOT_PASSWORD}" | passwd --stdin root
fi

/usr/sbin/sshd -oPermitRootLogin=yes

if [[ -z "${MHA_MANAGER_CONF}" ]]; then
    MHA_MANAGER_CONF=/etc/mha/manager.conf
fi

if masterha_check_repl --conf=${MHA_MANAGER_CONF}; then
    echo "${MHA_MANAGER_CONF} has problem"
    exit 1
fi

masterha_manager --conf=${MHA_MANAGER_CONF} --remove_dead_master_conf --ignore_last_failover
