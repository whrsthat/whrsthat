FROM postgres

RUN mkdir -p /tmp/psql_data/

RUN chmod 777 /tmp/psql_data

COPY schema.sql /schema.sql
COPY setup.sh /docker-entrypoint-initdb.d/init_docker_postgres.sh