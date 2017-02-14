# ZooKeeper in Docker

A ZooKeeper image and compose definitions for single node and a cluster

Auto build of the image availale on https://hub.docker.com/r/deployable/zookeper

Dockerfile and compose definitions for single node and cluster  https://github.com/deployable/docker-zookeeper

# Commands

## Run a zookeeper instance

    docker run -p 2181:2181 deployable/zookeeper

## Start an compose instance

    docker-compose up 

## Start a 3 node cluster

    docker-compose -f docker-compose-cluster.yml up

## Build the Zookeeper image

    docker build -t you/docker .

### About

Matt Hoyle 

