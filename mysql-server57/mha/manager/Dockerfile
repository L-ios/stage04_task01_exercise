FROM fedora:latest

ARG MHA4MYSQL_VERSION=0.58
ARG MHA4MYSQL_MANAGER_PACKAGE=mha4mysql-manager-${MHA4MYSQL_VERSION}-0.el7.centos.noarch.rpm
ARG MHA4MYSQL_NODE_PACKAGE=mha4mysql-node-${MHA4MYSQL_VERSION}-0.el7.centos.noarch.rpm

RUN dnf install -y \
        openssh-clients \
        openssh-server \
        openssl \
        passwd \
        perl-DBD-MySQL \
        perl-Config-Tiny \
        perl-Log-Dispatch \
        perl-Parallel-ForkManager \
    && dnf install -y \
        https://github.com/yoshinorim/mha4mysql-manager/releases/download/v${MHA4MYSQL_VERSION}/${MHA4MYSQL_MANAGER_PACKAGE} \
        https://github.com/yoshinorim/mha4mysql-node/releases/download/v${MHA4MYSQL_VERSION}/${MHA4MYSQL_NODE_PACKAGE} \
    && dnf clean all

COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
CMD ["bmysqld"]
