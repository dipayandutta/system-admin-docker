FROM ubuntu:22.04

LABEL maintainer = "Dipaya Dutta"
ARG DEBIAN_FRONTEND=noninteractive

# Add developer user and developer group
RUN groupadd -r developer && useradd -r -g developer developer

# Update the container and install essential packages
RUN apt-get update && apt-get install build-essential -y

# Use the default UTF-8 language.
ENV LANG C.UTF-8

# Install openssh-server
RUN apt-get install -y openssh-server sudo supervisor vim procps uuid-runtime curl unzip inetutils-ping

# Install PHP-7.4
#RUN apt-get update && apt-get install -y libxml2-dev && apt-get -y install software-properties-common && apt-get -y install git && add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y apache2 && apt-get install -y php7.4 && apt-get install -y libapache2-mod-php7.4 php7.4-curl php7.4-json php7.4-gd  php7.4-pdo-odbc php7.4-bz2 php7.4-mongodb php7.4-dev php7.4-bcmath php7.4-mysql php7.4-mysqli php7.4-pdo php7.4-json php7.4-json php7.4-oauth  php7.4-phar php7.4-ldap php7.4-xmlreader php7.4-mbstring php7.4-zip php7.4-uploadprogress php7.4-yaml php7.4-pdo-dblib php7.4-exif php7.4-pgsql php7.4-libsodium php7.4-gettext php7.4-xsl  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y install libxml2-dev && apt-get -y install software-properties-common && \
apt-get install -y git && add-apt-repository ppa:ondrej/php  && \
apt-get update && \
apt-get install -y apache2 && \
apt-get -y install php7.4-common php7.4-mysql php7.4-xml php7.4-json php7.4-mbstring php7.4-gd php7.4-curl php7.4-zip php7.4-intl

RUN apt-get  -y install libapache2-mod-php7.4

# Install apache web application server 
RUN apt-get install apache2 -y

# Create a OWNCLOUD Directory
RUN mkdir -p /var/www/html/owncloud 

# COPY owncloud
COPY owncloud /var/www/html/owncloud

# Change Permission
#RUN chown -R www-data:www-data /var/www/html/owncloud

# Copy Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1001 sshuser
# Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd
# Allow SSH access
RUN mkdir /var/run/sshd

# Copy security configurations
COPY security.conf /etc/apache2/conf-enabled/
COPY 000-default.conf /etc/apache2/sites-enabled

# enable modrewrite and headers
COPY rewrite.load /etc/apache2/mods-enabled 
COPY headers.load /etc/apache2/mods-enabled 

# Update 
RUN apt-get update -y

# Install apache mod security 
RUN apt-get install libapache2-mod-security2 -y && apt-get install vim -y


# git clone core rule sets
RUN git clone https://github.com/coreruleset/coreruleset.git

#ENVIORMENTAL VARIABLES
ENV HOME /home/developer
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Expose PORT
EXPOSE 22 80

# Copy PHP info page
COPY php/info.php /var/www/html

# RUN supervisord
CMD ["/usr/bin/supervisord"]
# Foreground
#CMD ["apachectl","-D","FOREGROUND"]
