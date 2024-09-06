FROM  oraclelinux:7.9
COPY epel-release-latest-7.noarch.rpm /opt/epel-release-latest-7.noarch.rpm
COPY Dockerfile  /Dockerfile
COPY runscript.squid /runscript.squid
COPY webmin-2.105-1.noarch.rpm /opt
RUN yum -y update \
    && yum -y install  squid   httpd httpd-tools cronie \
    && yum -y localinstall /opt/epel-release-latest-7.noarch.rpm \
    && yum -y localinstall /opt/webmin-2.105-1.noarch.rpm \
    && yum -y install supervisor \ 
    && htpasswd -c -b /etc/squid/passwords proxyuser password\
    &&  mkdir -p /var/spool/squid  \
    && chmod -R 777 /var/spool/squid

WORKDIR /etc/squid/
COPY squid.conf /etc/squid/squid.conf
COPY supervisord.conf /etc/supervisord.conf
EXPOSE 10000
ENTRYPOINT ["/usr/bin/supervisord"]
