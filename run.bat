@echo off

cd ./docker
docker-compose down
docker-compose build
docker-compose up -d

timeout 10

@REM docker exec -it mysql-container bash
@REM mysql -u root -p12345678 < /docker-entrypoint-initdb.d/createDb.sql

@REM start firefox localhost:9001
