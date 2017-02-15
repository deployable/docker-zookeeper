#!/bin/bash

set -uex

if [ "$1" == "kafka" ]; then 
  PORT=${PORT:-9092}
  HOST=${HOST:-localhost}
  res=$(echo ruok | nc $HOST $PORT)
  rc=$?
  if [ "$rc" == "0" ]; then 
    res="imok"
  fi
fi

if [ "$1" == "zookeeper" ]; then
  PORT=${PORT:-2181}
  HOST=${HOST:-localhost}
  res=$(echo ruok | nc $HOST $PORT)
  rc=$?
fi

if [ -z "$PORT" ]; then
  echo "I need a PORT to test"
  exit 1
fi

if [ "$res" != "imok" ]; then
  echo "$res"
  echo "$rc"
  exit 1
fi

