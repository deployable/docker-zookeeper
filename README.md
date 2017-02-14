# Zookeeper + Cluster in Docker

Auto build of the image availale on https://hub.docker.com/r/deployable/zookeper
Dockerfile and compose definitions for single node and cluster  https://github.com/deployable/docker-zookeeper

## Start an instance

docker-compose up 

## Start a 3 node cluster

docker-compose -f docker-compose-cluster.yml up

## Build the Zookeeper image

docker build -t deployable/docker .

## About

Matt Hoyle 

