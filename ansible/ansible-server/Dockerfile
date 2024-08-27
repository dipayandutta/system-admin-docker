FROM rockylinux:9

ENV container=docker

RUN dnf -y update

RUN dnf install -y iputils python vim epel-release  wget telnet procps pam
RUN dnf install -y supervisor

RUN dnf -y install openssh-server openssh-clients; \
    #echo "PubkeyAcceptedKeyTypes +ssh-dss" >> ~/.ssh/config \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config; \
    ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''; \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config; \
    rm -f /run/nologin; \
    dnf clean all;
RUN ssh-keygen -A
#entrypoint.sh
RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime'; \
    echo 'echo "root:${ROOT_PASSWORD}" | chpasswd'; \
    echo 'exec "$@"'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;


ENV TIMEZONE Asia/Kolkata

ENV ROOT_PASSWORD dipayan
#RUN ssh-keygen -A

COPY supervisord.conf /etc/supervisord.d/

RUN dnf install -y ansible 


EXPOSE 22

#CMD ["/usr/bin/supervisord","-n"]
ENTRYPOINT ["/usr/local/bin/entry_point.sh"]
CMD ["/usr/sbin/sshd","-D","-e"]
