FROM ubuntu:22.04

RUN echo 'root:root' | chpasswd
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
RUN apt-get update
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session
RUN apt-get install -y openssh-server vim sudo 
RUN printf "systemctl start systemd-logind" >> /etc/profile

RUN mkdir -p /var/run/sshd
RUN sed -i '/PasswordAuthentication no/c\PasswordAuthentication yes' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config

RUN useradd --create-home -s /bin/bash -m ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#Change root password
RUN echo 'root:dipayan' | chpasswd
EXPOSE 22 80
ENTRYPOINT ["/sbin/init"]
