FROM ubuntu:22.04

#set non-interactive
 ARG DEBIAN_FRONTEND=noninteractive
# Install neccessary libraries
RUN apt-get update && apt-get install -y vim build-essential curl iproute2 sudo openssh-server sudo vim supervisor procps uuid-runtime  autoconf bzip2 curl gettext git g++ freetds-bin freetds-dev freetds-common make libbz2-dev libcurl4-openssl-dev libicu-dev  libzip-dev libfreetype6-dev libgd-dev libpq-dev libpng-dev libssl-dev libtidy-dev libxslt-dev libxml2-dev pkg-config unzip zip tar libaio-dev libmcrypt-dev  libc6 libmagickwand-dev  wget zlib1g-dev && apt-get clean 

## Installing PHP 8.0
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update -y
RUN apt-get install php8.0 php8.0-xml libapache2-mod-php8.0 php8.0-soap php8.0-intl php8.0-dev php8.0-curl php8.0-mbstring  php8.0-gd php8.0-fpm libapache2-mod-fcgid -y
## INSTALL php-pear
RUN apt-get install -y php-pear
## Enable apache URL rewrite
RUN a2enmod rewrite


# Install Apache2
RUN apt-get install apache2 -y

#create the PHP info page
RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Install JAVA version 8
RUN apt-get update && \ 
    apt-get install -y openjdk-8-* 

# Copy supervisord.conf 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1001 sshuser
#Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd
# # Allow SSH access
RUN mkdir /var/run/sshd

#Expose ports
EXPOSE 22 80

#run supervisord at the startup
CMD ["/usr/bin/supervisord"]
