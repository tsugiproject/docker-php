#! /bin/bash

echo "Stopping containers..."
docker stop $(docker ps -aq) > /dev/null 2>&1

echo "Cleaning up containers..."
docker rm $(docker ps -aq) > /dev/null 2>&1

echo "Cleaning up images..."
docker rmi $(docker images -q | grep tsugi) > /dev/null 2>&1

echo "Building images..."
cd base
docker build --tag tsugi_base --squash .
cd ../kube
docker build --tag tsugi_kube --squash .
cd ../mysql
docker build --tag tsugi_mysql --squash .
cd ../dev
docker build --tag tsugi_dev --squash .

