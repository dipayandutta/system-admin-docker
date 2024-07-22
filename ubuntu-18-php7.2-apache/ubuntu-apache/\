FROM ubuntu:18.04

LABEL maintainer = "System Admin"
ARG DEBIAN_FRONTEND=noninteractive

# Add developer user and developer group
RUN groupadd -r developer && useradd -r -g developer developer

# Update the container and install essential packages
RUN apt-get update && apt-get install build-essential -y

# Use the default UTF-8 language.
ENV LANG C.UTF-8

# Install PHP-7.2
RUN apt-get update && apt-get install -y libxml2-dev && apt-get -y install software-properties-common && apt-get -y install git && add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y apache2 && apt-get install -y php7.2 && apt-get install -y libapache2-mod-php7.2 php7.2-curl php7.2-json php7.2-gd  php7.2-pdo-odbc php7.2-bz2 php7.2-mongodb php7.2-dev php7.2-bcmath php7.2-mysql php7.2-mysqli php7.2-pdo php7.2-json php7.2-json php7.2-oauth  php7.2-phar php7.2-ldap php7.2-xmlreader php7.2-mbstring php7.2-zip php7.2-uploadprogress php7.2-yaml php7.2-pdo-dblib php7.2-exif php7.2-pgsql php7.2-libsodium php7.2-gettext php7.2-xsl  && apt-get clean && rm -rf /var/lib/apt/lists/*


# Install apache web application server 
RUN apt-get install apache2 -y

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
EXPOSE 80

# Copy PHP info page
COPY php/info.php /var/www/html

# Foreground
CMD ["apachectl","-D","FOREGROUND"]
