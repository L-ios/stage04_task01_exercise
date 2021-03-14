#!/bin/bash

set -ex

DOCKER_COMPOSE_FILE=mysql.yml

# 查找所有的container
SERVERS=$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps --services)
CONTAINERS=()
for server in ${SERVERS}; do
    container=$(docker-compose -f ${DOCKER_COMPOSE_FILE} ps ${server} | awk 'NR==3 {print $1}')
    CONTAINERS+=(${container})
done

C_AUTHORIZED_KEYS=/root/.ssh/authorized_keys

AUTHORIZED_KEYS=$(basename ${C_AUTHORIZED_KEYS})
# 生产连接文件
cp /dev/null ${AUTHORIZED_KEYS}
for container in ${CONTAINERS[@]}; do
    docker exec -it ${container} cat /root/.ssh/id_rsa.pub >> ${AUTHORIZED_KEYS}
done

# 将生产的连接文件拷贝到容器中
for container in ${CONTAINERS[@]}; do
    docker cp ${AUTHORIZED_KEYS} ${container}:${C_AUTHORIZED_KEYS}
    docker exec -it ${container} chown root:root ${C_AUTHORIZED_KEYS}
done

rm -rf ${AUTHORIZED_KEYS}
