FROM oraclelinux:9 

RUN yum update -y \
   && yum install -y iputils telnet vim squid

CMD ["squid","-NYC","-f","/etc/squid/squid.conf"]
