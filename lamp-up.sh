#!/bin/bash

if  [ -z "$(docker image ls | grep lamp-test:v1)" ]; then
  docker build -t lamp-test:v1 .
fi

if [ -n "$(docker ps -a | grep lamp-test)" ]; then
  docker kill lamp-test
  docker rm lamp-test
fi

if [ -z "$(docker volume ls | grep vol-yii)" ]; then
  docker volume create vol-yii
fi

docker run -p 80:80 -p 3306:3306 --name lamp-test -v vol-yii:/var/lib/mysql -d lamp-test:v1
