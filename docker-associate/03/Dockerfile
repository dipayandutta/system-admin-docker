ARG VERSION=16.04

FROM ubuntu:${VERSION}

RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql postgresql-client postgresql-contrib

USER postgres

RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER dipayan WITH SUPERUSER PASSWORD 'p@ssw0rd';" && \
    createdb -O dipayan dipayan

#RUN echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.3/main/pg_hba.conf

#RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf 

EXPOSE 5432

CMD ["/usr/lib/postgresql/9.3/bin/postgres","-D","/var/lib/postgresql/9.3/main","-c","config_file=/etc/postgresql/9.3/main/postgresql.conf"]
