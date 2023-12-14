FROM postgres:13

ENV POSTGRES_DB machines
ENV POSTGRES_USER root
ENV POSTGRES_PASSWORD 12Marvel

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432