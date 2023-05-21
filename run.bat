@echo off

cd ./docker
docker-compose down
docker-compose build
docker-compose up -d

timeout 5

docker restart mysql-container

timeout 5

docker exec -it mysql-container bash
mysql -u root -p12345678 < /docker-entrypoint-initdb.d/createDb.sql

start firefox localhost:9001
