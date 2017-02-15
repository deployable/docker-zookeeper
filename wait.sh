#!/bin/bash

set -ue

timeout=$(( $(date +%s) + 10 ))

until [ $(date +%s) -gt $timeout ]; do
  if /zookeeper/check.sh $1; then
    echo "$1 up"
    exit 0
  else
    sleep 0.75
    echo "Waiting for $1"
  fi
done

echo "ERROR: Gave up waiting for $1"
exit 1
