#!/bin/bash

set -e

if [[ -z "${MHA_MANAGER_CONF}" ]]; then
    MHA_MANAGER_CONF=/etc/mha/manager.conf
fi

if masterha_check_repl --conf=${MHA_MANAGER_CONF}; then
    echo "${MHA_MANAGER_CONF} has problem"
    exit 1
fi
