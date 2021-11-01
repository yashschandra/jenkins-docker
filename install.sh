#!/bin/bash

docker network create jenkins

docker volume create jenkins-docker-certs
docker volume create jenkins-data

docker image pull docker:dind

docker build -t jenkins-blueocean .
