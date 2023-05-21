@echo off

cd ./docker
docker-compose down
docker-compose build
docker-compose up -d

timeout 10

start firefox localhost:9001