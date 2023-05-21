FROM mysql

ENV MYSQL_DATABASE="DbRestaurante" \
    MYSQL_ROOT_PASSWORD="12345678" \
    MYSQL_ROOT_HOST="root"
EXPOSE 3306

COPY ./Db/Script/createDb.sql /docker-entrypoint-initdb.d/

VOLUME Data:/var/lib/mysql