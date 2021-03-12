FROM fedora:latest

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-5.7.33
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.22
ARG MHA4MYSQL_VERSION=0.58
ARG MHA4MYSQL_NODE_PACKAGE=mha4mysql-node-${MHA4MYSQL_VERSION}-0.el7.centos.noarch.rpm

# Install server
RUN dnf install -y https://repo.mysql.com/mysql-community-release-el7.rpm \
    && dnf install -y dnf-plugins-core \
    && dnf config-manager --enable mysql57-community \
    && dnf config-manager --disable mysql80-community \
    && dnf install -y \
        openssh-clients \
        openssh-server \
        openssl \
        passwd \
        $MYSQL_SERVER_PACKAGE \
        $MYSQL_SHELL_PACKAGE \
        libpwquality \
        perl-DBD-MySQL \
    && dnf install -y https://github.com/yoshinorim/mha4mysql-node/releases/download/v${MHA4MYSQL_VERSION}/${MHA4MYSQL_NODE_PACKAGE} \
    && dnf clean all \
    && mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]

