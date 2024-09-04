FROM alpine:3.16.1
LABEL maintainer "Dipayan Dutta"

ENV NGINX_VERSION 1.23.1


WORKDIR /tmp

RUN apk update && \
    apk add       \
      alpine-sdk  \
      openssl-dev \
      pcre-dev    \
      zlib-dev    \
      vim         \
      busybox-extras 

RUN curl -LSs http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -O                                             && \
    tar xf nginx-${NGINX_VERSION}.tar.gz                                                                             && \
    cd     nginx-${NGINX_VERSION}                                                                                    && \
    git clone https://github.com/chobits/ngx_http_proxy_connect_module                                               && \
    patch -p1 < ./ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_102101.patch                             && \
    ./configure                                                                                                         \
      --sbin-path=/usr/sbin/nginx                                                                                       \
      --conf-path=/etc/nginx/nginx.conf                                                                                 \
      --error-log-path=/var/log/nginx/error.log                                                                         \
      --http-log-path=/var/log/nginx/access.log                                                                         \
      --pid-path=/var/run/nginx.pid                                                                                     \
      --add-module=./ngx_http_proxy_connect_module                                                                      \
      --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' && \
    make -j $(nproc)                                                                                                 && \
    make install                                                                                                     && \
    rm -rf /tmp/*


WORKDIR /

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY Dockerfile /root
EXPOSE 3128

STOPSIGNAL SIGTERM

CMD [ "nginx", "-g", "daemon off;" ]
