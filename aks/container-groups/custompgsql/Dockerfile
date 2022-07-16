FROM postgres as base

ENV POSTGRES_PASSWORD=MyPgPassword@0
ENV POSTGRES_DB=myappdb

COPY 01.sql /docker-entrypoint-initdb.d/