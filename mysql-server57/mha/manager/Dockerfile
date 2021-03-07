# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
FROM oraclelinux:7-slim

ARG MYSQL_SERVER_PACKAGE=mysql-community-server-5.7.33
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.22
ARG MHA4MYSQL_VERSION=0.58
ARG MHA4MYSQL_MANAGER_PACKAGE=mha4mysql-manager-${MHA4MYSQL_VERSION}-0.el7.centos.noarch.rpm

# Install server
RUN yum install -y https://repo.mysql.com/mysql-community-minimal-release-el7.rpm \
        https://repo.mysql.com/mysql-community-release-el7.rpm \
    && yum-config-manager --enable mysql57-server-minimal \
    && yum install -y \
        $MYSQL_SERVER_PACKAGE \
        $MYSQL_SHELL_PACKAGE \
        libpwquality \
    && yum install -y \
        perl-DBD-MySQL \
        perl-Config-Tiny \
        perl-Log-Dispatch \
        perl-Parallel-ForkManager \
    && yum install -y https://github.com/yoshinorim/mha4mysql-manager/releases/download/v${MHA4MYSQL_VERSION}/${MHA4MYSQL_MANAGER_PACKAGE} \
    && yum clean all \
    && mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]

