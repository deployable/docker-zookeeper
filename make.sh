#!/bin/sh

set -ue

IMG_NAMESPACE=dply
IMG_NAME=zookeeper
IMG_TAG=$IMG_NAMESPACE/$IMG_NAME
CONTAINER_NAME=zookeeper

rundir=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
canonical="$rundir/$(basename -- "$0")"

if [ -n "${1:-}" ]; then
  cmd=$1
  shift
else
  cmd=build
fi

cd "$rundir"

###

run_build(){
  build_args=${DOCKER_BUILD_ARGS:-}
  docker build $build_args -f Dockerfile -t $IMG_TAG:latest .
}

run_template(){
  template_openjdk_version=$1
  template_scala_version=$2
  template_kafka_version=$3
  perl -pe 'BEGIN {
      $openjdk_version=shift @ARGV;
      $scala_version=shift @ARGV;
      $kafka_version=shift @ARGV
    }
    s/{{openjdk_version}}/$openjdk_version/;
    s/{{kafka_version}}/$kafka_version/;
    s/{{scala_version}}/$scala_version/;
  ' $template_openjdk_version $template_scala_version $template_kafka_version Dockerfile.template > Dockerfile.$template_scala_version-$template_kafka_version
}

###

run_help(){
  echo "Commands:"
  awk '/  ".*"/{ print "  "substr($1,2,length($1)-3) }' make.sh
}

set -x

case $cmd in
  "build")     run_build "$@";;
#  "template")  run_template "$@";;
  "run")       run_run "$@";;
  '-h'|'--help'|'h'|'help') run_help;;
esac

