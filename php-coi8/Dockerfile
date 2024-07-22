FROM php:7.2.10-apache
LABEL MAINTAINER="Jitendra5 Gupta <jitendra1310@gmail.com>"

# installing required stuff
RUN apt-get update && apt-get upgrade -y --allow-unauthenticated
RUN apt-get install -y autoconf bzip2 curl gettext git g++ freetds-bin freetds-dev freetds-common make libbz2-dev libcurl4-openssl-dev libicu-dev  libzip-dev libfreetype6-dev libgd-dev libjpeg62-turbo-dev libpq-dev libpng-dev libssl-dev libtidy-dev libxslt-dev libxml2-dev pkg-config unzip zip tar libaio-dev libmcrypt-dev  libc6 libmagickwand-dev  wget zlib1g-dev && apt-get clean -y
# Fix to pdo_dblib install
RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/

# Install Extensions
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install bz2
RUN docker-php-ext-install calendar
RUN docker-php-ext-install exif
RUN docker-php-ext-install gd
RUN docker-php-ext-install gettext
RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install soap
RUN docker-php-ext-install tidy
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl
RUN docker-php-ext-configure zip --with-libzip;

RUN docker-php-ext-configure opcache
RUN docker-php-ext-install opcache

# Redis,xdebug
RUN pecl install redis-5.3.7 \
 && pecl install xdebug-3.1.0 \
 && docker-php-ext-enable redis xdebug


# Install APCU
# Install APCu and APC backward compatibility
RUN pecl install apcu-5.1.22 \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini

# Memory Limit
RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

#For ORDER Repo
RUN mkdir /logs

RUN mkdir /opt/tmp \
    && echo "session.save_path=\"/opt/tmp\"" >> /usr/local/etc/php/php.ini
# Install Oracle Instantclient
ENV ORACLE_HOME=/opt/oracle/instantclient_19_10
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_19_10
RUN mkdir /opt/oracle \
    && cd /opt/oracle \
    && wget https://download.oracle.com/otn_software/linux/instantclient/191000/instantclient-basic-linux.arm64-19.10.0.0.0dbru.zip \
    && wget https://download.oracle.com/otn_software/linux/instantclient/191000/instantclient-sdk-linux.arm64-19.10.0.0.0dbru.zip \
    && unzip /opt/oracle/instantclient-basic-linux.arm64-19.10.0.0.0dbru.zip -d /opt/oracle \
    && unzip /opt/oracle/instantclient-sdk-linux.arm64-19.10.0.0.0dbru.zip -d /opt/oracle \
    && unlink /opt/oracle/instantclient_19_10/libclntsh.so \
    && ln -s /opt/oracle/instantclient_19_10/libclntsh.so.19.1 /opt/oracle/instantclient_19_10/libclntsh.so \
    && rm -rf /opt/oracle/*.zip

RUN export PHP_DTRACE=yes
RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/opt/oracle/instantclient_19_10,19.1 \
&& echo /opt/oracle/instantclient_19_10 > /etc/ld.so.conf.d/oracle-instantclient  \
&& docker-php-ext-install oci8 \
&& ldconfig



# Redis, 
#RUN pecl install -o -f redis &&  rm -rf /tmp/pear &&  docker-php-ext-enable redis

# amqp
#RUN pecl install amqp-1.11.0

# apache configurations, mod rewrite
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
# Apache2 Service Restart
RUN service apache2 restart


