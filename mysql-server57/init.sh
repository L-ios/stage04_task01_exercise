#!/bin/bash

set -e

SERVER=$(docker-compose -f mysql.yml ps --services)
SERVER=(${SERVER})
INDEX=0
while [ $INDEX -lt ${#SERVER[@]} ]; do
    NEXT_SERVER="${SITES[$SITE_INDEX]}"
    container=$(docker-compose -f mysql.yml ps ${NEXT_SERVER} | tail -n1)
    container=(${container})
    docker exec -it ${container} cat /root/.ssh/id_rsa.pub >> authorized_keys
    INDEX=$(( INDEX + 1 ))
done

# authorized_keys copy到容器中

# 生产ssh联通认证文件

