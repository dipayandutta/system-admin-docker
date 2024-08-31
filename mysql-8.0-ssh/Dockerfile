FROM ubuntu

MAINTAINER DipayanDutta inbox.dipayan@gmail.com

RUN apt-get update && apt-get install -y vim && apt-get install -y wget

RUN apt-get install -y openssh-server

RUN apt-get install -y sudo

RUN mkdir -p /var/run/sshd

RUN chmod 0755 /var/run/sshd

#ENTRYPOINT service sshd start && /bin/bash

RUN useradd --create-home --shell /bin/bash --groups sudo dipayan

RUN  echo "dipayan:node" | chpasswd

EXPOSE 22

RUN  export DEBIAN_FRONTEND=noninteractive

ENV  DEBIAN_FRONTEND noninteractive

CMD wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb

CMD echo mysql-apt-config mysql-apt-config/repo-distro select ubuntu | debconf-set-selections

CMD echo mysql-apt-config mysql-apt-config/repo-codename select trusty | debconf-set-selections

#CMD echo mysql-apt-config mysql-apt-config/select-server select mysql-5.7 | debconf-set-selections

CMD echo mysql-community-server mysql-community-server/root-pass password securePassword | debconf-set-selections

CMD echo mysql-community-server mysql-community-server/re-root-pass password securePassword | debconf-set-selections

CMD dpkg -i mysql-apt-config_0.6.0-1_all.deb

RUN apt-get install -y mysql-server --force-yes

RUN apt-get install -y augeas-tools

CMD augtool set /files/etc/mysql/my.cnf/target[3]/character-set-server utf8

CMD augtool set /files/etc/mysql/my.cnf/target[3]/collation-server utf8_unicode_ci

RUN usermod -d /var/lib/mysql mysql

ENTRYPOINT service mysql start && service ssh start && /bin/bash

