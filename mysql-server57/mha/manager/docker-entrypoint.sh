#!/bin/bash

set -e

echo "ssh-keygen all host key."
if [[ ! -f "/etc/ssh/ssh_host_rsa_key" ]]; then
    ssh-keygen -A
fi

echo "ssh-keygen ${USER} id_rsa."
if [[ ! -f "~/.ssh/id_rsa" ]]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi

echo "reset root password"
if [[ -z "${ROOT_PASSWORD}" ]]; then
	ROOT_PASSWORD=$(openssl rand -hex 16)
    echo "root password not found, random password: ${ROOT_PASSWORD}"
fi

echo "${ROOT_PASSWORD}" | passwd --stdin root
