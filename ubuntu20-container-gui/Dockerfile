FROM ubuntu:20.04

#Develop By 
LABEL maintainer = "Dipayan Dutta,System Admin"

# Add developer user and developer group
#RUN groupadd -r developer && useradd -m  developer && echo "developer:developer"| chpasswd && adduser developer sudo


# prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# update dependencies
RUN apt update
#RUN apt upgrade -y 

# Use the default UTF-8 language.
ENV LANG C.UTF-8

# Install PHP-7.2
RUN apt-get update -y && apt-get install -y libxml2-dev && apt-get -y install software-properties-common && apt-get -y install git && add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y apache2 && apt-get install -y php7.2 && apt-get install -y libapache2-mod-php7.2 php7.2-curl php7.2-json php7.2-gd  php7.2-pdo-odbc php7.2-bz2 php7.2-mongodb php7.2-dev php7.2-bcmath php7.2-mysql php7.2-mysqli php7.2-pdo php7.2-json php7.2-json php7.2-oauth  php7.2-phar php7.2-ldap php7.2-xmlreader php7.2-mbstring php7.2-zip php7.2-uploadprogress php7.2-yaml php7.2-pdo-dblib php7.2-exif php7.2-pgsql php7.2-gettext php7.2-xsl  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install sudo
RUN apt-get update -y && apt-get install sudo -y

# Install apache web application server
RUN apt-get install apache2 -y

#Add user and add to the sudo group
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install VScode
RUN apt-get update -y && apt install software-properties-common apt-transport-https wget gpg -y
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN sudo apt install code -y


# install xfce desktop
RUN apt install -y xfce4 xfce4-goodies

# install dependencies
RUN apt install -y \
  tightvncserver \
  novnc \
  net-tools \
  nano \
  vim \
  neovim \
  curl \
  wget \
  firefox \
  git \
  python3 \
  python3-pip

# xfce fixes
RUN update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# setup Chromium
RUN git clone https://github.com/scheib/chromium-latest-linux.git /chromium
RUN /chromium/update.sh

# VNC and noVNC config
ARG USER=root
ENV USER=${USER}

ARG VNCPORT=5900
ENV VNCPORT=${VNCPORT}
EXPOSE ${VNCPORT}

ARG NOVNCPORT=9090
ENV NOVNCPORT=${NOVNCPORT}
EXPOSE ${NOVNCPORT}

ARG VNCPWD=kolkatapolice@123
ENV VNCPWD=${VNCPWD}

ARG VNCDISPLAY=1920x1080
ENV VNCDISPLAY=${VNCDISPLAY}

ARG VNCDEPTH=16
ENV VNCDEPTH=${VNCDEPTH}

# setup VNC
RUN mkdir -p /root/.vnc/
RUN echo ${VNCPWD} | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
RUN echo "#!/bin/sh \n\
xrdb $HOME/.Xresources \n\
xsetroot -solid grey \n\
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" & \n\
#x-window-manager & \n\
# Fix to make GNOME work \n\
export XKL_XMODMAP_DISABLE=1 \n\
/etc/X11/Xsession \n\
startxfce4 & \n\
" > /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# setup noVNC
RUN openssl req -new -x509 -days 365 -nodes \
  -subj "/C=US/ST=IL/L=Springfield/O=OpenSource/CN=localhost" \
  -out /etc/ssl/certs/novnc_cert.pem -keyout /etc/ssl/private/novnc_key.pem \
  > /dev/null 2>&1
RUN cat /etc/ssl/certs/novnc_cert.pem /etc/ssl/private/novnc_key.pem \
  > /etc/ssl/private/novnc_combined.pem
RUN chmod 600 /etc/ssl/private/novnc_combined.pem

ENTRYPOINT [ "/bin/bash", "-c", " \
  echo 'NoVNC Certificate Fingerprint:'; \
  openssl x509 -in /etc/ssl/certs/novnc_cert.pem -noout -fingerprint -sha256; \
  vncserver :0 -rfbport ${VNCPORT} -geometry $VNCDISPLAY -depth $VNCDEPTH -localhost; \
  /usr/share/novnc/utils/launch.sh --listen $NOVNCPORT --vnc localhost:$VNCPORT \
    --cert /etc/ssl/private/novnc_combined.pem \
" ]

