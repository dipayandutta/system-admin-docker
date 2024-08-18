#######################################
#  Based on Ubuntu focal,
#  contains PHP 8.0, OCI8, Apache 2.4.38, and
#   oracle instant-client 18.5 (oci)
#######################################
FROM kasmweb/ubuntu-focal-desktop:1.14.0-rolling


USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

#################################################
MAINTAINER  KPD Computer Cell

ENV REFRESHED_AT 14-AUG-24
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_18_5

## Updating apt repository
RUN apt-get update

## INSTALL build-essentials
RUN apt-get install build-essential -y

## INSTALL libtool
RUN apt-get install libtool -y
## RUN dev packages
RUN apt-get install libaio-dev libldap2-dev zlib1g-dev libzip-dev -y
##INSTALL libaio-dev
RUN apt-get install libaio-dev -y
##INSTALL Apache
RUN apt-get install apache2 -y

## Installing PHP 8.0 
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update -y
RUN apt-get install php8.0 php8.0-xml libapache2-mod-php8.0 php8.0-soap php8.0-intl php8.0-dev php8.0-curl php8.0-mbstring  php8.0-gd php8.0-fpm libapache2-mod-fcgid -y

## INSTALL php-pear
RUN apt-get install -y php-pear

## Enable apache URL rewrite
RUN a2enmod rewrite


## Installing zip tools
RUN apt-get install --no-install-recommends -y \
        zip unzip 

## Adding oci drivers
ADD oci/x64-18.5.0.0.0/ /opt/oracle/
RUN unzip /opt/oracle/instantclient-basiclite-linux.zip -d /opt/oracle \
    && unzip /opt/oracle/instantclient-sdk-linux.zip -d /opt/oracle \
    && ln -sfn /opt/oracle/instantclient_18_5/libclntsh.so.18.1 /opt/oracle/instantclient_18_5/libclntsh.so \
    && ln -sfn /opt/oracle/instantclient_18_5/libclntshcore.so.18.1 /opt/oracle/instantclient_18_5/libclntshcore.so \
    && ln -sfn /opt/oracle/instantclient_18_5/libocci.so.18.1 /opt/oracle/instantclient_18_5/libocci.so \
    && rm -rf /opt/oracle/*.zip

## Installing PHP oci pdo_oci
RUN echo 'instantclient,/opt/oracle/instantclient_18_5' | pecl install oci8-3.0.1

RUN echo "extension=oci8.so" > /etc/php/8.0/cli/conf.d/oci8.ini \
    && echo "extension=oci8.so" > /etc/php/8.0/apache2/conf.d/oci8.ini \
    && echo "export LD_LIBRARY_PATH=/opt/oracle/instantclient_18_5" >> /etc/apache2/envvars

## Installing ldap drivers, extensions and libs
RUN apt-get install --no-install-recommends libldap2-dev php8.0-ldap -y

## Installing GD libs (for pdf and image manipulation)
RUN apt-get install --no-install-recommends zlib1g-dev \
    libfreetype6-dev libjpeg-turbo8-dev libpng-dev  -y

## Installing PHP zip
RUN apt-get install --no-install-recommends libzip-dev -y

## Installing PHP curl 
#RUN apt-get install --no-install-recommends -y

## Installing mbstring
#RUN apt-get install --no-install-recommends php8.0-mbstring -y

## Installing pdftk
RUN apt-get install --no-install-recommends pdftk -y

## Installing poppler-utils (pdftotext)
RUN apt-get install --no-install-recommends poppler-utils -y
########################################################
#
#######################################################
RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php

## Cleaning apt repo
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
#######################################################################Install JAVA
RUN apt-get update && \ 
    apt-get install -y openjdk-8-* 


RUN cd /opt \
    &&  wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz \
    &&  cp  /opt/apache-tomcat-9.0.93.tar.gz  /tmp/  \
    && cd /tmp \
    && tar -xvzf apache-tomcat-9.0.93.tar.gz    \
    && mkdir /usr/local/tomcat \
    && cd /tmp/apache-tomcat-9.0.93 \
    && cp -R *  /usr/local/tomcat/ \
    && echo root:password | chpasswd 

################# SSH #####################

RUN apt-get update && \
 apt-get install -y openssh-server sudo 
# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1001 sshuser
# # Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd
# # Allow SSH access
RUN mkdir /var/run/sshd

############################################################################
## Defining default command to be executed on container run
RUN echo " /usr/sbin/apache2ctl -D FOREGROUND" >> /root/startapps.sh
RUN echo "/usr/sbin/sshd -D FOREGROUND">> /root/startapps.sh
############################################
#
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

