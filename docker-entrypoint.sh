#!/bin/sh

if [ -z "$ZK_DATA" ]; then 
  ZK_DATA="/tmp/zookeeper"
fi

mkdir -p $ZK_DATA

if [ -n "$ZK_MYID" ]; then 
  echo "$ZK_MYID" > $ZK_DATA/myid
fi

exec "$@"

