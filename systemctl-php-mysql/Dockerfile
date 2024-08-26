FROM almalinux:latest

ENV container=docker

# The package `systemd-sysv` and `initscripts`
# are installed for providing backwards compatibility
# with some services and they are also needed for functioning
# of the `sshd-keygen` service.
RUN yum -y install dnf \
    && dnf -y upgrade \
    && dnf -y groupinstall "Development Tools" \
    && dnf -y install \
        systemd \
        systemd-sysv \
        initscripts \
        pam \
        epel-release \
        openssh-server \
        wget \
        vim \
        telnet \
        nmap \
        iproute \
        mc \
        nano \
        which \
        man \
        man-pages \
        cronie \
        passwd \
        httpd \
        httpd-tools \
        glibc-langpack-en \
    && dnf clean all \
    && yum clean all

# Install PHP 8.0
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
    && dnf install -y dnf-utils \
    && dnf module enable php:remi-8.0 -y \
    && dnf install -y php php-cli php-common php-gd php-mbstring php-xml php-mysqli

# insert phpinfo in /var/www/html
RUN echo -e "<?php phpinfo(); ?>" > /var/www/html/index.php

# MariaDB Installation
COPY mariadb.repo /etc/yum.repos.d/
RUN dnf -y update 
RUN dnf install -y MariaDB-server MariaDB-client


# Install Zabbix
#COPY epel.repo /etc/yum.repos.d/
#RUN dnf -y update 
#RUN rpm -Uvh https://repo.zabbix.com/zabbix/7.0/alma/9/x86_64/zabbix-release-7.0-5.el9.noarch.rpm 
#RUN dnf clean all 
#RUN dnf install -y zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent 

# Modified version of: https://hub.docker.com/r/centos/systemd/dockerfile
RUN rm -f \
        /lib/systemd/system/sockets.target.wants/*udev* \
        /lib/systemd/system/sockets.target.wants/*initctl* \
        /etc/systemd/system/*.wants/* \
    && cp -r /lib/systemd/system/sockets.target.wants/ /etc/systemd/system/ \
    && systemctl disable systemd-vconsole-setup.service \
    && systemctl disable systemd-udevd.service \
    && mkdir -p /etc/systemd/system/sys-fs-fuse-connections.mount.d/ \
    && echo -e '[Unit]\nConditionPathExists=/sys/fs/fuse/connections\nConditionCapability=CAP_SYS_ADMIN\nConditionVirtualization=!private-users\n' > /etc/systemd/system/sys-fs-fuse-connections.mount.d/docker-virt.conf \
    && mkdir -p /etc/systemd/system/console-getty.service.d/ \
    && echo -e '[Service]\nExecStart=\nExecStart=-/sbin/agetty --autologin root --noclear --keep-baud console 115200,38400,9600 $TERM\n' > /etc/systemd/system/console-getty.service.d/docker-virt.conf


# The service `docker-ipv6-hosts-cleanup` removes IPv6 entries from `/etc/hosts`
# so daemons (e.g. postfix) do not expect these interfaces to be available.
# IPv6 loopback is not supported at all with Docker for Mac (and probably Docker Desktop at all).
RUN rm -f /etc/init.d/net* /run/nologin /var/run/nologin \
    && echo -e "[Unit]\nDescription=Remove IPv6 hosts entries\nBefore=network.target\n\n[Service]\nType=oneshot\nRemainAfterExit=true\nStandardOutput=journal\nExecStart=/usr/bin/sed -r -i -c '/^[:0-9a-f]+\\\\\s+/d' /etc/hosts\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/docker-ipv6-hosts-cleanup.service \
    && systemctl enable docker-ipv6-hosts-cleanup.service \
    && sed -ri '0,/^#?\s*(PermitRootLogin)\s+.*$/s//\1 yes/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(PubkeyAuthentication)\s+.*$/s//\1 yes/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(AllowAgentForwarding)\s+.*$/s//\1 yes/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(PermitTTY)\s+.*$/s//\1 yes/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(AllowTcpForwarding)\s+.*$/s//\1 yes/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(MaxAuthTries)\s+.*$/s//\1 10/' /etc/ssh/sshd_config \
    && sed -ri '0,/^#?\s*(ListenAddress)\s+.*$/s//\1 0.0.0.0/' /etc/ssh/sshd_config \
    && systemctl enable sshd.service \
    && sed -ri '0,/^#?\s*(Compress)\s*=\s*.*$/s//\1=no/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(SystemMaxUse)\s*=\s*.*$/s//\1=50M/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(RuntimeMaxUse)\s*=\s*.*$/s//\1=5%/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(SyncIntervalSec)\s*=\s*.*$/s//\1=15m/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(RateLimitInterval)\s*=\s*.*$/s//\1=10s/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(RateLimitBurst)\s*=\s*.*$/s//\1=100/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(MaxRetentionSec)\s*=\s*.*$/s//\1=1day/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(ForwardToConsole)\s*=\s*.*$/s//\1=no/' /etc/systemd/journald.conf \
    && sed -ri '0,/^#?\s*(MaxLevelConsole)\s*=\s*.*$/s//\1=err/' /etc/systemd/journald.conf \
    && echo 'dipayan' | passwd --stdin root \
    && echo -e "*** Welcome to interactive tty of full AlmaLinux 9 operating system running on docker! ***\n\nLogin: root\nPass: dipayan\n" > /etc/issue \
    && echo -e "\nHint: You can terminate the container by shutting the system down - run the 'halt' command\n" > /etc/motd


#Healthcheck 
HEALTHCHECK --interval=3s --timeout=2m --start-period=4s --retries=15 CMD ["/usr/bin/systemctl", "is-system-running", "--quiet"]

# This is the proper shutdown signal used by systemd init process
# Vide: https://www.freedesktop.org/software/systemd/man/systemd.html#Signals
STOPSIGNAL SIGRTMIN+4

VOLUME ["/sys/fs/cgroup", "/tmp"]

EXPOSE 22 80
USER root

CMD ["/sbin/init"]

