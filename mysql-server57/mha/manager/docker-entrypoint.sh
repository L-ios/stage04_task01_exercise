#!/bin/bash

set -e

if [[ ! -f "/etc/ssh/ssh_host_rsa_key" ]]; then
    ssh-keygen -A
fi
if [[ ! -f "~/.ssh/id_rsa" ]]; then
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi
