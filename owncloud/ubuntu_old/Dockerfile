# Use a base image with the desired OS (e.g., Ubuntu, Debian, etc.)
FROM ubuntu:latest
# Install SSH server
RUN apt-get update && \
 apt-get install -y build-essential &&\
 apt-get install -y openssh-server && \
 apt-get install -y vim && \
 apt-get install -y  curl iproute2 sudo openssh-server sudo vim apache2 supervisor procps uuid-runtime
# Copy Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Create an SSH user
RUN useradd -rm -d /home/sshuser -s /bin/bash -g root -G sudo -u 1001 sshuser
# Set the SSH user's password (replace "password" with your desired password)
RUN echo 'sshuser:password' | chpasswd
# Allow SSH access
RUN mkdir /var/run/sshd
# Expose the SSH port
EXPOSE 22 80
# Start supervisord
CMD ["/usr/bin/supervisord"]
