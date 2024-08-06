FROM ubuntu:22.04

RUN apt update -y \
   && apt install -y inetutils-ping telnet vim squid

CMD ["squid","-NYC","-f","/etc/squid/squid.conf"]
