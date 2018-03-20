#! /bin/bash

docker image rm --force tsugi_dev:latest tsugi_mysql:latest tsugi_base:latest > /dev/null 2>&1
cd base
docker build --tag tsugi_base .
cd ../mysql
docker build --tag tsugi_mysql .
cd ../dev
docker build --tag tsugi_dev .

